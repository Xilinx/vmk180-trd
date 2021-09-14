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
#define ALLOC_DMA_BUFF            0xe
#define RELEASE_DMA_BUFF          0xf
#define DIRECT_COPY               0x1a
#define PCIE_DMABUF_IMPORT        0x1b
#define GET_KERNEL_NAME           0x1c
#define GET_USE_CASE              0x1d

#define SET_READ_TRANSFER_DONE_VAL   0xef
#define CLR_READ_TRANSFER_DONE_VAL   0x00
#define SET_WRITE_TRANSFER_DONE_VAL  0xef
#define CLR_WRITE_TRANSFER_DONE_VAL  0x00
#define PCIE_DEV_MAP_TYPE_PATH       "/sys/class/pciep/pciep0/device/map_type"

GST_DEBUG_CATEGORY_EXTERN (pcie_gst_app_debug);
#define GST_CAT_DEFAULT pcie_gst_app_debug

gint pcie_open()
{
    gint fpga_fd = 0;

    fpga_fd = open(DEVICE_NAME, O_RDWR);
    if (fpga_fd < 0) {
        GST_ERROR ("Unable to open device %d", fpga_fd);
        return -EINVAL;
    }

    return fpga_fd;
}

gulong pcie_get_file_length(gint fpga_fd)
{
    gint   ret         = 0;
    gulong file_length = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, GET_FILE_LENGTH, &file_length);
        if (ret < 0)
            GST_ERROR ("Unable to run ioctl to get file-length");
    }

    return file_length;
}

gint pcie_get_input_resolution(gint fpga_fd, struct resolution *input_res)
{
    gint ret = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, GET_RESOLUTION, input_res);
        if (ret < 0)
            GST_ERROR ("Unable to run ioctl to get input resolution");
    }

    return ret;
}

gint pcie_get_fps(gint fpga_fd)
{
    gint  ret = 0;
    guint fps = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, GET_FPS, &fps);
        if (ret < 0)
            GST_ERROR ("Unable to run ioctl to get fps");
    }

    return fps;
}

gint pcie_get_kernel_mode(gint fpga_fd)
{
    gint ret          = 0;
    guint kernel_mode = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, GET_KERNEL_MODE, &kernel_mode);
        if (ret < 0)
            GST_ERROR ("Unable to run ioctl to get kernel mode");
    }

    return kernel_mode;
}

gint pcie_get_kernel_name(gint fpga_fd)
{
    gint ret          = 0;
    guint kernel_name = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, GET_KERNEL_NAME, &kernel_name);
        if (ret < 0)
            GST_ERROR ("Unable to run ioctl to get kernel name");
    }

    return kernel_name;
}

gint pcie_get_filter_type(gint fpga_fd)
{
    gint  ret         = 0;
    guint filter_type = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, GET_FILTER_TYPE, &filter_type);
        if (ret < 0)
            GST_ERROR ("Unable to run ioctl to get filter type");
    }

    return filter_type;
}

gint pcie_dma_import(gint fpga_fd,struct dma_buf_imp *dma_import)
{
    gint ret = 0;

    dma_import->dma_imp_flag = 1;

    if(fpga_fd > 0) {
        ret = ioctl(fpga_fd, PCIE_DMABUF_IMPORT, dma_import);
        if (ret < 0)
            GST_ERROR ("Unable to run ioctl for dma buf import");
    }

    return ret;
}

gint pcie_dma_import_release(gint fpga_fd,struct dma_buf_imp *dma_import)
{
    gint ret = 0;

    dma_import->dma_imp_flag = 0;
    dma_import->dir = 0; /* DMA_BIDIRECTIONAL */

    if(fpga_fd > 0) {
        ret = ioctl(fpga_fd, PCIE_DMABUF_IMPORT, dma_import);
        if (ret < 0)
            GST_ERROR ("Unable to run ioctl for dma buf import release");
    }

    return ret;
}

gint pcie_dma_export(gint fpga_fd,struct dma_buf_export *dma_export)
{
    gint ret = 0;

    if(fpga_fd > 0) {
        ret = ioctl(fpga_fd, ALLOC_DMA_BUFF, dma_export);
        if (ret < 0)
            GST_ERROR ("Unable to run ioctl for dma buf export");
    }

    return ret;
}

