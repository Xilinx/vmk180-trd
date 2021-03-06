#
# This is the gst-sdx recipe
#
#

SUMMARY = "gst-sdx allocator and base class"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${WORKDIR}/gst-libs/gst/base/gstsdxbase.c;beginline=1;endline=24;md5=091ea5d307cba07f2969994cdbb8f2f3"

DEPENDS = "glib-2.0 gstreamer1.0 gstreamer1.0-plugins-base"

SRC_URI = " \
	file://cmake \
	file://CMakeLists.txt \
	file://ext \
	file://gst-libs \
	file://src \
	"

# the xrt and sds-lib package configs are mutually exclusive
# the use shall enable only one at a time
PACKAGECONFIG ??= "xrt filter2d"
PACKAGECONFIG[sds-lib] = "-DSDSOC_MODE=on,-DSDSOC_MODE=off,sds-lib,sds-lib"
PACKAGECONFIG[xrt] = "-DSDSOC_MODE=off,-DSDSOC_MODE=on,xrt,xrt"
# plugin configs e.g. filter2d are only valid when xrt is selected
# enabling plugins in combination with sds-lib results in an error
PACKAGECONFIG[filter2d] = "-DPLUGIN_FILTER2D=on,-DPLUGIN_FILTER2D=off,opencv"

S = "${WORKDIR}"

inherit pkgconfig cmake

FILES_${PN} += " \
	${libdir}/gstreamer-1.0/libgstsdx*.so \
	${libdir}/libxrtutils.so \
	"
FILES_${PN}-dev += " \
	${libdir}/libgstsdxbase-1.0.so \
	${libdir}/libgstsdxallocator-1.0.so \
	${libdir}/libgstxclallocator-1.0.so \
	"
FILES_SOLIBSDEV = ""
