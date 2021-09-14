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

#include <pcie_src.h>

GST_DEBUG_CATEGORY_EXTERN (pcie_gst_app_debug);
#define GST_CAT_DEFAULT pcie_gst_app_debug

gboolean feed_data (GstElement *pciesrc, guint size, App *app)
{
    GstBuffer*    buffer     = NULL;
    GstMemory*    memory     = NULL;
    GstAllocator* allocator  = NULL;
    gint          ret        = 0;

    app->appsrc_framecnt++;

    if (app->read_offset >= app->h_param.length) {
        if(!app->eos_flag) {
          g_signal_emit_by_name (app->pciesrc, "end-of-stream", &ret);
          app->eos_flag = TRUE;
          GST_DEBUG ("Emitting EOS");
        }
        return TRUE;
    }

    buffer = gst_buffer_new ();
    app->dma_export.fd = 0;
    app->dma_export.size = app->export_fd_size;

    GST_DEBUG ("Appsrc: frame-count - %lu", app->appsrc_framecnt);

    /* request driver to export fd */
    ret = pcie_dma_export(app->fd, &app->dma_export);
    if (ret < 0) {
        GST_ERROR ("Unable to Export the dma buf fd");
        return FALSE;
    }
    GST_DEBUG ("Appsrc: dmabuf fd - %d", app->dma_export.fd);

    /* trigger dma transfer */
    pcie_read(app->fd, app->yuv_frame_size, 0, NULL);

    allocator = gst_dmabuf_allocator_new ();

    /* allocate dmabuf type memory */
    memory = gst_dmabuf_allocator_alloc (allocator,
                                         app->dma_export.fd,
                                         app->dma_export.size);
    if(!memory) {
        GST_ERROR ("Not able to allocate dma type memory");
        return FALSE;
    }

    /* check if the momory is dmabuf type or not */
    if (gst_is_dmabuf_memory (memory)) {
        GST_DEBUG ("Appsrc: allocated memory is dmabuf type");
    } else {
        GST_ERROR ("Appsrc: allocated Memory is non-dmabuf type");
        return FALSE;
    }

    /* Update the valid data, when export fd size and frame size is different */
    if(app->dma_export.size != app->yuv_frame_size)
        memory->size = app->yuv_frame_size;

    /* Add memory to buffer */
    gst_buffer_append_memory(buffer,memory);

    /* Get buffer timestamp */
    GST_BUFFER_TIMESTAMP(buffer) = (GstClockTime)
        ((app->appsrc_framecnt/(float)app->h_param.fps) * 1e9);

    /* Push buffer to next element */
    g_signal_emit_by_name (app->pciesrc, "push-buffer", buffer, &ret);
    if(ret != GST_FLOW_OK) {
        GST_ERROR ("Push-buffer failed, frame-count - %lu, error - %d",
                  app->appsrc_framecnt, ret);
    }

    app->read_offset += app->yuv_frame_size;

    /* NOTE: When we use dma export/import in main loop, we get
             XRT related issues with pciesrc -> filter2d -> pciesink
             pipeline, and when we use inside this callback we
             see green strip & green frames issue on Display. By
             Keeping below delay we have not observed the green
             frames issue. */
    usleep(app->fd_release_sleep);

    /* release exported fd */
    ret = pcie_dma_export_release(app->fd, &app->dma_export);
    if (ret < 0)
        GST_ERROR ("Appsrc: Unable to release exported fd - %d",
                   app->dma_export.fd);

    gst_buffer_unref (buffer);
    gst_object_unref(allocator);

    return TRUE;
}

void start_feed (GstElement *source, guint size, App *data)
{
    if (data->sourceid == 0) {
        GST_DEBUG ("Start feeding at frame %lu", data->appsrc_framecnt);
        data->sourceid = g_idle_add ((GSourceFunc) feed_data, data);
    }
}

void stop_feed (GstElement *source, App *data)
{
    if (data->sourceid != 0) {
        GST_DEBUG ("Stop feeding at frame %lu", data->appsrc_framecnt);
        g_source_remove (data->sourceid);
        data->sourceid  = 0;
    }
}
