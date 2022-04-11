FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"


SRC_URI:append = " \
	file://0001-media-i2c-set-free-running-clock-for-all-resolutions.patch \
	file://0003-drm-xlnx_mixer-Dont-enable-primary-plane-by-default.patch \
	file://0001-drivers-misc-add-support-for-interrupt-based-PCIe-en.patch \
	file://0002-xilinx_pci_endpoint-Add-resolution-use-case-and-64-b.patch \
	file://0003-Added-ioctl-to-support-different-formats.patch \
	file://0004-added-driver-without-filter-support.patch \
	file://0005-Added-dma-import-and-bufferpool-changes.patch \
	file://0006-PCIe-Endpoint-driver-supoort-VMAP-callback-in-dma_bu.patch \
	file://bsp.cfg \
"
