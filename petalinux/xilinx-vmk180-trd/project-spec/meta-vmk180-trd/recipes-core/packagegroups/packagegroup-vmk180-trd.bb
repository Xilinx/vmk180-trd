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
	packagegroup-python3-jupyter \
        vmk180-trd-notebooks \
        jupyter-startup \
        nodejs \
        nodejs-npm \
         parted \
        python3-dev \
        python3-periphery \
	${XRT_PACKAGES} \
	xrt-ini \
	packagegroup-petalinux-gstreamer \
	gst-plugins-xlnx \
        gst-sdx \
        gstreamer1.0-python \
	packagegroup-petalinux-self-hosted \
        packagegroup-petalinux-v4lutils \
	packagegroup-petalinux-v4lutils \
        e2fsprogs-resize2fs \
	kernel-module-hdmi \
	ldd \
	libxapm-python \
	nodejs \
	nodejs-npm \
	ntp \
	tcf-agent \
	trd-files \
	ttf-bitstream-vera \
	tzdata \
	pcie-gst-app \
	"

RDEPENDS_${PN} = "${VMK180_TRD_PACKAGES}"
