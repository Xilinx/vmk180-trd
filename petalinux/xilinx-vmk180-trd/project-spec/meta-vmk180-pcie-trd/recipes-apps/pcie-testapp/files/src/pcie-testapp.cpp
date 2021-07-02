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

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <iostream>
#include <sys/stat.h>
#include <CL/cl.h>
#include "xcl2.hpp"
#include <opencv2/opencv.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <string>
#include "cl_ext_xilinx.h"
#include "pcie_abstract.h"

#define SUCCESS 0
#define FAIL -1
#define MAP_SZ (3840 * 2160 * 2)
#define KSIZE 3
#define ALLOC_DMA_BUFF            0xe
#define RELEASE_DMA_BUFF          0xf
#define DIRECT_COPY          	  0x1a


typedef short int coeff_t[KSIZE][KSIZE];

struct pciep_alloc_dma_buf {
    int fd;   /* fd */
    unsigned int flags;/* flags to map with */
    size_t size; /* size */
};

typedef enum
{
    GST_SDXFILTER2D_PRESET_NONE,
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
} FilterType;

static const coeff_t coeffs[] = {
    [GST_SDXFILTER2D_PRESET_NONE] = {{0}},
    [GST_SDXFILTER2D_PRESET_BLUR] = {
	{1, 1, 1},
	{1, -7, 1},
	{1, 1, 1}
    },
    [GST_SDXFILTER2D_PRESET_EDGE] = {
	{0, 1, 0},
	{1, -4, 1},
	{0, 1, 0}
    },
    [GST_SDXFILTER2D_PRESET_HEDGE] = {
	{0, -1, 0},
	{0, 2, 0},
	{0, -1, 0}
    },
    [GST_SDXFILTER2D_PRESET_VEDGE] = {
	{0, 0, 0},
	{-1, 2, -1},
	{0, 0, 0}
    },
    [GST_SDXFILTER2D_PRESET_EMBOSS] = {
	{-2, -1, 0},
	{-1, 1, 1},
	{0, 1, 2}
    },
    [GST_SDXFILTER2D_PRESET_HGRAD] = {
	{-1, -1, -1},
	{0, 0, 0},
	{1, 1, 1}
    },
    [GST_SDXFILTER2D_PRESET_VGRAD] = {
	{-1, 0, 1},
	{-1, 0, 1},
	{-1, 0, 1}
    },
    [GST_SDXFILTER2D_PRESET_IDENTITY] = {
	{0, 0, 0},
	{0, 1, 0},
	{0, 0, 0}
    },
    [GST_SDXFILTER2D_PRESET_SHARPEN] = {
	{0, -1, 0},
	{-1, 5, -1},
	{0, -1, 0}
    },
    [GST_SDXFILTER2D_PRESET_HSOBEL] = {
	{1, 2, 1},
	{0, 0, 0},
	{-1, -2, -1}
    },
    [GST_SDXFILTER2D_PRESET_VSOBEL] = {
	{1, 0, -1},
	{2, 0, -2},
	{1, 0, -1}
    }
};

int write_to_file(char *path, unsigned int val) {

    FILE *fp;
    int ret;

    fp = fopen(path, "wb");
    if (fp == NULL) {
	printf("Error opening file : %s\n", path);
	return FAIL;
    }

    ret = fprintf(fp, "%d\n", val);
    if (ret <= 0) {
	printf("Unable to set clock value\n");
	fclose(fp);
	return FAIL;
    }

    fclose(fp);

    return SUCCESS;
}

