RM = rm -rf

# to be passed from top-level Makefile
PFM =
YES ?= 0

PLNX_IMG_DIR = images/linux
PLNX_SDK = $(PLNX_IMG_DIR)/sdk.sh

PLNX_BOOT = $(PLNX_IMG_DIR)/BOOT.BIN
PLNX_BOOT_OBJS += $(PLNX_IMG_DIR)/bl31.elf
PLNX_BOOT_OBJS += $(PLNX_IMG_DIR)/plm.elf
PLNX_BOOT_OBJS += $(PLNX_IMG_DIR)/psmfw.elf
PLNX_BOOT_OBJS += $(PLNX_IMG_DIR)/u-boot.elf
PLNX_BOOT_ARGS =  --plm --psmfw --u-boot --dtb images/linux/system-vmk180-revA.dtb

PLNX_WIC = $(PLNX_IMG_DIR)/petalinux-sdimage.wic.xz
PLNX_WIC_OBJS += $(PLNX_IMG_DIR)/boot.scr
PLNX_WIC_OBJS += $(PLNX_IMG_DIR)/Image
PLNX_WIC_OBJS += $(PLNX_IMG_DIR)/rootfs.tar.gz
PLNX_WIC_ARGS = --extra-bootfiles "binary_container_1.xclbin" --wic-extra-args "-c xz"

PLNX_IMG_OBJS += $(PLNX_BOOT_OBJS)
PLNX_IMG_OBJS += $(PLNX_WIC_OBJS)

.PHONY: help
help:
	@echo 'Usage:'
	@echo ''
	@echo '  make wic'
	@echo '    This rule builds an SD card wic image.'
	@echo ''
	@echo '  make boot'
	@echo '    This rule builds a boot image (BOOT.BIN).'
	@echo ''
	@echo '  make image'
	@echo '    This rule builds a full Linux image. It is always executed'
	@echo '    unconditionally. The yocto build system tracks changes and'
	@echo '    performs an incremental build on subsequent runs.'
	@echo ''
	@echo '  make sdk'
	@echo '    This rule builds an SDK.'
	@echo ''

.PHONY: all
all: wic

.PHONY: wic
wic: $(PLNX_WIC)
$(PLNX_WIC): $(PLNX_WIC_OBJS) $(PLNX_BOOT)
	@echo 'Build PetaLinux wic image'
	@cp ../../overlays/examples/filter2d_pl/binary_container_1.xclbin ./images/linux
	petalinux-package --wic ${PLNX_WIC_ARGS}

.PHONY: boot
boot: $(PLNX_BOOT)
$(PLNX_BOOT): $(PLNX_BOOT_OBJS)
	@echo 'Build PetaLinux boot image'
	petalinux-package --boot ${PLNX_BOOT_ARGS} --force

.PHONY: image
image $(PLNX_IMG_OBJS):
	@echo 'Build PetaLinux image'
	@if [ ${YES} -eq 1 ]; then \
	  yes | petalinux-config --silentconfig; \
	else \
	  petalinux-config --silentconfig; \
	fi
	petalinux-build

.PHONY: sdk
sdk: $(PLNX_SDK)
$(PLNX_SDK):
	@echo 'Build PetaLinux SDK'
	@if [ ${YES} -eq 1 ]; then \
	  yes | petalinux-config --silentconfig; \
	else \
	  petalinux-config --silentconfig; \
	fi
	petalinux-build --sdk

.PHONY: clean
clean:
	-@$(RM) build components/yocto images
	-@$(RM) $(shell grep TMP_DIR project-spec/configs/config | sed -e 's/.*"\(.*\)\"/\1/')
	-@$(RM) project-spec/hw-description/*

