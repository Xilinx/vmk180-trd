/*********************************************************************
 * Copyright (C) 2021 Xilinx, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 *
 ********************************************************************/

#include <pcie_main.h>
#include <pcie_src.h>
#include <pcie_sink.h>

App s_app;
GST_DEBUG_CATEGORY (pcie_gst_app_debug);
#define GST_CAT_DEFAULT pcie_gst_app_debug

gboolean bus_message (GstBus *bus, GstMessage *message, App *app)
{
    GError* err   = NULL;
    gchar*  debug = NULL;

    switch (GST_MESSAGE_TYPE (message)) {

        case GST_MESSAGE_ERROR:
            gst_message_parse_info (message, &err, &debug);
            GST_ERROR ("Received ERROR from %s: %s",
                GST_MESSAGE_SRC_NAME (message), err->message);
            GST_ERROR ("Debugging info: %s", (debug) ? debug : "none");
            g_error_free (err);
            g_free (debug);
            if (app->loop && g_main_loop_is_running(app->loop)) {
                g_main_loop_quit (app->loop);
                GST_ERROR ("Quitting the loop");
            }
            break;

        case GST_MESSAGE_EOS:
            if (g_main_loop_is_running (app->loop)) {
                if (app->loop) {
                    g_main_loop_quit (app->loop);
                    GST_DEBUG ("Quitting the loop");
                }
            }
            break;

        default:
            break;
    }

    return TRUE;
}

gboolean handle_keyboard (GIOChannel *source, GIOCondition cond, App *data)
{
    gchar    *str   = NULL;
    GstEvent *event = NULL;
    gboolean ret    = TRUE;

    if (g_io_channel_read_line (source, &str, NULL, NULL, NULL) != \
            G_IO_STATUS_NORMAL) {
        return FALSE;
    }

    switch (g_ascii_tolower (str[0])) {
        case 'q':
            GST_DEBUG ("Quitting the playback");
            event = gst_event_new_eos();
            if (event) {
                if (gst_element_send_event (data->pipeline, event)) {
                    data->eos_flag = TRUE;
                    GST_DEBUG ("Send an event to pipeline Succeed");
                } else {
                    GST_ERROR ("Failed to send an event to pipeline");
                    ret = FALSE;
                }
            }
    }

    g_free (str);
    return ret;
}

static GstPadProbeReturn appsink_query_cb (GstPad *pad G_GNUC_UNUSED,
             GstPadProbeInfo *info, gpointer user_data G_GNUC_UNUSED)
{
    GstQuery *query = info->data;

    if (GST_QUERY_TYPE (query) != GST_QUERY_ALLOCATION)
        return GST_PAD_PROBE_OK;

    gst_query_add_allocation_meta (query, GST_VIDEO_META_API_TYPE, NULL);

    return GST_PAD_PROBE_HANDLED;
}

static guint64 get_export_fd_size(guint64 framesize)
{
    guint   diff     = 0;
    guint   rem      = 0;
    guint   pagesize = 0;
    guint64 expfd_sz = 0;

    /* Get page size */
    pagesize = sysconf(_SC_PAGESIZE);

    /* Get reminder */
    rem = framesize % pagesize;

    if(rem != 0) {
        /* Get difference that we need to add in framesize */
        diff = pagesize - rem;

        /* Update the export fd size, so that the resultant framesize will be in
           multiple of the pagesize */
        expfd_sz = framesize + diff;
    }
    else
        expfd_sz = framesize;

    return expfd_sz;
}

