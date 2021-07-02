DESCRIPTION = "VMK180 TRD related Packages"

inherit packagegroup

MOVIE_PACKAGES = " \
	bigbuckbunny-360p-vp9-webm \
	bigbuckbunny-480p-vp9-webm \
	"

XRT_PACKAGES = " \
	opencl-clhpp-dev \
	opencl-headers-dev \
	xrt \
	xrt-dev \
	zocl \
	"

VMK180_TRD_PACKAGES = " \
	packagegroup-core-tools-debug \
	packagegroup-petalinux-display-debug \
	packagegroup-petalinux-gstreamer \
	packagegroup-petalinux-opencv \
	packagegroup-petalinux-python-modules \
	packagegroup-petalinux-self-hosted \
	packagegroup-petalinux-v4lutils \
	packagegroup-python3-jupyter \
	vmk180-trd-notebooks \
	e2fsprogs-resize2fs \
	git \
	gst-plugins-xlnx \
	gst-sdx \
	gstreamer1.0-python \
	jupyter-startup \
	kernel-module-hdmi \
	ldd \
	libxapm-python \
	nodejs \
	nodejs-npm \
	ntp \
	parted \
	python3-dev \
	python3-periphery \
	tcf-agent \
	trd-files \
	tree \
	ttf-bitstream-vera \
	tzdata \
	${MOVIE_PACKAGES} \
	${XRT_PACKAGES} \
	xrt-ini \
	"

RDEPENDS_${PN} = "${VMK180_TRD_PACKAGES}"
