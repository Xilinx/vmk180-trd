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
	pcie-testapp \
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
	"

RDEPENDS_${PN} = "${VMK180_TRD_PACKAGES}"