gint pcie_dma_export_release(gint fpga_fd, struct dma_buf_export *dma_export)
{
    gint ret = 0;

    if(fpga_fd > 0) {
        ret = ioctl(fpga_fd, RELEASE_DMA_BUFF, dma_export);
        if (ret < 0)
            GST_ERROR ("Unable to run ioctl for dma-buf export release");
    }

    return ret;
}

gint pcie_get_usecase_type(gint fpga_fd)
{
    gint  ret     = 0;
    guint usecase = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, GET_USE_CASE, &usecase);
        if (ret < 0)
            GST_ERROR ("Unable to run ioctl to get use-case type");
    }

    return usecase;
}

gint pcie_set_read_transfer_done(gint fpga_fd)
{
    gint ret = 0;
    guint value = SET_READ_TRANSFER_DONE_VAL;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, SET_READ_TRANSFER_DONE, &value);
        if (ret < 0) {
            GST_ERROR ("Unable to run ioctl for read transfer done");
        }
    }

    return ret;
}

gint set_export_fd_dir(guint val)
{
    gint ret = 0;
    FILE *fp = NULL;

    fp = fopen(PCIE_DEV_MAP_TYPE_PATH, "wb");
    if (fp == NULL) {
        GST_ERROR ("Error opening file : %s", PCIE_DEV_MAP_TYPE_PATH);
        return 1;
    }

    ret = fprintf(fp, "%d\n", val);
    if (ret <= 0) {
        GST_ERROR ("Unable to set map_type %d for export fd", val);
        fclose(fp);
        return 1;
    }

    fclose(fp);
    return 0;
}

gint pcie_set_write_transfer_done(gint fpga_fd)
{
    gint  ret   = 0;
    guint value = SET_WRITE_TRANSFER_DONE_VAL;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, SET_WRITE_TRANSFER_DONE, &value);
        if (ret < 0) {
            GST_ERROR ("Unable to run ioctl for write transfer done");
            return ret;
        }
    }

    return ret;
}

gint pcie_clr_read_transfer_done(gint fpga_fd)
{
    gint  ret   = 0;
    guint value = CLR_READ_TRANSFER_DONE_VAL;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, CLR_READ_TRANSFER_DONE, &value);
        if (ret < 0) {
            GST_ERROR ("Unable to run ioctl for read transfer done");
            return ret;
        }
    }

    return ret;
}

gint pcie_clr_write_transfer_done(gint fpga_fd)
{
    gint  ret   = 0;
    guint value = CLR_WRITE_TRANSFER_DONE_VAL;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, CLR_WRITE_TRANSFER_DONE, &value);
        if (ret < 0) {
            GST_ERROR ("Unable to run ioctl for write transfer done");
            return ret;
        }
    }
    return ret;
}


gint pcie_read(gint fpga_fd, gint size, gulong offset, gchar *buff)
{
    glong rc = 0;
    gulong lseek_cnt = 0;

    if (fpga_fd >= 0) {
        if (offset) {
            lseek_cnt = lseek(fpga_fd, offset, SEEK_SET);
            if (lseek_cnt != offset) {
                GST_ERROR ("Seek offset 0x%lx != 0x%lx", lseek_cnt, offset);
                return -EIO;
            }
        }

        rc = read(fpga_fd, buff, size);
        if (rc < 0) {
            GST_ERROR ("Return code = 0x%lx, read size = 0x%x", rc, size);
            return -EIO;
        }
    }

    return rc;
}

gint pcie_write(gint fpga_fd, gint size, gint offset, gchar *buff)
{
    glong rc = 0;

    if (fpga_fd >= 0) {
        rc = write(fpga_fd, buff, size);
        if (rc < 0) {
            GST_ERROR ("Return code = 0x%lx, write size = 0x%x",rc, size);
            return -EIO;
        }
    }

    return rc;
}

void pcie_close(gint fpga_fd)
{
    close(fpga_fd);
}
