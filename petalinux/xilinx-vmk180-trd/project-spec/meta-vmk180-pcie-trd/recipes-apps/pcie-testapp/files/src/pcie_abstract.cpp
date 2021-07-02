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

#include "pcie_abstract.h"

#define GET_FILE_LENGTH           0x0
#define GET_KERNEL_MODE           0x1
#define SET_READ_OFFSET           0x2
#define SET_WRITE_OFFSET          0x3
#define SET_READ_TRANSFER_DONE    0x5
#define CLR_READ_TRANSFER_DONE    0x6
#define SET_WRITE_TRANSFER_DONE   0x7
#define CLR_WRITE_TRANSFER_DONE   0x8
#define GET_RESOLUTION            0x9
#define GET_MODE                  0xa
#define GET_FPS                   0xb
#define GET_FORMAT                0xc
#define GET_FILTER_TYPE           0xd

int pcie_open()
{
    int fpga_fd;

    fpga_fd = open(DEVICE_NAME, O_RDWR);
    if (fpga_fd < 0) {
        printf("unable to open device %d.\n", fpga_fd);
        return -EINVAL;
    }

    return fpga_fd;
}

unsigned long int pcie_get_file_length(int fpga_fd)
{
    unsigned long int file_length = 0;
    int ret = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, GET_FILE_LENGTH, &file_length);
        if (ret < 0)
            printf("unable to run ioctl for file_length.\n");
    }
    return file_length;
}

int pcie_get_input_resolution(int fpga_fd, struct resolution *input_res)
{
    int ret = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, GET_RESOLUTION, input_res);
        if (ret < 0)
            printf("unable to run ioctl for input resolution.\n");
    }
    return ret;
}
int pcie_get_fps(int fpga_fd)
{
    int ret = 0;
    unsigned int fps;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, GET_FPS, &fps);
        if (ret < 0)
            printf("unable to run ioctl for FPS.\n");
    }
    return fps;
}

int pcie_get_format(int fpga_fd)
{
    int ret = 0;
    unsigned int fmt;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, GET_FORMAT, &fmt);
        if (ret < 0)
            printf("unable to run ioctl for format.\n");
    }
    return fmt;
}

int pcie_get_kernl_mode(int fpga_fd)
{
    int ret = 0;
	unsigned int kernl_mode;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, GET_KERNEL_MODE, &kernl_mode);
        if (ret < 0)
            printf("unable to run ioctl for kernel mode.\n");
    }
    return kernl_mode;
}


int pcie_get_filter_type(int fpga_fd)
{
    int ret = 0;
	unsigned int filter_type;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, GET_FILTER_TYPE, &filter_type);
        if (ret < 0)
            printf("unable to run ioctl for filter type.\n");
    }
    return filter_type;
}

int pcie_set_read_transfer_done(int fpga_fd, int value)
{
    int ret = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, SET_READ_TRANSFER_DONE, &value);
        if (ret < 0) {
            printf("unable to run ioctl for read transfer done.\n");
            return ret;
        }
        else {
            printf("successfully set read transfer done\n");
            return ret;
        }
    }
    return ret;
}

int pcie_set_write_transfer_done(int fpga_fd, int value)
{
    int ret = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, SET_WRITE_TRANSFER_DONE, &value);
        if (ret < 0) {
            printf("unable to run ioctl for write transfer done.\n");
            return ret;
        }
        else {
            printf("successfully set write transfer done\n");
            return ret;
        }
    }
    return ret;
}

int pcie_clr_read_transfer_done(int fpga_fd, int value)
{
    int ret = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, CLR_READ_TRANSFER_DONE, &value);
        if (ret < 0) {
            printf("unable to run ioctl for read transfer done.\n");
            return ret;
        }
        else {
            printf("successfully set read transfer done\n");
            return ret;
        }
    }
    return ret;
}

int pcie_clr_write_transfer_done(int fpga_fd, int value)
{
    int ret = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, CLR_WRITE_TRANSFER_DONE, &value);
        if (ret < 0) {
            printf("unable to run ioctl for write transfer done.\n");
            return ret;
        }
        else {
            printf("successfully set write transfer done\n");
            return ret;
        }
    }
    return ret;
}


int pcie_read(int fpga_fd, int size, unsigned long int offset, char *buff)
{
    long int rc = 0;
    unsigned long int lseek_cnt = 0;

    if (fpga_fd >= 0) {
        if (offset) {
            lseek_cnt = lseek(fpga_fd, offset, SEEK_SET);
            if (lseek_cnt != offset) {
                printf("seek off 0x%lx != 0x%lx.\n", lseek_cnt, offset);
                return -EIO;
            }
        }
        rc = read(fpga_fd, buff, size);
        if (rc < 0) {
            printf("read size = 0x%lx 0x%lx 0x%x 0x%x.\n", rc, rc, size, size);
                perror("read file");
            return -EIO;
        }

    }

    return rc;
}

int pcie_write(int fpga_fd, int size, int offset, char *buff)
{
    long int rc = 0;


    if (fpga_fd >= 0) {
        rc = write(fpga_fd, buff, size);
        if (rc < 0) {
            printf("write size = 0x%lx 0x%lx 0x%x 0x%x.\n",rc, rc, size, size);
            perror("write file");
            return -EIO;
        }
    }
    return rc;
}

void pcie_close(int fpga_fd)
{
    close(fpga_fd);
}
