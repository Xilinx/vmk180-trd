FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://overrides.json"

do_install:append () {
	install -d ${D}${datadir}/jupyter/lab/settings
	install -m 0644 ${WORKDIR}/overrides.json ${D}${datadir}/jupyter/lab/settings/
}

FILES_${PN}:append = "${datadir}/jupyter/lab/settings"
