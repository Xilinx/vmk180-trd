 ##
 # Copyright (C) 2020 Xilinx, Inc.  All rights reserved.
 #  #
 # Permission is hereby granted, free of charge, to any person obtaining a copy
 #  # of this software and associated documentation files (the "Software"), to deal
 # in the Software without restriction, including without limitation the rights
 #  # to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 # copies of the Software, and to permit persons to whom the Software is
 #  # furnished to do so, subject to the following conditions:
 #
 # # The above copyright notice and this permission notice shall be included in
 #  # all copies or substantial portions of the Software.
 #
 # # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 #  # IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 # FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 #  # XILINX BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 # ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 #  # WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 #
 # # Except as contained in this notice, the name of the Xilinx shall not be used
 #  # in advertising or otherwise to promote the sale, use or other dealings in
 # this Software without prior written authorization from Xilinx.
 #  ##
project (pcie-testapp C CXX)
cmake_minimum_required (VERSION 2.8.12)

set (CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

set (CMAKE_SYSROOT $ENV{SDKTARGETSYSROOT} CACHE PATH "Path to sysroot")
if (CMAKE_SYSROOT)
  set(ENV{PKG_CONFIG_SYSROOT_DIR} ${CMAKE_SYSROOT})
  set(ENV{PKG_CONFIG_PATH} ${CMAKE_SYSROOT}/usr/lib/pkgconfig)
endif()

set(XRTUTILS_LIBRARY_INCLUDEDIR "${PROJECT_SOURCE_DIR}/ext/xrtutils")

add_subdirectory(src)
