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

#include "xclfilter2d.h"
#include <string.h>
#include <sys/time.h>
#include <xrtutils.hpp>
#include <CL/cl2.hpp>

#define F2D_AIE_HEIGHT              720
#define F2D_AIE_WIDTH               1280
#define F2D_MAX_KERNEL_NAME_SIZE    64

#define F2D_MAKE_FOURCC(a, b, c, d)                                           \
  ((unsigned int)(a) | ((unsigned int)(b)) << 8 | ((unsigned int)(c)) << 16 | \
   ((unsigned int)(d)) << 24)
//#define ENABLE_DEBUG_LOGS
#ifdef ENABLE_DEBUG_LOGS
#define DEBUG_PRINT(f, ...) fprintf(stderr, f, ##__VA_ARGS__)
#else
#define DEBUG_PRINT(f, ...) (void)0
#endif

#ifdef MEASURE_TIME_PERFORMANCE
int count = 0;
uint64_t sum1 = 0, sum2 = 0;
#endif

typedef struct
{
  XRTInstance *handle;
  uint32_t in_fourcc;
  uint32_t out_fourcc;
  cl::Buffer * filter_coeff;
  cl::Buffer * imageFromDevice;
  cl::Buffer * imageToDevice;
  cl::Kernel * kernel;
  char kernel_name[F2D_MAX_KERNEL_NAME_SIZE];
} filter2d_priv;

static inline int
get_buffer_size (int width, int height, uint32_t fourcc)
{
  switch (fourcc) {
    case F2D_MAKE_FOURCC ('Y', 'U', 'Y', 'V'):
    case F2D_MAKE_FOURCC ('U', 'Y', 'V', 'Y'):
      return (width * height * 2);
    default:
      return 0;
  }
}

int
filter2d_init_sds (char *kernel_name, size_t in_height, size_t in_width,
    size_t out_height, size_t out_width, uint32_t in_fourcc,
    uint32_t out_fourcc, void **priv)
{
  filter2d_priv *f2d = (filter2d_priv *) malloc (sizeof (filter2d_priv));
  f2d->handle = XRTInstance::getInstance (kernel_name);
  cl::Context clcontext = f2d->handle->getContext ();
  f2d->in_fourcc = in_fourcc;
  f2d->out_fourcc = out_fourcc;
  f2d->kernel = new cl::Kernel (*(f2d->handle->program), kernel_name);
  f2d->filter_coeff =
      new cl::Buffer (clcontext, CL_MEM_READ_ONLY, (KSIZE * KSIZE * 2));
  f2d->imageFromDevice =
      new cl::Buffer (clcontext, CL_MEM_READ_WRITE,
      get_buffer_size (in_width, in_height, f2d->in_fourcc));
  f2d->imageToDevice =
      new cl::Buffer (clcontext, CL_MEM_READ_WRITE,
      get_buffer_size (out_width, out_height, f2d->out_fourcc));
  *priv = f2d;
  sprintf (f2d->kernel_name, "%s", kernel_name);

  if (!strcmp (f2d->kernel_name, "filter2d_aie_accel")) {
    printf ("coefficients currently not supported in aie mode\n");
    if ((in_height != F2D_AIE_HEIGHT) && (in_width != F2D_AIE_WIDTH)) {
      printf ("unsupported resolution for aie kernel");
      return -1;
    }
  }

  DEBUG_PRINT ("f2d = %p, xrt_instance = %p\n", f2d, f2d->handle);

  return 0;
}

void
filter2d_deinit_sds (void *priv)
{
  filter2d_priv *f2d = (filter2d_priv *) priv;
  XRTInstance::releaseInstance (f2d->kernel_name);
  delete f2d->filter_coeff;
  delete f2d->imageFromDevice;
  delete f2d->imageToDevice;
  delete f2d->kernel;
  free (f2d);
}

