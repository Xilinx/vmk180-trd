/*
 * Copyright (C) 2020 Xilinx, Inc.  All rights reserved.
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

#ifndef INCLUDE_PCIE_ABSTRAINCLUDE_PCIE_SRC_C_CT_H_
#define INCLUDE_PCIE_ABSTRACT_H_

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
#define DEVICE_NAME  "/dev/pciep0"
#define SIZE_DEFAULT 8388608
typedef struct resolution {
    unsigned int      width;
    unsigned int      height;
} resolution;

/** pcie_open : opens pcie end point device node 
 */
int pcie_open();
/**
 * pcie_get_file_length - get file length of file to be transferred.
 * @fpga_fd : pcie ep device node file  descriptor.
 */
unsigned long int pcie_get_file_length(int fpga_fd);
/**
 * pcie_read: read data from host using dma.
 * @fpga_fd : pcie ep device node file  descriptor.
 * @size : size of data to be transferred.
 * @offset : offset of the buffer.
 * @buff : address of the buffer to be transferred.
 */

int pcie_read(int fpga_fd, int size, unsigned long int offset, char *buff);
/**
 * pcie_write : write back data to host using dma.
 * @fpga_fd : pcie ep device node file  descriptor.
 * @size : size of data to be read.
 * @offset : offset of the buffer.
 * @buff : address of the buffer to be read.
 */      
int pcie_write(int fpga_fd, int size, int offset, char *buff);
/**
 * pcie_set_read_transfer_done : set read transfer bit done
 * @fpga_fd : pcie ep device node file  descriptor.
 * @value : value to be set for read transfer done
 */ 
int pcie_set_read_transfer_done(int fpga_fd, int value);
/**
 * pcie_set_write_transfer_done : set write transfer bit done
 * @fpga_fd : pcie ep device node file  descriptor.
 * @value : value to be set for write transfer done
 */ 
int pcie_set_write_transfer_done(int fpga_fd, int value);
/**
 * pcie_get_input_resolution : Get input resolution of file.
 *  @fpga_fd : pcie ep device node file  descriptor.
 *  @input_res : get instance of input resolution.
 */
int pcie_get_input_resolution(int fpga_fd, struct resolution *input_res);
/**
 * pcie_get_kernl_mode : get kernel mode.
 * @fpga_fd : pcie ep device node file  descriptor.
 */ 
int pcie_get_kernl_mode(int fpga_fd);
/**
 * pcie_get_filter_type : get filter type
 * @fpga_fd : pcie ep device node file  descriptor.
 */
int pcie_get_filter_type(int fpga_fd);
/**
 * pcie_get_fps : get frame rate of frames to be transferred.
 * @fpga_fd : pcie ep device node file  descriptor.
 */  
int pcie_get_fps(int fpga_fd);
/**
 * pcie_get_format : get format of file to be transferred.
 *  @fpga_fd : pcie ep device node file  descriptor.
 */
int pcie_get_format(int fpga_fd);
/**
 * pcie_close : closes pcie end point device node.
 * @fpga_fd : pcie ep device node file  descriptor to be closed.
 */ 
void pcie_close(int fpga_fd);

#endif //INCLUDE_PCIE_ABSTRACT_H_
