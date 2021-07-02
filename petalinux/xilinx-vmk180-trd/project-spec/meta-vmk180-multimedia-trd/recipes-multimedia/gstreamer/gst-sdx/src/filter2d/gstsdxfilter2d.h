/*
 * Copyright (C) 2017 – 2018 Xilinx, Inc.  All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * XILINX BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * Except as contained in this notice, the name of the Xilinx shall not be used
 * in advertising or otherwise to promote the sale, use or other dealings in
 * this Software without prior written authorization from Xilinx.
 */

#ifndef __GST_SDXFILTER2D_H__
#define __GST_SDXFILTER2D_H__

#include <gst/base/gstsdxbase.h>

G_BEGIN_DECLS

#define GST_TYPE_SDX_FILTER2D \
  (gst_sdx_filter2d_get_type())
#define GST_SDX_FILTER2D(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj),GST_TYPE_SDX_FILTER2D,GstSdxFilter2d))
#define GST_SDX_FILTER2D_CLASS(klass) \
  (G_TYPE_CHECK_CLASS_CAST((klass),GST_TYPE_SDX_FILTER2D,GstSdxFilter2dClass))
#define GST_IS_SDX_FILTER2D(obj) \
  (G_TYPE_CHECK_INSTANCE_TYPE((obj),GST_TYPE_SDX_FILTER2D))
#define GST_IS_SDX_FILTER2D_CLASS(klass) \
  (G_TYPE_CHECK_CLASS_TYPE((klass),GST_TYPE_SDX_FILTER2D))

typedef enum
{
  GST_SDXFILTER2D_PRESET_BLUR,
  GST_SDXFILTER2D_PRESET_EDGE,
  GST_SDXFILTER2D_PRESET_HEDGE,
  GST_SDXFILTER2D_PRESET_VEDGE,
  GST_SDXFILTER2D_PRESET_EMBOSS,
  GST_SDXFILTER2D_PRESET_HGRAD,
  GST_SDXFILTER2D_PRESET_VGRAD,
  GST_SDXFILTER2D_PRESET_IDENTITY,
  GST_SDXFILTER2D_PRESET_SHARPEN,
  GST_SDXFILTER2D_PRESET_HSOBEL,
  GST_SDXFILTER2D_PRESET_VSOBEL,
} GstSdxfilter2dFilterPreset;

typedef struct
{
  GstSdxBase parent;
  GstSdxfilter2dFilterPreset filter_preset;
  gint16 *coefficients;
  void *sds_data;
  void *cv_data;
  const gchar *kernel;
} GstSdxFilter2d;

typedef struct
{
  GstSdxBaseClass parent_class;
} GstSdxFilter2dClass;

GType gst_sdx_filter2d_get_type(void);

G_END_DECLS

#endif /* __GST_SDXFILTER2D_H__ */
