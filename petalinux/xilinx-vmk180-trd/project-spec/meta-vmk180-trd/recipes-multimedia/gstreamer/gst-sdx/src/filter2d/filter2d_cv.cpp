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

/* Temporary fix for SDx Clang issue */
#ifdef __SDSCC__
#undef __ARM_NEON__
#undef __ARM_NEON
#include <opencv2/core.hpp>
#include <opencv2/imgproc.hpp>
#define __ARM_NEON__
#define __ARM_NEON
#else
#include <opencv2/core.hpp>
#include <opencv2/imgproc.hpp>
#endif
#include <linux/videodev2.h>

#ifdef SDSOC_ENV
#include <filter2d_sds.h>
#else
#include "xclfilter2d.h"
#endif

struct filter2d_format
{
  uint32_t in_fourcc;
  uint32_t out_fourcc;
};

int
filter2d_init_cv (size_t in_height, size_t in_width, size_t out_height,
    size_t out_width, uint32_t in_fourcc, uint32_t out_fourcc, void **priv)
{
  struct filter2d_format *f2f =
      (struct filter2d_format *) malloc (sizeof (struct filter2d_format));
  if (f2f == NULL) {
    return -1;
  }

  f2f->in_fourcc = in_fourcc;
  f2f->out_fourcc = out_fourcc;

  *priv = f2f;

  return 0;
}

void
filter2d_deinit_cv (void *priv)
{
  struct filter2d_format *f2f = (struct filter2d_format *) priv;
  free (f2f);
}

using namespace cv;

void
filter2d_cv (unsigned short *frm_data_in, unsigned short *frm_data_out,
    int height, int width, const coeff_t coeff, void *priv)
{
  struct filter2d_format *f2f = (struct filter2d_format *) priv;

  int yiloc = (V4L2_PIX_FMT_YUYV == f2f->in_fourcc) ? 0 : 1;
  int ciloc = (V4L2_PIX_FMT_YUYV == f2f->in_fourcc) ? 1 : 0;
  int yuyvout = (V4L2_PIX_FMT_YUYV == f2f->out_fourcc);

  Mat src (height, width, CV_8UC2, frm_data_in);
  Mat dst (height, width, CV_8UC2, frm_data_out);

  // planes
  std::vector < Mat > iplanes;
  std::vector < Mat > oplanes;

  // convert kernel from short to int
  int coeff_i[KSIZE][KSIZE];
  for (int i = 0; i < KSIZE; i++)
    for (int j = 0; j < KSIZE; j++)
      coeff_i[i][j] = coeff[i][j];
  Mat kernel = Mat (KSIZE, KSIZE, CV_32SC1, (int *) coeff_i);

  // anchor
  Point anchor = Point (-1, -1);

  // filter
  split (src, iplanes);
  filter2D (iplanes[yiloc], iplanes[yiloc], -1, kernel, anchor, 0,
      BORDER_DEFAULT);

  if (yuyvout) {
    oplanes.push_back (iplanes[yiloc]);
    oplanes.push_back (iplanes[ciloc]);
  } else {
    oplanes.push_back (iplanes[ciloc]);
    oplanes.push_back (iplanes[yiloc]);
  }
  merge (oplanes, dst);
}
