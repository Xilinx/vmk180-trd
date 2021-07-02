#
# This file is the pcie-testapp1 recipe.
#

SUMMARY = "Simple pcie-testapp1 application"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " file://cmake \
        file://CMakeLists.txt \
           file://src \
		  "
PACKAGECONFIG ??= "xrt "
PACKAGECONFIG[xrt] = "-DSDSOC_MODE=off,-DSDSOC_MODE=on,xrt,xrt"
PACKAGECONFIG[pcie-testapp] = "opencv"


S = "${WORKDIR}"
inherit pkgconfig cmake

DEPENDS = "opencv xrt"

EXTRA_OECMAKE = ""