gint set_host_parameters(App *app)
{
    gint ret = 0;
    /* try to open the file as an mmapped file */

    /* Get usecase type */
    app->h_param.usecase = pcie_get_usecase_type(app->fd);
    if (app->h_param.usecase >= VGST_USECASE_TYPE_MAX) {
        GST_ERROR ("Provided usecase type is not supported");
        return PCIE_TRANSCODE_APP_FAIL;
    }
    g_print("Usecase type is %d\n",app->h_param.usecase);

    /* Get input file length */
    if (app->h_param.usecase == VGST_USECASE_TYPE_APPSRC_TO_HOST ||         \
            app->h_param.usecase == VGST_USECASE_TYPE_APPSRC_TO_HOST_BYPASS) {
        app->h_param.length  = pcie_get_file_length(app->fd);
        if (app->h_param.length <= 0) {
            GST_ERROR ("Unable to get file length");
            return PCIE_TRANSCODE_APP_FAIL;
        }
        else
            g_print("Input file length is %lu\n",app->h_param.length);
    }

    /* Get input resolution */
    ret = pcie_get_input_resolution (app->fd, &app->input_res);
    if (ret < 0) {
        GST_ERROR ("Unable to get input resolution");
        return PCIE_TRANSCODE_APP_FAIL;
    }
    g_print("Resolution is %d x %d\n", app->input_res.width,
                                       app->input_res.height);

    /* Adjust export fd release time */
    app->fd_release_sleep = APPSRC_FD_RELEASE_DELAY_DEFAULT;
    if((app->input_res.width  == INPUT_FILE_RES_WIDTH_1080P) &&
       (app->input_res.height == INPUT_FILE_RES_HEIGHT_1080P))
        app->fd_release_sleep = APPSRC_FD_RELEASE_DELAY_1080P;
    GST_DEBUG ("Export fd release delay = %d", app->fd_release_sleep);

    /* Get the input fps */
    app->h_param.fps = pcie_get_fps(app->fd);
    g_print("FPS is %d\n",app->h_param.fps);

    /* Get filter-preset */
    app->h_param.filter_preset = pcie_get_filter_type(app->fd);
    if (app->h_param.filter_preset >= VGST_FILTER_PRESET_MAX) {
        GST_ERROR ("Provided filter preset is not supported");
        return PCIE_TRANSCODE_APP_FAIL;
    }
    g_print("PCIe Filter Preset is %d\n",app->h_param.filter_preset);

    /* Get format type */
    /* NOTE: Only YUY2 format is supported currently */
    app->h_param.input_format = VGST_FORMAT_YUY2;
    app->yuv_frame_size = app->input_res.width * app->input_res.height *
                              YUY2_MULTIPLIER;

    GST_DEBUG ("YUV Frame size is %lu",app->yuv_frame_size);

    /*Get Kernel mode*/
    app->h_param.kernel_mode = pcie_get_kernel_mode(app->fd);
    if (app->h_param.kernel_mode >= VGST_FILTER_MODE_MAX) {
        GST_ERROR ("Provided kernel mode is not supported");
        return PCIE_TRANSCODE_APP_FAIL;
    }
    g_print("Kernel mode is %d\n",app->h_param.kernel_mode);

    return ret;
}

gint gst_set_elements (App *app)
{
    gint ret = 0;

    app->pipeline       = gst_pipeline_new          ("pipeline");
    app->inputsrc       = gst_element_factory_make  ("v4l2src",         NULL);
    app->capsfilter     = gst_element_factory_make  ("capsfilter",      NULL);
    app->pciesrc        = gst_element_factory_make  ("appsrc",          NULL);
    app->pciesink       = gst_element_factory_make  ("appsink",         NULL);
    app->sdxfilter2d    = gst_element_factory_make  ("sdxfilter2d",     NULL);
    app->perf           = gst_element_factory_make  ("perf",            NULL);
    app->videosink      = gst_element_factory_make  ("kmssink",         NULL);
    if (!app->pipeline || !app->inputsrc  || !app->capsfilter  || \
        !app->pciesrc  || !app->pciesink  || !app->sdxfilter2d || \
        !app->perf     || !app->videosink) {
      GST_ERROR ("Unable to create required GStreamer elements");
      return PCIE_TRANSCODE_APP_FAIL;
    }
    GST_DEBUG ("Created all required GStreamer elements");

    return ret;
}

