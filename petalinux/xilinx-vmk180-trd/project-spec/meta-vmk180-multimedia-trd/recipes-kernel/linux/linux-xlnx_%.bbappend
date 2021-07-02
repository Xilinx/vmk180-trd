FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
	file://0001-media-i2c-set-free-running-clock-for-all-resolutions.patch \
	file://0003-drm-xlnx_mixer-Dont-enable-primary-plane-by-default.patch \
"
