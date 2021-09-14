/*
 * Copyright (C) 2017 – 2019 Xilinx, Inc.  All rights reserved.
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

#include "xcl2.hpp"
#include <limits.h>
#include <sys/stat.h>
#include <unistd.h>

namespace xcl {
std::vector<cl::Device> get_devices(const std::string &vendor_name) {
    size_t i;
    cl_int err;
    std::vector<cl::Platform> platforms;
    OCL_CHECK(err, err = cl::Platform::get(&platforms));
    cl::Platform platform;
    for (i = 0; i < platforms.size(); i++) {
        platform = platforms[i];
        OCL_CHECK(err,
                  std::string platformName =
                      platform.getInfo<CL_PLATFORM_NAME>(&err));
        if (platformName == vendor_name) {
            //std::cout << "Found Platform" << std::endl;
            //std::cout << "Platform Name: " << platformName.c_str() << std::endl;
            break;
        }
    }
    if (i == platforms.size()) {
        std::cout << "Error: Failed to find Xilinx platform" << std::endl;
        exit(EXIT_FAILURE);
    }
    //Getting ACCELERATOR Devices and selecting 1st such device
    std::vector<cl::Device> devices;
    OCL_CHECK(err,
              err = platform.getDevices(CL_DEVICE_TYPE_ACCELERATOR, &devices));
    return devices;
}

std::vector<cl::Device> get_xil_devices() { return get_devices("Xilinx"); }


std::vector<unsigned char> read_binary_file(const std::string &xclbin_file_name) {
    //std::cout << "INFO: Reading " << xclbin_file_name << std::endl;

    if (access(xclbin_file_name.c_str(), R_OK) != 0) {
        printf("ERROR: %s xclbin not available please build\n",
               xclbin_file_name.c_str());
        exit(EXIT_FAILURE);
    }
    //Loading XCL Bin into char buffer
    //std::cout << "Loading: '" << xclbin_file_name.c_str() << "'\n";
    std::ifstream bin_file(xclbin_file_name.c_str(), std::ifstream::binary);
    bin_file.seekg(0, bin_file.end);
    auto nb = bin_file.tellg();
    bin_file.seekg(0, bin_file.beg);
    std::vector<unsigned char> buf;
    buf.resize(nb);
    bin_file.read(reinterpret_cast<char*>(buf.data()), nb);
    return buf;
}

std::string
find_binary_file(const std::string& _device_name, const std::string& xclbin_name)
{
   // std::cout << "XCLBIN File Name: " << xclbin_name.c_str() << std::endl;
    char *xcl_mode = getenv("XCL_EMULATION_MODE");
	char *xcl_target = getenv("XCL_TARGET");
    std::string mode;

	/* Fall back mode if XCL_EMULATION_MODE is not set is "hw" */
	if(xcl_mode == NULL) {
		mode = "hw";
	} else {
		/* if xcl_mode is set then check if it's equal to true*/
		if(strcmp(xcl_mode,"true") == 0) {
			/* if it's true, then check if xcl_target is set */
			if(xcl_target == NULL) {
				/* default if emulation but not specified is software emulation */
				mode = "sw_emu";
			} else {
				/* otherwise, it's what ever is specified in XCL_TARGET */
				mode = xcl_target;
			}
		} else {
			/* if it's not equal to true then it should be whatever
			 * XCL_EMULATION_MODE is set to */
			mode = xcl_mode;
		}
    }
    char *xcl_bindir = getenv("XCL_BINDIR");

    // typical locations of directory containing xclbin files
    const char *dirs[] = {
        xcl_bindir, // $XCL_BINDIR-specified
        "xclbin",   // command line build
        "..",       // gui build + run
        ".",        // gui build, run in build directory
        NULL
    };
    const char **search_dirs = dirs;
    if (xcl_bindir == NULL) {
        search_dirs++;
    }

    char *device_name = strdup(_device_name.c_str());
    if (device_name == NULL) {
        printf("Error: Out of Memory\n");
        exit(EXIT_FAILURE);
    }

    // fix up device name to avoid colons and dots.
    // xilinx:xil-accel-rd-ku115:4ddr-xpr:3.2 -> xilinx_xil-accel-rd-ku115_4ddr-xpr_3_2
    for (char *c = device_name; *c != 0; c++) {
        if (*c == ':' || *c == '.') {
            *c = '_';
        }
    }

    char *device_name_versionless = strdup(_device_name.c_str());
    if (device_name_versionless == NULL) {
        printf("Error: Out of Memory\n");
        exit(EXIT_FAILURE);
    }

    unsigned short colons = 0;
    for (char *c = device_name_versionless; *c != 0; c++) {
        if (*c == ':') {
            colons++;
            *c = '_';
        }
        /* Zero out version area */
        if (colons == 3) {
            *c = '\0';
        }
    }

    const char *file_patterns[] = {
        "%1$s/%2$s.%3$s.%4$s.xclbin",     // <kernel>.<target>.<device>.xclbin
        "%1$s/%2$s.%3$s.%4$s.xclbin",     // <kernel>.<target>.<device_versionless>.xclbin
        "%1$s/binary_container_1.xclbin", // default for gui projects
        "%1$s/%2$s.xclbin",               // <kernel>.xclbin
        NULL
    };

    char xclbin_file_name[PATH_MAX];
    memset(xclbin_file_name, 0, PATH_MAX);
    ino_t ino = 0; // used to avoid errors if an xclbin found via multiple/repeated paths
    for (const char **dir = search_dirs; *dir != NULL; dir++) {
        char *device_name_ptr;
        bool use_versionless = 0;
        struct stat sb;
        if (stat(*dir, &sb) == 0 && S_ISDIR(sb.st_mode)) {
            for (const char **pattern = file_patterns; *pattern != NULL; pattern++) {
                if (use_versionless) {
                    device_name_ptr = device_name_versionless;
                } else {
                    device_name_ptr = device_name;
                    use_versionless = 1;
                }
                char file_name[PATH_MAX];
                memset(file_name, 0, PATH_MAX);
                snprintf(file_name, PATH_MAX, *pattern, *dir, xclbin_name.c_str(), mode.c_str(), device_name_ptr);
                if (stat(file_name, &sb) == 0 && S_ISREG(sb.st_mode)) {
                    char* bindir = strdup(*dir);
                    if (bindir == NULL) {
                        printf("Error: Out of Memory\n");
                        exit(EXIT_FAILURE);
                    }
                    if (*xclbin_file_name && sb.st_ino != ino) {
                        printf("Error: multiple xclbin files discovered:\n %s\n %s\n", file_name, xclbin_file_name);
                        exit(EXIT_FAILURE);
                    }
                    ino = sb.st_ino;
                    strncpy(xclbin_file_name, file_name, PATH_MAX);
                }
            }
        }
    }
    // if no xclbin found, preferred path for error message from xcl_import_binary_file()
    if (*xclbin_file_name == '\0') {
        snprintf(xclbin_file_name, PATH_MAX, file_patterns[0], *search_dirs, xclbin_name.c_str(), mode.c_str(), device_name);
    }

    free(device_name);
    return (xclbin_file_name);
}

bool is_emulation() {
    bool ret = false;
    char *xcl_mode = getenv("XCL_EMULATION_MODE");
    if (xcl_mode != NULL) {
        ret = true;
    }
    return ret;
}

bool is_hw_emulation() {
    bool ret = false;
    char *xcl_mode = getenv("XCL_EMULATION_MODE");
    if ((xcl_mode != NULL) && !strcmp(xcl_mode, "hw_emu")) {
        ret = true;
    }
    return ret;
}

bool is_xpr_device(const char *device_name) {
    const char *output = strstr(device_name, "xpr");

    if (output == NULL) {
        return false;
    } else {
        return true;
    }
}
}; // namespace xcl