void
filter2d_sds (xrt_mapping_buffer * inbuf, xrt_mapping_buffer * outbuf,
    int height, int width, const coeff_t coeff, void *priv)
{
  filter2d_priv *f2d = (filter2d_priv *) priv;
  XRTInstance *handle = f2d->handle;
  cl::Device cldevice = handle->getDevice ();
  cl::Context clcontext = handle->getContext ();
  cl::CommandQueue * cmd_queue = handle->getCmdQueue ();
  cl::Kernel * kernel = f2d->kernel;
  cl_mem in_dmabuf;
  cl_mem out_dmabuf;
  uint16_t arg = 0;

#ifdef MEASURE_TIME_PERFORMANCE
  struct timespec start1, start2, t1, end;
  clock_gettime (CLOCK_MONOTONIC_RAW, &start1);
#endif

  if (inbuf->buf_type == BUFFER_TYPE_DMA) {
    DEBUG_PRINT ("Importing input dma-buf fd : %u\n",
        inbuf->buf_obj.dma_buf.fd);
    xclGetMemObjectFromFd (clcontext (), cldevice (), 0,
        inbuf->buf_obj.dma_buf.fd, &in_dmabuf);
    kernel->setArg (arg++, sizeof (cl_mem), (void *) &in_dmabuf);
  } else if (inbuf->buf_type == BUFFER_TYPE_XCL) {
    DEBUG_PRINT ("Unsupported buffer type at input, returning\n");
    return;
  } else {
    DEBUG_PRINT ("Copy input VMA buffer to XRT Buffer\n");
    cmd_queue->enqueueWriteBuffer (*(f2d->imageToDevice), CL_TRUE, 0,
        get_buffer_size (width, height, f2d->in_fourcc),
        inbuf->buf_obj.vma_buf.user_ptr);
    kernel->setArg (arg++, *(f2d->imageToDevice));
  }

  if (outbuf->buf_type == BUFFER_TYPE_DMA) {
    DEBUG_PRINT ("Importing output dma-buf fd : %u\n",
        outbuf->buf_obj.dma_buf.fd);
    xclGetMemObjectFromFd (clcontext (), cldevice (), 0,
        outbuf->buf_obj.dma_buf.fd, &out_dmabuf);
    kernel->setArg (arg++, sizeof (cl_mem), (void *) &out_dmabuf);
  } else if (outbuf->buf_type == BUFFER_TYPE_XCL) {
    DEBUG_PRINT ("Unsupported buffer type at output, returning\n");
    return;
  } else {
    kernel->setArg (arg++, *(f2d->imageFromDevice));
  }

  cmd_queue->enqueueWriteBuffer (*(f2d->filter_coeff), CL_TRUE, 0,
      (KSIZE * KSIZE * 2), (short int *) coeff);

  if (!strcmp (f2d->kernel_name, "filter2d_pl_accel")) {
    kernel->setArg (arg++, *(f2d->filter_coeff));
  }

  kernel->setArg (arg++, height);
  kernel->setArg (arg++, width);
  kernel->setArg (arg++, f2d->in_fourcc);
  kernel->setArg (arg++, f2d->out_fourcc);

#ifdef MEASURE_TIME_PERFORMANCE
  clock_gettime (CLOCK_MONOTONIC_RAW, &start2);
#endif

  cl::Event event_sp;
  cmd_queue->enqueueTask (*(kernel), NULL, &event_sp);
  clWaitForEvents (1, (const cl_event *) &event_sp);

  if (outbuf->buf_type != BUFFER_TYPE_DMA &&
      outbuf->buf_type != BUFFER_TYPE_XCL) {
    DEBUG_PRINT ("Copy output VMA buffer to XRT Buffer\n");
    cmd_queue->enqueueReadBuffer (*(f2d->imageFromDevice), CL_TRUE, 0,
        get_buffer_size (width, height, f2d->out_fourcc),
        outbuf->buf_obj.vma_buf.user_ptr);
  }

  if (inbuf->buf_type == BUFFER_TYPE_DMA)
    clReleaseMemObject (in_dmabuf);
  if (outbuf->buf_type == BUFFER_TYPE_DMA)
    clReleaseMemObject (out_dmabuf);

#ifdef MEASURE_TIME_PERFORMANCE
  clock_gettime (CLOCK_MONOTONIC_RAW, &end);

  uint64_t delta_us1 = (end.tv_sec - start1.tv_sec) * 1000000 +
      (end.tv_nsec - start1.tv_nsec) / 1000;
  uint64_t delta_us2 = (end.tv_sec - start2.tv_sec) * 1000000 +
      (end.tv_nsec - start2.tv_nsec) / 1000;

  count++;
  sum1 = sum1 + delta_us1;
  sum2 = sum2 + delta_us2;

  if (count == 100) {
    DEBUG_PRINT ("Frame delta1 = %ld, delta2 = %ld\n", sum1 / count,
        sum2 / count);
    count = 0;
    sum1 = 0;
    sum2 = 0;
  }
#endif
}
