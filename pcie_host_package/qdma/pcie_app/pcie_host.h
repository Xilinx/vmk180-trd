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

#ifndef PCIE_HOST_APP_CIRC_H
#define PCIE_HOST_APP_CIRC_H
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct circular_buffer
{
char *buffer;
char *buffer_end;
size_t capacity;
size_t index;
size_t sz;
char *head;
char *tail;
} circular_buffer;

extern "C"{
extern circular_buffer queue_frame;
extern bool app_running;
/**
 * test_dma : Function initializes dma write and read  transactions from host to channel and channel to host respectively as per below.
 * a. Opens qdma device file of h2c,c2h and  resource0, initializes three threads.
 * b. Creates a shared memory map of PCIe Bar memory register.
 * c. Get file size of input file and initializes frame queues.
 * d. Initializes three threads.  
 * Thread1 : To read input file.
 * Thread2 : To PCIe dma read.
 * Thread3 : To PCIe dma write.
 * @h2c_device :  qdma host to channel device node for dma write transaction.
 * @c2h_device : qdma channel to host device node for dma read transaction.
 * @infname : file to be  transferred between host and channel for dma transaction.
 */
static int test_dma(char *h2c_device, char *c2h_device, char *infname);
/**
 * pcie_dma_read :  Thread function to start dma write transaction from host to channel.
 * @vargp : takes nothing as argument.
 */
void *pcie_dma_read(void * vargp);
/**
 * pcie_dma_write : Thread function to start dma read transaction from channel to host.
 * @vargp : takes nothing as argument.
 */
void *pcie_dma_write(void * vargp);
/**
 * file_read : Read input file and strat dma transaction between channel and host.
 */
void *file_read(void * vargp);
int cb_deque(circular_buffer *cb, char *data);
int cmaincall(int argc, char *argv[]);

}
#endif // PCIE_HOST_APP_H