void set_property (App *app)
{
    GstCaps* srcCaps = NULL;

    if ((app->h_param.usecase == VGST_USECASE_TYPE_APPSRC_TO_HOST) ||
        (app->h_param.usecase == VGST_USECASE_TYPE_APPSRC_TO_HOST_BYPASS)) {
        GST_DEBUG ("Setting up appsrc plugin");
        g_object_set (G_OBJECT (app->pciesrc),                      \
                "stream-type", GST_APP_STREAM_TYPE_STREAM,          \
                "format",      GST_FORMAT_TIME,                     \
                "is-live",     TRUE,                                \
                "block",       TRUE,                                \
                "max-bytes",   app->yuv_frame_size,                 \
                "caps",
                       gst_caps_new_simple ("video/x-raw",
                       "format",     G_TYPE_STRING,     VIDEOPARSE_FORMAT_YUY2,\
                       "width",      G_TYPE_INT,        app->input_res.width,  \
                       "height",     G_TYPE_INT,        app->input_res.height, \
                       "framerate",  GST_TYPE_FRACTION, app->h_param.fps,      \
                                     MAX_FRAME_RATE_DENOM, NULL),              \
                NULL);
    }
    else if (app->h_param.usecase == VGST_USECASE_TYPE_MIPISRC_TO_HOST) {
        GST_DEBUG ("Setting up v4l2src plugin");
        g_object_set (G_OBJECT(app->inputsrc),                   \
                "io-mode",   VGST_V4L2_IO_MODE_DMABUF_EXPORT,    \
                "device",    INPUT_SRC,                          \ 
                NULL);
        srcCaps  = gst_caps_new_simple ("video/x-raw",                  \
                "width",     G_TYPE_INT,        app->input_res.width,   \
                "height",    G_TYPE_INT,        app->input_res.height,  \
                "format",    G_TYPE_STRING,     VIDEOPARSE_FORMAT_YUY2, \
                "framerate", GST_TYPE_FRACTION, app->h_param.fps,       \
                             MAX_FRAME_RATE_DENOM,                      \
                NULL);
        GST_DEBUG ("New Caps for src capsfilter %" GST_PTR_FORMAT, srcCaps);
        g_object_set (G_OBJECT (app->capsfilter),  "caps",  srcCaps, NULL);
        gst_caps_unref (srcCaps);
    }

    /* Configure appsink */
    g_object_set (G_OBJECT (app->pciesink), \
            "emit-signals", TRUE,           \
            "sync",         FALSE,          \
            "async",        FALSE,          \
            NULL);

    if(app->h_param.usecase != VGST_USECASE_TYPE_APPSRC_TO_HOST_BYPASS) {
        /* Configure sdxfilter2d parameters */
        GST_DEBUG ("Setting up filter2d plugin");
        g_object_set (G_OBJECT (app->sdxfilter2d),              \
                "filter-preset",  app->h_param.filter_preset,   \
                "filter-mode",    app->h_param.kernel_mode,     \
                "filter-kernel",  VGST_FILTER_KERNEL_NAME,      \
                NULL);
    }
}

gint create_pipeline (App *app)
{
    gint ret = 0;

    if (app->h_param.usecase == VGST_USECASE_TYPE_MIPISRC_TO_HOST) {
        /* mipi -> filter2d -> pciesink -> displayonhost */
        gst_bin_add_many (GST_BIN (app->pipeline), app->inputsrc,       \
                app->capsfilter, app->sdxfilter2d, app->perf,           \
                app->pciesink, NULL);
        if (gst_element_link_many (app->inputsrc, app->capsfilter,      \
                app->sdxfilter2d, app->perf, app->pciesink, NULL)       \
                != TRUE) {
            GST_ERROR ("Error linking v4l2src --> capsfilter --> "      \
                       "sdxfilter2d --> perf --> pciesink pipeline");
            ret = PCIE_TRANSCODE_APP_FAIL;
        } else{
            GST_DEBUG ("Linked v4l2src --> capsfilter --> sdxfilter2d"  \
                       " --> perf --> pciesink successfully");
        }
    }
    else if (app->h_param.usecase == VGST_USECASE_TYPE_APPSRC_TO_HOST) {
        /* pciesrc -> filter2d -> pciesink -> displayonhost */
        gst_bin_add_many (GST_BIN (app->pipeline), app->pciesrc,        \
                app->sdxfilter2d, app->perf, app->pciesink, NULL);
        if (gst_element_link_many (app->pciesrc, app->sdxfilter2d,      \
                app->perf, app->pciesink, NULL) != TRUE) {
            GST_ERROR ("Error linking pciesrc --> sdxfilter2d --> "     \
                       "perf --> pciesink pipeline");
            ret = PCIE_TRANSCODE_APP_FAIL;
        } else {
            GST_DEBUG ("Linked pciesrc --> sdxfilter2d --> perf --> "   \
                       "pciesink pipeline successfully\n");
        }
    }
    else if (app->h_param.usecase == VGST_USECASE_TYPE_APPSRC_TO_HOST_BYPASS) {
        /* pciesrc -> pciesink -> displayonhost */
        gst_bin_add_many (GST_BIN (app->pipeline), app->pciesrc,            \
                app->perf, app->pciesink, NULL);
        if (gst_element_link_many (app->pciesrc, app->perf,                 \
                app->pciesink, NULL) != TRUE) {
            GST_ERROR ("Error linking pciesrc --> perf --> "                \
                       "pciesink pipeline");
            ret = PCIE_TRANSCODE_APP_FAIL;
        } else {
            GST_DEBUG ("Linked pciesrc --> perf --> pciesink "              \
                       "pipeline successfully");
        }
    }

    return ret;
}

