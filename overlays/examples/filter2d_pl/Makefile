# (C) Copyright 2020 - 2021 Xilinx, Inc.
# SPDX-License-Identifier: Apache-2.0

RM = rm -rf
MV = mv
CP = cp -r

# v++ flags
VPP ?= v++
PLATFORM ?=
LINK_CFG ?= vmk180.cfg
JOBS = 32
VPP_LINK_FLAGS = -l -t hw --platform $(PLATFORM) --save-temps \
	--report_level estimate -j $(JOBS) --config $(LINK_CFG)
XBU = xclbinutil
XBU_FLAGS = --remove-section BITSTREAM --force

# kernels and xclbin
KERNEL_OBJS += kernel/filter2d_pl_accel/filter2d_pl_accel.xo
XSA = binary_container_1.xsa
BINARY_CONTAINER = _x/link/int/binary_container_1.xclbin

# Rules
.PHONY: all link
all: link
link: $(XSA)

$(XSA): $(KERNEL_OBJS)
	$(VPP) $(VPP_LINK_FLAGS) -o $@ $(+)
	$(XBU) $(XBU_FLAGS) --input $(BINARY_CONTAINER) --output binary_container_1.xclbin
	-@$(RM) .Xil

$(KERNEL_OBJS):
	$(MAKE) -C kernel

.PHONY: clean clean-subdirs
clean: clean-subdirs
	-$(RM) $(BINARY_CONTAINER)
	-$(RM) _xocc* .Xil _x
	-$(RM) .Xil _sds *.xml *.dat *.hpfm iprepo *.xtxt *.xsa
	-$(RM) sd_card *.log *.rpt
	-$(RM) *.info
	-$(RM) *.link_summary*

clean-subdirs:
	$(MAKE) -C kernel clean
