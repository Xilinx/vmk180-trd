# (C) Copyright 2020 - 2021 Xilinx, Inc.
# SPDX-License-Identifier: Apache-2.0

################
# Clock Groups #
################
#
create_clock -period 3.367 -name hdmi_tx_clk [get_ports TX_REFCLK_P_IN]

create_waiver -type DRC -id RPBF-8 -description {Waiver for AR76846} -object [get_cells HDMI_CTL_IIC_scl_iobuf]
create_waiver -type DRC -id RPBF-8 -description {Waiver for AR76846} -object [get_cells HDMI_CTL_IIC_sda_iobuf]
create_waiver -type DRC -id RPBF-8 -description {Waiver for AR76846} -object [get_cells TX_DDC_OUT_scl_iobuf]
create_waiver -type DRC -id RPBF-8 -description {Waiver for AR76846} -object [get_cells TX_DDC_OUT_sda_iobuf]

