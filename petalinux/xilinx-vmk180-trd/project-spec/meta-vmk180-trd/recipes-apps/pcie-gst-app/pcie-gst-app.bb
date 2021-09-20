#
# PCIe GStreamer application recipe
#
SUMMARY = "PCIe GStreamer application"
SECTION = "PETALINUX/apps"
DESCRIPTION = "PCIe GStreamer application driven by a PCIe host application to run mipi and file display use-cases with and without filter"
LICENSE = "LGPLv2"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=b60ab04828851b8b8d8ad651889ac94d"

BRANCH ?= "master"
REPO   ?= "git://gitenterprise.xilinx.com/PAEG/vmk180_petalinux_bsp.git;protocol=https"
SRCREV ?= "${AUTOREV}"

BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"
SRC_URI = "${REPO};${BRANCHARG}"

#FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

S = "${WORKDIR}/git/single_plat"

CFLAGS_prepend = "-I${S}/include/"

DEPENDS = "gstreamer1.0 gstreamer1.0-plugins-base v4l-utils libdrm"

# NOTE: if this software is not capable of being built in a separate build directory
# from the source, you should replace autotools with autotools-brokensep in the
# inherit line
inherit pkgconfig autotools

# Specify any options you want to pass to the configure script using EXTRA_OECONF:
EXTRA_OECONF = ""

FILES_${PN} += "/usr/bin/pcie_gst_app"

do_install() {
	install -d ${D}/${bindir}
	oe_runmake install DESTDIR=${D}
	install -m 0755 ${B}/pcie_gst_app ${D}/${bindir}
}
