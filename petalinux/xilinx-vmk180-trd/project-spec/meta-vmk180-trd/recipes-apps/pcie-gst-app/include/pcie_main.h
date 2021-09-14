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

#ifndef _PCIE_MAIN_H_
#define _PCIE_MAIN_H_

#include <stdio.h>
#include <gst/app/gstappsrc.h>
#include <gst/gst.h>
#include <string.h>
#include <gst/app/gstappsink.h>
#include <gst/allocators/gstdmabuf.h>
#include <pcie_abstract.h>
#include <gst/video/video.h>
#include <glib.h>

#define YUY2_MULTIPLIER                 2
#define INPUT_SRC                       "/dev/video4"
#define VGST_V4L2_IO_MODE_DMABUF_EXPORT 4
#define MAX_FRAME_RATE_DENOM            1
#define VIDEOPARSE_FORMAT_YUY2          "YUY2"
#define PCIE_TRANSCODE_APP_FAIL         -1
#define VGST_FILTER_KERNEL_NAME         "filter2d_pl_accel"
#define INPUT_FILE_RES_WIDTH_1080P      1920
#define INPUT_FILE_RES_HEIGHT_1080P     1080
#define APPSRC_FD_RELEASE_DELAY_DEFAULT 18000 /* 18ms */
#define APPSRC_FD_RELEASE_DELAY_1080P   5000 /* 16ms */
#define READ_DMA_EXPORT_MAP_TYPE_VAL    1

typedef struct host_params {
    guint64 length;
    guint input_format, fps, kernel_name;
    guint filter_preset, kernel_mode, usecase;
} host_params;

typedef struct _App {
    gint fd;
    guint sourceid;
    GMainLoop *loop;
    gboolean eos_flag;
    host_params h_param;
    resolution input_res;
    gchar *data, sync_val;
    dma_buf_imp dma_import;
    dma_buf_export dma_export;
    GstElement *inputsrc, *videosink, *sdxfilter2d, *perf;
    GstElement *pipeline, *pciesrc, *capsfilter, *pciesink;
    guint64 fd_release_sleep, appsrc_framecnt, appsink_framecnt;
    guint64 read_offset, total_len, yuv_frame_size, export_fd_size;
} App;

typedef enum {
    VGST_FORMAT_YUY2 = 1,
    VGST_FORMAT_MAX,
} VGST_FORMAT_TYPE;

typedef enum {
    VGST_USECASE_TYPE_NONE = 0,
    VGST_USECASE_TYPE_MIPISRC_TO_HOST,
    VGST_USECASE_TYPE_APPSRC_TO_HOST,
    VGST_USECASE_TYPE_APPSRC_TO_HOST_BYPASS,
    VGST_USECASE_TYPE_MAX,
} VGST_USECASE_TYPE;

typedef enum {
    VGST_FILTER_MODE_SW = 0,
    VGST_FILTER_MODE_HW,
    VGST_FILTER_MODE_MAX,
} VGST_FILTER_MODE;

typedef enum {
    VGST_FILTER_PRESET_BLUR = 0,
    VGST_FILTER_PRESET_EDGE,
    VGST_FILTER_PRESET_HORIZONTAL_EDGE,
    VGST_FILTER_PRESET_VERTICAL_EDGE,
    VGST_FILTER_PRESET_EMBOSS,
    VGST_FILTER_PRESET_HORIZONTAL_GRADIENT,
    VGST_FILTER_PRESET_VERICAL_GRADIENT,
    VGST_FILTER_PRESET_IDENTITY,
    VGST_FILTER_PRESET_SHARPEN,
    VGST_FILTER_PRESET_HORIZONTAL_SOBEL,
    VGST_FILTER_PRESET_VERICAL_SOBEL,
    VGST_FILTER_PRESET_MAX,
} VGST_FILTER_PRESET;

/**
 * @brief This API is required for user interactions to quit the app
 *
 * @param source GIOChannel type object
 * @param cond GIOCondition type object
 * @param data user data
 *
 * @return True on success
 */
gboolean handle_keyboard (GIOChannel* source, GIOCondition cond, App* data);

/**
 * @brief This API is to capture messages from pipeline
 *
 * @param bus GstBus type object
 * @param message contains message from bus
 * @param app user data
 *
 * @return TRUE on sucess
 */
gboolean bus_message (GstBus* bus, GstMessage* message, App* app);

/**
 * @brief This API is to configure the host parameters
 *
 * @param app user data
 *
 * @return 0 on success
 */
gint set_host_parameters(App* app);

/**
 * @brief This API is to set the gstreamer elements
 *
 * @param app user data
 *
 * @return 0 on success
 */
gint gst_set_elements(App* app);

#endif /* _PCIE_MAIN_H_ */