gint main (gint argc, gchar *argv[])
{
    App*        app      = &s_app;
    GstBus*     bus      = NULL;
    GIOChannel* io_stdin = NULL;
    ssize_t     rc       = 0;
    GstPad*     pad      = NULL;
    gint        ret      = 0;

    memset (app, 0, sizeof(App));

    gst_init (&argc, &argv);

    GST_DEBUG_CATEGORY_INIT(pcie_gst_app_debug, "pcie_gst_app", 0,
                            "PCIe endpoint device GStreamer application");

    app->fd = pcie_open();
    if (app->fd < 0) {
        g_printerr ("Unable to open device %d\n", app->fd);
        return PCIE_TRANSCODE_APP_FAIL;
    }
    GST_DEBUG ("PCIe open success, fd = %d", app->fd);

    /* Setting up the host parametes */
    ret = set_host_parameters(app);
    if (ret < 0) {
       g_printerr ("Unable to set the host parameters\n");
       goto FAIL;
    }

    /* Setting up the gst elements*/
    ret = gst_set_elements(app);
    if (ret <   0) {
        g_printerr ("Unable to set the gst elements\n");
        goto FAIL;
    }

    /* create a mainloop to get messages */
    app->loop = g_main_loop_new (NULL, TRUE);
    /* this mainloop is stopped when we receive an error or EOS */

    io_stdin = g_io_channel_unix_new (fileno (stdin));
    g_io_add_watch (io_stdin, G_IO_IN, (GIOFunc)handle_keyboard, app);
    bus = gst_pipeline_get_bus (GST_PIPELINE (app->pipeline));

    /* Register required callbacks */
    g_signal_connect(app->pciesrc,              \
                     "need-data",               \
                     G_CALLBACK(start_feed),    \
                     app);
    g_signal_connect(app->pciesrc,              \
                     "enough-data",             \
                     G_CALLBACK(stop_feed),     \
                     app);
    g_signal_connect(app->pciesink,             \
                     "new-sample",              \
                     G_CALLBACK(new_sample_cb), \
                     app);

    pad = gst_element_get_static_pad (app->pciesink, "sink");
    gst_pad_add_probe (pad, GST_PAD_PROBE_TYPE_QUERY_DOWNSTREAM,
                            appsink_query_cb,
                            NULL,
                            NULL);
    gst_object_unref (pad);

    /* create GStreamer pipeline */
    ret = create_pipeline(app);
    if (ret < 0) {
        g_printerr("Unable to create pipeline\n");
        goto FAIL;
    }

    /* add watch for messages */
    gst_bus_add_watch (bus, (GstBusFunc) bus_message, app);

    /* set Gstreamer elements properties for pipeline */
    set_property (app);

    /* set export fd size */
    app->export_fd_size = get_export_fd_size(app->yuv_frame_size);
    GST_DEBUG ("export fd size = %lu", app->export_fd_size);

    /* set map_type to get read export fd */
    ret = set_export_fd_dir(READ_DMA_EXPORT_MAP_TYPE_VAL);
    if (ret > 0) {
        g_printerr ("Error setting export fd direction: %d\n", ret);
        goto FAIL;
    }
    GST_DEBUG ("Read export fd direction set successfully");

    /* move pipeline to playing state  */
    gst_element_set_state (app->pipeline, GST_STATE_PLAYING);

    g_main_loop_run (app->loop);
    g_print("Stopping the app...\n");

    gst_element_set_state (app->pipeline, GST_STATE_NULL);

    rc = pcie_set_read_transfer_done(app->fd);
    if (rc >= 0)
        g_print("Read transfer done\n");

    rc = pcie_set_write_transfer_done(app->fd);
    if (rc >= 0)
        g_print("Write transfer done\n");

    /* clear write transfer done */
    pcie_clr_read_transfer_done(app->fd);
    /* clear read transfer done  */
    pcie_clr_write_transfer_done(app->fd);

FAIL:

    if (app->fd > 0) {
        close(app->fd);
        GST_DEBUG ("Closed PCIe FD");
        app->fd = 0;
    }

    if (bus) {
        gst_object_unref (bus);
        bus = NULL;
    }

    if (app->pipeline) {
        gst_object_unref (app->pipeline);
        app->pipeline = NULL;
    }

    if (app->loop) {
        g_main_loop_unref (app->loop);
        app->loop = NULL;
    }

    return 0;
}
