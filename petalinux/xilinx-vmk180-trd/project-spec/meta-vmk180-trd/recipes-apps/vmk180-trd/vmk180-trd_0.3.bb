#
# This is the base-trd recipe
#
#

SUMMARY = "VMK180 TRD Jupyter notebooks"
SECTION = "PETALINUX/apps"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=f9990fcc34ccf1f82ccf1bc5a1cc3bfc"

RDEPENDS:${PN} += " \
	python3-notebook \
	python3-opencv \
	python3-pydot \
	"

SRC_URI = " \
	file://notebooks \
	file://LICENSE \
	"

S = "${WORKDIR}"

do_configure[noexec]="1"
do_compile[noexec]="1"

NOTEBOOK_DIR = "${datadir}/notebooks"

do_install() {
	install -d ${D}/${NOTEBOOK_DIR}/${PN}
	cp -r ${S}/notebooks/* ${D}/${NOTEBOOK_DIR}/${PN}
}

FILES:${PN}-notebooks += "${NOTEBOOK_DIR}"
PACKAGES += "${PN}-notebooks"

