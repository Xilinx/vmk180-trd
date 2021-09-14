#
# This file is the xrt.ini recipe.
#

SUMMARY = "Simple idtbin application"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://xrt.ini \
	"

S = "${WORKDIR}"

do_install() {
	     install -d ${D}/usr/bin
	     install -m 0755 ${S}/xrt.ini ${D}/usr/bin
}
FILES_${PN} += ""
