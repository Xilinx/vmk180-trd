DESCRIPTION = "VMK180 TRD related Packages"

inherit packagegroup

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
	packagegroup-petalinux-opencv \
	git \
	ldd \
	tree \
	packagegroup-petalinux-python-modules \
	packagegroup-petalinux-jupyter \
        vmk180-trd-notebooks \
        nodejs \
        nodejs-npm \
        parted \
        python3-dev \
        python3-periphery \
	${XRT_PACKAGES} \
	packagegroup-petalinux-gstreamer \
	gst-plugins-xlnx \
        gstreamer1.0-python \
	packagegroup-petalinux-self-hosted \
        packagegroup-petalinux-v4lutils \
        e2fsprogs-resize2fs \
	kernel-module-hdmi \
	ldd \
	nodejs \
	nodejs-npm \
	ntp \
	tcf-agent \
	trd-files \
	ttf-bitstream-vera \
	tzdata \
	xmediactl \
	vvas-utils \
	vvas-gst \
	filter2d-accel \
	libxapm \
	libpcie-gst \
	libxapm-python \
	start-jupyterlab \
	simd \
	"

RDEPENDS:${PN} = "${VMK180_TRD_PACKAGES}"
