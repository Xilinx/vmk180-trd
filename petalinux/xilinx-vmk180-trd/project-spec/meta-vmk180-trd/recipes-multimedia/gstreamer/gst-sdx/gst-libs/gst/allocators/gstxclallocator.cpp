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

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "gstxclallocator.h"
#include <sys/mman.h>
#include <string.h>
#include <xrtutils.hpp>
#include <CL/cl2.hpp>
#include <gst/allocators/gstdmabuf.h>

#define GST_CAT_DEFAULT xclallocator_debug
GST_DEBUG_CATEGORY_STATIC (GST_CAT_DEFAULT);

#define GST_XCL_MEMORY_TYPE "XCLMemory"

struct _GstXclAllocatorPrivate
{
  XRTDevice *xrt_device;
  GstAllocator *dmabuf_alloc;
};

struct _xcl_bo
{
  cl_mem cl_buf;
  void *user_ptr;
  size_t size;
  cl_mem clmem;
  unsigned int refs;
};

typedef struct _GstXclMemory GstXclMemory;
typedef struct _xcl_bo xcl_bo;

struct _GstXclMemory
{
  GstMemory parent;
  xcl_bo bo;
};

#define parent_class gst_xcl_allocator_parent_class
G_DEFINE_TYPE_WITH_CODE (GstXclAllocator, gst_xcl_allocator, GST_TYPE_ALLOCATOR,
    G_ADD_PRIVATE (GstXclAllocator);
    GST_DEBUG_CATEGORY_INIT (GST_CAT_DEFAULT, "xclallocator", 0,
        "XCL allocator"));

static GstMemory *
gst_xcl_allocator_alloc (GstAllocator * allocator, gsize size,
    GstAllocationParams * params)
{
  GstXclAllocator *alloc = GST_XCL_ALLOCATOR (allocator);
  GstXclMemory *xclmem;
  GstMemory *mem;
  gint prime_fd = -1;
  cl_map_flags cl_flags = 0;
  cl_int err;
  int ret = 0;

  xclmem = g_slice_new0 (GstXclMemory);
  gst_memory_init (GST_MEMORY_CAST (xclmem), params->flags,
      GST_ALLOCATOR_CAST (alloc), NULL, size, params->align, params->prefix,
      size);

  if (GST_MAP_READ & params->flags)
    cl_flags |= CL_MAP_READ;
  if (GST_MAP_WRITE & params->flags)
    cl_flags |= CL_MAP_WRITE;

  xclmem->bo.cl_buf = clCreateBuffer (alloc->priv->xrt_device->context(), cl_flags, size, NULL, &err);
  if (err != CL_SUCCESS) {
	  GST_ERROR ("failed to create CL buffer");
	  g_slice_free(GstXclMemory, xclmem);
	  return NULL;
  }

  ret = xclGetMemObjectFd (xclmem->bo.cl_buf, &prime_fd);
  if (ret < 0 || prime_fd < 0) {
	  GST_ERROR ("failed to get DMA buffer: fd = %d, ret = %d", prime_fd, ret);
	  clReleaseMemObject(xclmem->bo.cl_buf);
	  g_slice_free(GstXclMemory, xclmem);
	  return NULL;
  }

  GST_DEBUG_OBJECT (allocator, "Alloc xclmem %p, dmabuf fd = %d", xclmem, prime_fd);

  mem = gst_dmabuf_allocator_alloc (alloc->priv->dmabuf_alloc, prime_fd, size);

  gst_mini_object_set_qdata (GST_MINI_OBJECT (mem),
      g_quark_from_static_string ("xclmem"), xclmem,
      (GDestroyNotify) gst_memory_unref);

  return (GstMemory *) mem;
}

static void
gst_xcl_allocator_free (GstAllocator * allocator, GstMemory * mem)
{
  GstXclMemory *xclmem = (GstXclMemory *) mem;

  GST_DEBUG_OBJECT (allocator, "Free xclmem %p", xclmem);

  clReleaseMemObject(xclmem->bo.cl_buf);
  g_slice_free (GstXclMemory, xclmem);

}

static void
gst_xcl_allocator_finalize (GObject * obj)
{
  GstXclAllocator *alloc = GST_XCL_ALLOCATOR (obj);

  XRTDevice::releaseXRTDevice ();

  if (alloc->priv->dmabuf_alloc)
    gst_object_unref (alloc->priv->dmabuf_alloc);

  G_OBJECT_CLASS (parent_class)->finalize (obj);
}

static void
gst_xcl_allocator_class_init (GstXclAllocatorClass * klass)
{
  GObjectClass *gobject_class;
  GstAllocatorClass *allocator_class;
  std::vector <cl::Device> devices;
  cl::Device device;

  gobject_class = G_OBJECT_CLASS (klass);
  allocator_class = GST_ALLOCATOR_CLASS (klass);

  gobject_class->finalize = gst_xcl_allocator_finalize;

  allocator_class->free = gst_xcl_allocator_free;
  allocator_class->alloc = gst_xcl_allocator_alloc;
}


static void
gst_xcl_allocator_init (GstXclAllocator * allocator)
{
  GstAllocator *alloc;

  alloc = GST_ALLOCATOR_CAST (allocator);

  allocator->priv = (GstXclAllocatorPrivate *)
      gst_xcl_allocator_get_instance_private (allocator);

  alloc->mem_type = GST_XCL_MEMORY_TYPE;
  allocator->priv->xrt_device = XRTDevice::acquireXRTDevice ();
  allocator->priv->dmabuf_alloc = gst_dmabuf_allocator_new ();

  GST_LOG_OBJECT (allocator, "xcl_handle = %p", allocator->priv->xrt_device);

  GST_OBJECT_FLAG_SET (allocator, GST_ALLOCATOR_FLAG_CUSTOM_ALLOC);
}

GstAllocator *
gst_xcl_allocator_new ()
{
  GstAllocator *alloc = NULL;

  alloc = (GstAllocator *) g_object_new (GST_TYPE_XCL_ALLOCATOR, "name",
      "XCLMemory::allocator", NULL);
  gst_object_ref_sink (alloc);
  return alloc;
}
