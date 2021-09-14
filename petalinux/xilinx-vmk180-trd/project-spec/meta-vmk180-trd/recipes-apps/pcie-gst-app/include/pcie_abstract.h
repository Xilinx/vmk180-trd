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

#ifndef _PCIE_ABSTRACT_H_
#define _PCIE_ABSTRACT_H_

#include <assert.h>
#include <fcntl.h>
#include <getopt.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <time.h>

#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <linux/dma-buf.h>
#include <glib.h>
#include <gst/gst.h>

#define DEVICE_NAME  "/dev/pciep0"

typedef struct resolution {
    guint width;
    guint height;
} resolution;

typedef struct dma_buf_export {
    gint fd;
    guint flags;
    size_t size;
} dma_buf_export;

typedef struct dma_buf_imp {
    gint32 dbuf_fd;
    gint32 dma_imp_flag;
    guint64 dma_addr;
    guint64 size;
    gint8  dir;
} dma_buf_imp;

/**
 * @brief opens pcie end point device node
 *
 * @return pcie end-point device fd
 */
gint pcie_open();

/**
 * @brief get file length of file to be transferred.
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 *
 * @return  total file length
 */
gulong pcie_get_file_length(gint fpga_fd);

/**
 * @brief read data from host using dma.
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 * @param size size of data to be transferred.
 * @param offset offset of the buffer.
 * @param buff address of the buffer to be transferred.
 *
 * @return 0 on success
 */
gint pcie_read(gint fpga_fd, gint size, gulong offset, gchar* buff);

/**
 * @brief write back data to host using dma.
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 * @param size size of data to be read.
 * @param offset offset of the buffer.
 * @param buff address of the buffer to be read.
 *
 * @return 0 on success
 */
gint pcie_write(gint fpga_fd, gint size, gint offset, gchar *buff);

/**
 * @brief set read transfer done register
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 *
 * @return 0 on success
 */
gint pcie_set_read_transfer_done(gint fpga_fd);

/**
 * @brief set write transfer done register
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 *
 * @return 0 on success
 */
gint pcie_set_write_transfer_done(gint fpga_fd);

/**
 * @brief clear read transfer done register
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 *
 * @return 0 on success
 */
gint pcie_clr_read_transfer_done(gint fpga_fd);

/**
 * @brief clear write transfer done register
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 *
 * @return 0 on success
 */
gint pcie_clr_write_transfer_done(gint fpga_fd);

/**
 * @brief  Get input resolution of file.
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 * @param input_res get instance of input resolution.
 *
 * @return input resolution
 */
gint pcie_get_input_resolution(gint fpga_fd, struct resolution* input_res);

/**
 * @brief Get kernel mode
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 *
 * @return kernel mode
 */
gint pcie_get_kernel_mode(gint fpga_fd);

/**
 * @brief Get filter type
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 *
 * @return filter type
 */
gint pcie_get_filter_type(gint fpga_fd);

/**
 * @brief Get frame rate of frames to be transferred
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 *
 * @return fps
 */
gint pcie_get_fps(gint fpga_fd);

/**
 * @brief Export dma buf type fd from user space
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 * @param dma_export dma buffer export object
 *
 * @return 0 on success
 */
gint pcie_dma_export(gint fpga_fd, struct dma_buf_export* dma_export);

/**
 * @brief Release dma_export file descriptor
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 * @param dma_export dma buffer export object
 *
 * @return 0 on success
 */
gint pcie_dma_export_release(gint fpga_fd, struct dma_buf_export* dma_export);

/**
 * @brief Import the dma buf file descriptor
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 * @param dma_import dma import object
 *
 * @return 0 on success
 */
gint pcie_dma_import(gint fpga_fd, struct dma_buf_imp* dma_import);

/**
 * @brief release Import the dma buf file descriptor
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 * @param dma_import dma import object
 *
 * @return 0 on success
 */
gint pcie_dma_import_release(gint fpga_fd, struct dma_buf_imp* dma_import);

/**
 * @brief get the supported usecase type
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 *
 * @return 0 on success
 */
gint pcie_get_usecase_type(gint fpga_fd);

/**
 * @brief set export fd direction.
 *
 * @param val 1 is for read export fd and 0 for write export fd
 *
 * @return 0 on success
 */
gint set_export_fd_dir(guint val);

/**
 * @brief closes pcie end point device node.
 *
 * @param fpga_fd pcie ep device node file  descriptor.
 */
void pcie_close(gint fpga_fd);

#endif //_PCIE_ABSTRACT_H_