int main()
{
    struct pciep_alloc_dma_buf dma_buf_rd;
    struct pciep_alloc_dma_buf dma_buf_wr;
    struct resolution input_res;
    uint8_t *inp_buf;
    uint8_t *out_buf;
    char SYSFS_PATH[100] = "/sys/class/pciep/pciep0/device/map_type";
    short int kdata[KSIZE][KSIZE];
    unsigned long int length;
    unsigned int iter;
    unsigned int size;
    int fd;
    int ret = 0;
    int i = 0;
    int value;
    int width;
    int height;
    int filter_type;
    int fourcc = 0x56595559; //YUYV
    int chan = 2;
    cl_mem in_dmabuf;
    cl_mem out_dmabuf;
    cl_int err;

    /* Find the xilinx device */
    std::vector<cl::Device> devices = xcl::get_xil_devices();
    cl::Device device = devices[0];
    cl::Context context(device);

    cl::Buffer kernelFilterToDevice(context, CL_MEM_READ_ONLY, sizeof(short int) * 9, NULL, &err);
    /* create the command queue */
    cl::CommandQueue q(context, device, CL_QUEUE_PROFILING_ENABLE, &err);
    /* load the xclbin file */
    std::string device_name = device.getInfo<CL_DEVICE_NAME>();
    std::string binaryFile = xcl::find_binary_file(device_name,"binary_container_1");
    auto fileBuf = xcl::read_binary_file(binaryFile);
    cl::Program::Binaries bins{{fileBuf.data(), fileBuf.size()}};

    //cl::Program::Binaries bins = xcl::import_binary_file(binaryFile);
    devices.resize(1);
    cl::Program program(context, devices, bins);
    cl::Kernel krnl(program,"filter2d_pl_accel");

    /* open pciep device */
    fd = pcie_open();
    if (fd < 0) {
	printf("Invalid file descriptor\n");
	return FAIL;
    }
    filter_type = pcie_get_filter_type(fd);
    if (filter_type < 0) {
	printf("Could not get filter type\n");
	ret = FAIL;
	return err;
    }
    /* allocate and map read buffer */
    ret = write_to_file(SYSFS_PATH, 1);
    if (ret != 0) {
	printf("Error writting to sysfs path: %d\n", ret);
	pcie_close(fd);
	return FAIL;
    }
    dma_buf_rd.size = (3840 * 2160 * 2); 
    dma_buf_rd.fd = 0;

    ret = ioctl(fd, ALLOC_DMA_BUFF, &dma_buf_rd);
    if (ret < 0) {
	printf("read alloc ioctl for DMA-BUF failed with %d\n", ret);
	pcie_close(fd);
	return FAIL;
    }
    /* map size of memory */
    inp_buf = (uint8_t *)mmap(0, dma_buf_rd.size, PROT_READ | PROT_WRITE,
	    MAP_SHARED, dma_buf_rd.fd, 0);
    if (inp_buf == MAP_FAILED) {
	printf("Error mmapping the input buffer \n");
	ret = FAIL;
	goto err_rmap;
    }
    /*Allocate wirte buffers only when using with filter*/
    if (filter_type > 0) {
	/* allocate and map write buffer */
	ret = write_to_file(SYSFS_PATH, 0);
	if (ret != 0) {
	    printf("Error writting to sysfs path: %d\n", ret);
	    ret = FAIL;
	    goto err_wsys;
	}
	dma_buf_wr.fd = 0;
	dma_buf_wr.size = (3840 * 2160 * 2);

	ret = ioctl(fd, ALLOC_DMA_BUFF, &dma_buf_wr);
	if (ret < 0) {
	    printf("write alloc ioctl for DMA-BUF failed\n");
	    ret = FAIL;
	    goto err_wsys;
	}
	/* map size of memory */
	out_buf = (uint8_t *)mmap(0, dma_buf_wr.size, PROT_READ | PROT_WRITE,
		MAP_SHARED, dma_buf_wr.fd, 0);
	if (out_buf == MAP_FAILED) {
	    printf("Error mmapping the write buffer\n");
	    ret = FAIL;
	    goto err_wmap;
	}
    }

    length = pcie_get_file_length(fd);
    if (length < 0) {
	printf("Could not get file length\n");
	ret = FAIL;
	return err;
    }

    ret = pcie_get_input_resolution(fd, &input_res);
    if (ret < 0) {
	printf("Could not get resolution\n");
	ret = FAIL;
	return err;
    }

    memcpy(kdata, coeffs[filter_type], sizeof(kdata));

    size = (input_res.width * input_res.height * 2);
    iter = (length / size);

    height = input_res.height;
    width = input_res.width;
  /*Required only when using no filter*/	
    if (filter_type == 0) {
	printf("No filter \n");
	ret = ioctl(fd, DIRECT_COPY, NULL);
	if (ret < 0) {
	    printf("direct copy ioctl failed\n");
	    ret = FAIL;
	    goto err_wsys;
	}
    }
    i = 0;
    while(i < iter) {
	/* read data from the host */
	ret = pcie_read(fd, size, 0, NULL);
	if (ret < 0) {
	    printf("read failed count for iter %d : ret : %d\n", i, ret);
	    ret = FAIL;
	    goto err1;
	}
	/* Get address of read fd */
	write_to_file(SYSFS_PATH, 1);
	/*Only for with filter */
	if (filter_type > 0 ) {
	    xclGetMemObjectFromFd(context(), device(), 0, dma_buf_rd.fd, &in_dmabuf);
	    /* enqueue filter coefficients */
	    q.enqueueWriteBuffer(kernelFilterToDevice, CL_TRUE, 0, sizeof(short int) * 9, (short int *)kdata);
	    /* Get address of write fd */
	    write_to_file(SYSFS_PATH, 0);
	    xclGetMemObjectFromFd(context(), device(), 0, dma_buf_wr.fd, &out_dmabuf); 

	    /* Set the kernel arguments */
	    krnl.setArg(0, sizeof (cl_mem), (void *) &in_dmabuf);
	    krnl.setArg(1, sizeof (cl_mem), (void *) &out_dmabuf);
	    krnl.setArg(2, kernelFilterToDevice);
	    krnl.setArg(3, height);
	    krnl.setArg(4, width);
	    krnl.setArg(5, fourcc); //fourcc in
	    krnl.setArg(6, fourcc); //fourcc out

	    /* Profiling Objects */
	    cl::Event event_sp;

	    /* Launch the kernel */
	    q.enqueueTask(krnl, NULL, &event_sp);
	    clWaitForEvents(1, (const cl_event*) &event_sp);

	} 
	/* write data back to host */
	ret = pcie_write(fd, size, 0, NULL);
	if (ret < 0) {
	    printf("write failed count for iter %d : ret : %d\n", i, ret);
	    ret = FAIL;
	    goto err1;
	}

	i++;
    }
err1:
    q.finish();
err:
    if (filter_type == 0)
	goto err_wsys; 
    ret = write_to_file(SYSFS_PATH, 0);
    if (ret != 0) {
	printf("Error writting to sysfs path: %d\n", ret);
    }

    munmap(out_buf, size);
err_wmap:
    if (filter_type > 0) {
	ret = ioctl(fd, RELEASE_DMA_BUFF, &dma_buf_wr);
	if (ret < 0)
	    printf("unable to run ioctl for DMA-BUF Allocation\n");
    }
    ret = write_to_file(SYSFS_PATH, 1);
    if (ret != 0) {
	printf("Error writting to sysfs path: %d\n", ret);
    }

err_wsys:
    munmap(inp_buf, size);
err_rmap:
    ret = ioctl(fd, RELEASE_DMA_BUFF, &dma_buf_rd);
    if (ret < 0)
	printf("unable to run ioctl for DMA-BUF Allocation\n");


    pcie_set_write_transfer_done(fd, value);
    pcie_set_read_transfer_done(fd, value);	
    pcie_close(fd);

    return ret;
}
