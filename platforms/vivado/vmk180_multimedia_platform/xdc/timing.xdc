# (C) Copyright 2020 - 2021 Xilinx, Inc.
# SPDX-License-Identifier: Apache-2.0

################
# Clock Groups #
################
#
create_clock -period 3.367 -name hdmi_tx_clk [get_ports TX_REFCLK_P_IN]

