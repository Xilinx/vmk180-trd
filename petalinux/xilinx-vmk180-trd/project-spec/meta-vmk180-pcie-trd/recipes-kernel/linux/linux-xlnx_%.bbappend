FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"


SRC_URI_append = " \
	file://0001-drivers-misc-add-support-for-interrupt-based-PCIe-en.patch\
	file://0002-xilinx_pci_endpoint-Add-resolution-use-case-and-64-b.patch\
	file://0003-Added-ioctl-to-support-different-formats.patch\
	file://0004-added-driver-without-filter-support.patch\
"
