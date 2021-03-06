
################################################################
# This is a generated script based on design: vmk180_trd_platform1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2021.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   common::send_gid_msg -ssname BD::TCL -id 2040 -severity "WARNING" "This script was generated using Vivado <$scripts_vivado_version> without IP versions in the create_bd_cell commands, but is now being run in <$current_vivado_version> of Vivado. There may have been major IP version changes between Vivado <$scripts_vivado_version> and <$current_vivado_version>, which could impact the parameter settings of the IPs."

}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source vmk180_trd_platform1_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcvm1802-vsva2197-2MP-e-S-es1
   }


# CHANGE DESIGN NAME HERE
variable design_name
set design_name vmk180_multimedia_platform

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:versal_cips:*\
xilinx.com:ip:axi_noc:*\
xilinx.com:ip:axi_perf_mon:*\
xilinx.com:ip:axi_vip:*\
xilinx.com:ip:clk_wizard:*\
xilinx.com:ip:proc_sys_reset:*\
xilinx.com:ip:smartconnect:*\
xilinx.com:ip:v_mix:*\
xilinx.com:ip:xlconstant:*\
xilinx.com:ip:xlslice:*\
xilinx.com:ip:axi_iic:*\
xilinx.com:ip:hdmi_gt_controller:*\
xilinx.com:ip:axis_register_slice:*\
xilinx.com:ip:v_hdmi_tx_ss:*\
xilinx.com:hls:ISPPipeline_accel:*\
xilinx.com:ip:axis_data_fifo:*\
xilinx.com:ip:axis_subset_converter:*\
xilinx.com:ip:v_frmbuf_wr:*\
xilinx.com:ip:v_proc_ss:*\
xilinx.com:ip:mipi_csi2_rx_subsystem:*\
xilinx.com:ip:bufg_gt:*\
xilinx.com:ip:gt_quad_base:*\
xilinx.com:ip:util_ds_buf:*\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: gt_refclk1
proc create_hier_cell_gt_refclk1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_gt_refclk1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 0 -to 0 -type clk CLK_N_IN
  create_bd_pin -dir I -from 0 -to 0 -type clk CLK_P_IN
  create_bd_pin -dir O -from 0 -to 0 -type clk O
  create_bd_pin -dir O -from 0 -to 0 -type clk ODIV2

  # Create instance: dru_ibufds_gt_odiv2, and set properties
  set dru_ibufds_gt_odiv2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf dru_ibufds_gt_odiv2 ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {BUFG_GT} \
 ] $dru_ibufds_gt_odiv2

  # Create instance: gt_refclk_buf, and set properties
  set gt_refclk_buf [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf gt_refclk_buf ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $gt_refclk_buf

  # Create instance: vcc_const0, and set properties
  set vcc_const0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant vcc_const0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
 ] $vcc_const0

  # Create port connections
  connect_bd_net -net HDMI_RX_CLK_N_IN_1 [get_bd_pins CLK_N_IN] [get_bd_pins gt_refclk_buf/IBUF_DS_N]
  connect_bd_net -net HDMI_RX_CLK_P_IN_1 [get_bd_pins CLK_P_IN] [get_bd_pins gt_refclk_buf/IBUF_DS_P]
  connect_bd_net -net dru_ibufds_gt_odiv2_BUFG_GT_O [get_bd_pins ODIV2] [get_bd_pins dru_ibufds_gt_odiv2/BUFG_GT_O]
  connect_bd_net -net gt_refclk_buf_IBUF_OUT [get_bd_pins O] [get_bd_pins gt_refclk_buf/IBUF_OUT]
  connect_bd_net -net net_gt_refclk_buf_IBUF_DS_ODIV2 [get_bd_pins dru_ibufds_gt_odiv2/BUFG_GT_I] [get_bd_pins gt_refclk_buf/IBUF_DS_ODIV2]
  connect_bd_net -net net_vcc_const0_dout [get_bd_pins dru_ibufds_gt_odiv2/BUFG_GT_CE] [get_bd_pins vcc_const0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: GT_Quad_and_Clk
proc create_hier_cell_GT_Quad_and_Clk { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_GT_Quad_and_Clk() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:gt_channel_debug_rtl:1.0 CH0_DEBUG

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:gt_channel_debug_rtl:1.0 CH1_DEBUG

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:gt_channel_debug_rtl:1.0 CH2_DEBUG

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:gt_channel_debug_rtl:1.0 CH3_DEBUG

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:gt_debug_rtl:1.0 GT_DEBUG

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:gt_tx_interface_rtl:1.0 TX0_GT_IP_Interface

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:gt_tx_interface_rtl:1.0 TX1_GT_IP_Interface

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:gt_tx_interface_rtl:1.0 TX2_GT_IP_Interface

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:gt_tx_interface_rtl:1.0 TX3_GT_IP_Interface


  # Create pins
  create_bd_pin -dir I -type clk GT_REFCLK1
  create_bd_pin -dir I -from 3 -to 0 RX_DATA_IN_rxn
  create_bd_pin -dir I -from 3 -to 0 RX_DATA_IN_rxp
  create_bd_pin -dir O -from 3 -to 0 TX_DATA_OUT_txn
  create_bd_pin -dir O -from 3 -to 0 TX_DATA_OUT_txp
  create_bd_pin -dir I altclk
  create_bd_pin -dir O ch0_iloresetdone
  create_bd_pin -dir O ch1_iloresetdone
  create_bd_pin -dir O ch2_iloresetdone
  create_bd_pin -dir O ch3_iloresetdone
  create_bd_pin -dir O gtpowergood
  create_bd_pin -dir O hsclk0_lcplllock
  create_bd_pin -dir I -type rst hsclk0_lcpllreset
  create_bd_pin -dir O hsclk1_lcplllock
  create_bd_pin -dir I -type rst hsclk1_lcpllreset
  create_bd_pin -dir O -type gt_usrclk tx_usrclk

  # Create instance: bufg_gt_tx, and set properties
  set bufg_gt_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt bufg_gt_tx ]

  # Create instance: gt_quad_base_1, and set properties
  set gt_quad_base_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:gt_quad_base gt_quad_base_1 ]
  set_property -dict [ list \
   CONFIG.PORTS_INFO_DICT {LANE_SEL_DICT {unconnected {RX0 RX1 RX2 RX3} PROT0 {TX0 TX1 TX2 TX3}} GT_TYPE\
GTY REG_CONF_INTF APB3_INTF BOARD_INTERFACE false}\
   CONFIG.PROT1_LR0_SETTINGS {GT_DIRECTION DUPLEX  INS_LOSS_NYQ 20  INTERNAL_PRESET None  OOB_ENABLE false \
PCIE_ENABLE false  PCIE_USERCLK2_FREQ 250  PCIE_USERCLK_FREQ 250  PRESET None \
RESET_SEQUENCE_INTERVAL 0  RXPROGDIV_FREQ_ENABLE false  RXPROGDIV_FREQ_SOURCE\
LCPLL  RXPROGDIV_FREQ_VAL 322.265625  RX_64B66B_CRC false  RX_64B66B_DECODER\
false  RX_64B66B_DESCRAMBLER false  RX_ACTUAL_REFCLK_FREQUENCY 156.25 \
RX_BUFFER_BYPASS_MODE Fast_Sync  RX_BUFFER_BYPASS_MODE_LANE MULTI \
RX_BUFFER_MODE 1  RX_BUFFER_RESET_ON_CB_CHANGE ENABLE \
RX_BUFFER_RESET_ON_COMMAALIGN DISABLE  RX_BUFFER_RESET_ON_RATE_CHANGE ENABLE \
RX_CB_DISP_0_0 false  RX_CB_DISP_0_1 false  RX_CB_DISP_0_2 false \
RX_CB_DISP_0_3 false  RX_CB_DISP_1_0 false  RX_CB_DISP_1_1 false \
RX_CB_DISP_1_2 false  RX_CB_DISP_1_3 false  RX_CB_K_0_0 false  RX_CB_K_0_1\
false  RX_CB_K_0_2 false  RX_CB_K_0_3 false  RX_CB_K_1_0 false  RX_CB_K_1_1\
false  RX_CB_K_1_2 false  RX_CB_K_1_3 false  RX_CB_LEN_SEQ 1  RX_CB_MASK_0_0\
false  RX_CB_MASK_0_1 false  RX_CB_MASK_0_2 false  RX_CB_MASK_0_3 false \
RX_CB_MASK_1_0 false  RX_CB_MASK_1_1 false  RX_CB_MASK_1_2 false \
RX_CB_MASK_1_3 false  RX_CB_MAX_LEVEL 1  RX_CB_MAX_SKEW 1  RX_CB_NUM_SEQ 0 \
RX_CB_VAL_0_0 00000000  RX_CB_VAL_0_1 00000000  RX_CB_VAL_0_2 00000000 \
RX_CB_VAL_0_3 00000000  RX_CB_VAL_1_0 00000000  RX_CB_VAL_1_1 00000000 \
RX_CB_VAL_1_2 00000000  RX_CB_VAL_1_3 00000000  RX_CC_DISP_0_0 false \
RX_CC_DISP_0_1 false  RX_CC_DISP_0_2 false  RX_CC_DISP_0_3 false \
RX_CC_DISP_1_0 false  RX_CC_DISP_1_1 false  RX_CC_DISP_1_2 false \
RX_CC_DISP_1_3 false  RX_CC_KEEP_IDLE DISABLE  RX_CC_K_0_0 false  RX_CC_K_0_1\
false  RX_CC_K_0_2 false  RX_CC_K_0_3 false  RX_CC_K_1_0 false  RX_CC_K_1_1\
false  RX_CC_K_1_2 false  RX_CC_K_1_3 false  RX_CC_LEN_SEQ 1  RX_CC_MASK_0_0\
false  RX_CC_MASK_0_1 false  RX_CC_MASK_0_2 false  RX_CC_MASK_0_3 false \
RX_CC_MASK_1_0 false  RX_CC_MASK_1_1 false  RX_CC_MASK_1_2 false \
RX_CC_MASK_1_3 false  RX_CC_NUM_SEQ 0  RX_CC_PERIODICITY 5000  RX_CC_PRECEDENCE\
ENABLE  RX_CC_REPEAT_WAIT 0  RX_CC_VAL\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
RX_CC_VAL_0_0 0000000000  RX_CC_VAL_0_1 0000000000  RX_CC_VAL_0_2 0000000000 \
RX_CC_VAL_0_3 0000000000  RX_CC_VAL_1_0 0000000000  RX_CC_VAL_1_1 0000000000 \
RX_CC_VAL_1_2 0000000000  RX_CC_VAL_1_3 0000000000  RX_COMMA_ALIGN_WORD 1 \
RX_COMMA_DOUBLE_ENABLE false  RX_COMMA_MASK 1111111111  RX_COMMA_M_ENABLE false\
RX_COMMA_M_VAL 1010000011  RX_COMMA_PRESET NONE  RX_COMMA_P_ENABLE false \
RX_COMMA_P_VAL 0101111100  RX_COMMA_SHOW_REALIGN_ENABLE true \
RX_COMMA_VALID_ONLY 0  RX_COUPLING AC  RX_DATA_DECODING RAW  RX_EQ_MODE AUTO \
RX_FRACN_ENABLED false  RX_FRACN_NUMERATOR 0  RX_INT_DATA_WIDTH 32  RX_JTOL_FC\
0  RX_JTOL_LF_SLOPE -20  RX_LINE_RATE 10.3125  RX_OUTCLK_SOURCE RXOUTCLKPMA \
RX_PLL_TYPE LCPLL  RX_PPM_OFFSET 0  RX_RATE_GROUP A  RX_REFCLK_FREQUENCY 156.25\
RX_REFCLK_SOURCE R0  RX_SLIDE_MODE OFF  RX_SSC_PPM 0  RX_TERMINATION\
PROGRAMMABLE  RX_TERMINATION_PROG_VALUE 800  RX_USER_DATA_WIDTH 32 \
TXPROGDIV_FREQ_ENABLE false  TXPROGDIV_FREQ_SOURCE LCPLL  TXPROGDIV_FREQ_VAL\
322.265625  TX_64B66B_CRC false  TX_64B66B_ENCODER false  TX_64B66B_SCRAMBLER\
false  TX_ACTUAL_REFCLK_FREQUENCY 156.25  TX_BUFFER_BYPASS_MODE Fast_Sync \
TX_BUFFER_MODE 1  TX_BUFFER_RESET_ON_RATE_CHANGE ENABLE  TX_DATA_ENCODING RAW \
TX_DIFF_SWING_EMPH_MODE CUSTOM  TX_FRACN_ENABLED false  TX_FRACN_NUMERATOR 0 \
TX_INT_DATA_WIDTH 32  TX_LINE_RATE 10.3125  TX_OUTCLK_SOURCE TXOUTCLKPMA \
TX_PIPM_ENABLE false  TX_PLL_TYPE LCPLL  TX_RATE_GROUP A  TX_REFCLK_FREQUENCY\
156.25  TX_REFCLK_SOURCE R0  TX_USER_DATA_WIDTH 32}\
   CONFIG.PROT2_LR0_SETTINGS {GT_DIRECTION DUPLEX  INS_LOSS_NYQ 20  INTERNAL_PRESET None  OOB_ENABLE false \
PCIE_ENABLE false  PCIE_USERCLK2_FREQ 250  PCIE_USERCLK_FREQ 250  PRESET None \
RESET_SEQUENCE_INTERVAL 0  RXPROGDIV_FREQ_ENABLE false  RXPROGDIV_FREQ_SOURCE\
LCPLL  RXPROGDIV_FREQ_VAL 322.265625  RX_64B66B_CRC false  RX_64B66B_DECODER\
false  RX_64B66B_DESCRAMBLER false  RX_ACTUAL_REFCLK_FREQUENCY 156.25 \
RX_BUFFER_BYPASS_MODE Fast_Sync  RX_BUFFER_BYPASS_MODE_LANE MULTI \
RX_BUFFER_MODE 1  RX_BUFFER_RESET_ON_CB_CHANGE ENABLE \
RX_BUFFER_RESET_ON_COMMAALIGN DISABLE  RX_BUFFER_RESET_ON_RATE_CHANGE ENABLE \
RX_CB_DISP_0_0 false  RX_CB_DISP_0_1 false  RX_CB_DISP_0_2 false \
RX_CB_DISP_0_3 false  RX_CB_DISP_1_0 false  RX_CB_DISP_1_1 false \
RX_CB_DISP_1_2 false  RX_CB_DISP_1_3 false  RX_CB_K_0_0 false  RX_CB_K_0_1\
false  RX_CB_K_0_2 false  RX_CB_K_0_3 false  RX_CB_K_1_0 false  RX_CB_K_1_1\
false  RX_CB_K_1_2 false  RX_CB_K_1_3 false  RX_CB_LEN_SEQ 1  RX_CB_MASK_0_0\
false  RX_CB_MASK_0_1 false  RX_CB_MASK_0_2 false  RX_CB_MASK_0_3 false \
RX_CB_MASK_1_0 false  RX_CB_MASK_1_1 false  RX_CB_MASK_1_2 false \
RX_CB_MASK_1_3 false  RX_CB_MAX_LEVEL 1  RX_CB_MAX_SKEW 1  RX_CB_NUM_SEQ 0 \
RX_CB_VAL_0_0 00000000  RX_CB_VAL_0_1 00000000  RX_CB_VAL_0_2 00000000 \
RX_CB_VAL_0_3 00000000  RX_CB_VAL_1_0 00000000  RX_CB_VAL_1_1 00000000 \
RX_CB_VAL_1_2 00000000  RX_CB_VAL_1_3 00000000  RX_CC_DISP_0_0 false \
RX_CC_DISP_0_1 false  RX_CC_DISP_0_2 false  RX_CC_DISP_0_3 false \
RX_CC_DISP_1_0 false  RX_CC_DISP_1_1 false  RX_CC_DISP_1_2 false \
RX_CC_DISP_1_3 false  RX_CC_KEEP_IDLE DISABLE  RX_CC_K_0_0 false  RX_CC_K_0_1\
false  RX_CC_K_0_2 false  RX_CC_K_0_3 false  RX_CC_K_1_0 false  RX_CC_K_1_1\
false  RX_CC_K_1_2 false  RX_CC_K_1_3 false  RX_CC_LEN_SEQ 1  RX_CC_MASK_0_0\
false  RX_CC_MASK_0_1 false  RX_CC_MASK_0_2 false  RX_CC_MASK_0_3 false \
RX_CC_MASK_1_0 false  RX_CC_MASK_1_1 false  RX_CC_MASK_1_2 false \
RX_CC_MASK_1_3 false  RX_CC_NUM_SEQ 0  RX_CC_PERIODICITY 5000  RX_CC_PRECEDENCE\
ENABLE  RX_CC_REPEAT_WAIT 0  RX_CC_VAL\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
RX_CC_VAL_0_0 0000000000  RX_CC_VAL_0_1 0000000000  RX_CC_VAL_0_2 0000000000 \
RX_CC_VAL_0_3 0000000000  RX_CC_VAL_1_0 0000000000  RX_CC_VAL_1_1 0000000000 \
RX_CC_VAL_1_2 0000000000  RX_CC_VAL_1_3 0000000000  RX_COMMA_ALIGN_WORD 1 \
RX_COMMA_DOUBLE_ENABLE false  RX_COMMA_MASK 1111111111  RX_COMMA_M_ENABLE false\
RX_COMMA_M_VAL 1010000011  RX_COMMA_PRESET NONE  RX_COMMA_P_ENABLE false \
RX_COMMA_P_VAL 0101111100  RX_COMMA_SHOW_REALIGN_ENABLE true \
RX_COMMA_VALID_ONLY 0  RX_COUPLING AC  RX_DATA_DECODING RAW  RX_EQ_MODE AUTO \
RX_FRACN_ENABLED false  RX_FRACN_NUMERATOR 0  RX_INT_DATA_WIDTH 32  RX_JTOL_FC\
0  RX_JTOL_LF_SLOPE -20  RX_LINE_RATE 10.3125  RX_OUTCLK_SOURCE RXOUTCLKPMA \
RX_PLL_TYPE LCPLL  RX_PPM_OFFSET 0  RX_RATE_GROUP A  RX_REFCLK_FREQUENCY 156.25\
RX_REFCLK_SOURCE R0  RX_SLIDE_MODE OFF  RX_SSC_PPM 0  RX_TERMINATION\
PROGRAMMABLE  RX_TERMINATION_PROG_VALUE 800  RX_USER_DATA_WIDTH 32 \
TXPROGDIV_FREQ_ENABLE false  TXPROGDIV_FREQ_SOURCE LCPLL  TXPROGDIV_FREQ_VAL\
322.265625  TX_64B66B_CRC false  TX_64B66B_ENCODER false  TX_64B66B_SCRAMBLER\
false  TX_ACTUAL_REFCLK_FREQUENCY 156.25  TX_BUFFER_BYPASS_MODE Fast_Sync \
TX_BUFFER_MODE 1  TX_BUFFER_RESET_ON_RATE_CHANGE ENABLE  TX_DATA_ENCODING RAW \
TX_DIFF_SWING_EMPH_MODE CUSTOM  TX_FRACN_ENABLED false  TX_FRACN_NUMERATOR 0 \
TX_INT_DATA_WIDTH 32  TX_LINE_RATE 10.3125  TX_OUTCLK_SOURCE TXOUTCLKPMA \
TX_PIPM_ENABLE false  TX_PLL_TYPE LCPLL  TX_RATE_GROUP A  TX_REFCLK_FREQUENCY\
156.25  TX_REFCLK_SOURCE R0  TX_USER_DATA_WIDTH 32}\
   CONFIG.PROT3_LR0_SETTINGS {GT_DIRECTION DUPLEX  INS_LOSS_NYQ 20  INTERNAL_PRESET None  OOB_ENABLE false \
PCIE_ENABLE false  PCIE_USERCLK2_FREQ 250  PCIE_USERCLK_FREQ 250  PRESET None \
RESET_SEQUENCE_INTERVAL 0  RXPROGDIV_FREQ_ENABLE false  RXPROGDIV_FREQ_SOURCE\
LCPLL  RXPROGDIV_FREQ_VAL 322.265625  RX_64B66B_CRC false  RX_64B66B_DECODER\
false  RX_64B66B_DESCRAMBLER false  RX_ACTUAL_REFCLK_FREQUENCY 156.25 \
RX_BUFFER_BYPASS_MODE Fast_Sync  RX_BUFFER_BYPASS_MODE_LANE MULTI \
RX_BUFFER_MODE 1  RX_BUFFER_RESET_ON_CB_CHANGE ENABLE \
RX_BUFFER_RESET_ON_COMMAALIGN DISABLE  RX_BUFFER_RESET_ON_RATE_CHANGE ENABLE \
RX_CB_DISP_0_0 false  RX_CB_DISP_0_1 false  RX_CB_DISP_0_2 false \
RX_CB_DISP_0_3 false  RX_CB_DISP_1_0 false  RX_CB_DISP_1_1 false \
RX_CB_DISP_1_2 false  RX_CB_DISP_1_3 false  RX_CB_K_0_0 false  RX_CB_K_0_1\
false  RX_CB_K_0_2 false  RX_CB_K_0_3 false  RX_CB_K_1_0 false  RX_CB_K_1_1\
false  RX_CB_K_1_2 false  RX_CB_K_1_3 false  RX_CB_LEN_SEQ 1  RX_CB_MASK_0_0\
false  RX_CB_MASK_0_1 false  RX_CB_MASK_0_2 false  RX_CB_MASK_0_3 false \
RX_CB_MASK_1_0 false  RX_CB_MASK_1_1 false  RX_CB_MASK_1_2 false \
RX_CB_MASK_1_3 false  RX_CB_MAX_LEVEL 1  RX_CB_MAX_SKEW 1  RX_CB_NUM_SEQ 0 \
RX_CB_VAL_0_0 00000000  RX_CB_VAL_0_1 00000000  RX_CB_VAL_0_2 00000000 \
RX_CB_VAL_0_3 00000000  RX_CB_VAL_1_0 00000000  RX_CB_VAL_1_1 00000000 \
RX_CB_VAL_1_2 00000000  RX_CB_VAL_1_3 00000000  RX_CC_DISP_0_0 false \
RX_CC_DISP_0_1 false  RX_CC_DISP_0_2 false  RX_CC_DISP_0_3 false \
RX_CC_DISP_1_0 false  RX_CC_DISP_1_1 false  RX_CC_DISP_1_2 false \
RX_CC_DISP_1_3 false  RX_CC_KEEP_IDLE DISABLE  RX_CC_K_0_0 false  RX_CC_K_0_1\
false  RX_CC_K_0_2 false  RX_CC_K_0_3 false  RX_CC_K_1_0 false  RX_CC_K_1_1\
false  RX_CC_K_1_2 false  RX_CC_K_1_3 false  RX_CC_LEN_SEQ 1  RX_CC_MASK_0_0\
false  RX_CC_MASK_0_1 false  RX_CC_MASK_0_2 false  RX_CC_MASK_0_3 false \
RX_CC_MASK_1_0 false  RX_CC_MASK_1_1 false  RX_CC_MASK_1_2 false \
RX_CC_MASK_1_3 false  RX_CC_NUM_SEQ 0  RX_CC_PERIODICITY 5000  RX_CC_PRECEDENCE\
ENABLE  RX_CC_REPEAT_WAIT 0  RX_CC_VAL\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
RX_CC_VAL_0_0 0000000000  RX_CC_VAL_0_1 0000000000  RX_CC_VAL_0_2 0000000000 \
RX_CC_VAL_0_3 0000000000  RX_CC_VAL_1_0 0000000000  RX_CC_VAL_1_1 0000000000 \
RX_CC_VAL_1_2 0000000000  RX_CC_VAL_1_3 0000000000  RX_COMMA_ALIGN_WORD 1 \
RX_COMMA_DOUBLE_ENABLE false  RX_COMMA_MASK 1111111111  RX_COMMA_M_ENABLE false\
RX_COMMA_M_VAL 1010000011  RX_COMMA_PRESET NONE  RX_COMMA_P_ENABLE false \
RX_COMMA_P_VAL 0101111100  RX_COMMA_SHOW_REALIGN_ENABLE true \
RX_COMMA_VALID_ONLY 0  RX_COUPLING AC  RX_DATA_DECODING RAW  RX_EQ_MODE AUTO \
RX_FRACN_ENABLED false  RX_FRACN_NUMERATOR 0  RX_INT_DATA_WIDTH 32  RX_JTOL_FC\
0  RX_JTOL_LF_SLOPE -20  RX_LINE_RATE 10.3125  RX_OUTCLK_SOURCE RXOUTCLKPMA \
RX_PLL_TYPE LCPLL  RX_PPM_OFFSET 0  RX_RATE_GROUP A  RX_REFCLK_FREQUENCY 156.25\
RX_REFCLK_SOURCE R0  RX_SLIDE_MODE OFF  RX_SSC_PPM 0  RX_TERMINATION\
PROGRAMMABLE  RX_TERMINATION_PROG_VALUE 800  RX_USER_DATA_WIDTH 32 \
TXPROGDIV_FREQ_ENABLE false  TXPROGDIV_FREQ_SOURCE LCPLL  TXPROGDIV_FREQ_VAL\
322.265625  TX_64B66B_CRC false  TX_64B66B_ENCODER false  TX_64B66B_SCRAMBLER\
false  TX_ACTUAL_REFCLK_FREQUENCY 156.25  TX_BUFFER_BYPASS_MODE Fast_Sync \
TX_BUFFER_MODE 1  TX_BUFFER_RESET_ON_RATE_CHANGE ENABLE  TX_DATA_ENCODING RAW \
TX_DIFF_SWING_EMPH_MODE CUSTOM  TX_FRACN_ENABLED false  TX_FRACN_NUMERATOR 0 \
TX_INT_DATA_WIDTH 32  TX_LINE_RATE 10.3125  TX_OUTCLK_SOURCE TXOUTCLKPMA \
TX_PIPM_ENABLE false  TX_PLL_TYPE LCPLL  TX_RATE_GROUP A  TX_REFCLK_FREQUENCY\
156.25  TX_REFCLK_SOURCE R0  TX_USER_DATA_WIDTH 32}\
   CONFIG.PROT4_LR0_SETTINGS {GT_DIRECTION DUPLEX  INS_LOSS_NYQ 20  INTERNAL_PRESET None  OOB_ENABLE false \
PCIE_ENABLE false  PCIE_USERCLK2_FREQ 250  PCIE_USERCLK_FREQ 250  PRESET None \
RESET_SEQUENCE_INTERVAL 0  RXPROGDIV_FREQ_ENABLE false  RXPROGDIV_FREQ_SOURCE\
LCPLL  RXPROGDIV_FREQ_VAL 322.265625  RX_64B66B_CRC false  RX_64B66B_DECODER\
false  RX_64B66B_DESCRAMBLER false  RX_ACTUAL_REFCLK_FREQUENCY 156.25 \
RX_BUFFER_BYPASS_MODE Fast_Sync  RX_BUFFER_BYPASS_MODE_LANE MULTI \
RX_BUFFER_MODE 1  RX_BUFFER_RESET_ON_CB_CHANGE ENABLE \
RX_BUFFER_RESET_ON_COMMAALIGN DISABLE  RX_BUFFER_RESET_ON_RATE_CHANGE ENABLE \
RX_CB_DISP_0_0 false  RX_CB_DISP_0_1 false  RX_CB_DISP_0_2 false \
RX_CB_DISP_0_3 false  RX_CB_DISP_1_0 false  RX_CB_DISP_1_1 false \
RX_CB_DISP_1_2 false  RX_CB_DISP_1_3 false  RX_CB_K_0_0 false  RX_CB_K_0_1\
false  RX_CB_K_0_2 false  RX_CB_K_0_3 false  RX_CB_K_1_0 false  RX_CB_K_1_1\
false  RX_CB_K_1_2 false  RX_CB_K_1_3 false  RX_CB_LEN_SEQ 1  RX_CB_MASK_0_0\
false  RX_CB_MASK_0_1 false  RX_CB_MASK_0_2 false  RX_CB_MASK_0_3 false \
RX_CB_MASK_1_0 false  RX_CB_MASK_1_1 false  RX_CB_MASK_1_2 false \
RX_CB_MASK_1_3 false  RX_CB_MAX_LEVEL 1  RX_CB_MAX_SKEW 1  RX_CB_NUM_SEQ 0 \
RX_CB_VAL_0_0 00000000  RX_CB_VAL_0_1 00000000  RX_CB_VAL_0_2 00000000 \
RX_CB_VAL_0_3 00000000  RX_CB_VAL_1_0 00000000  RX_CB_VAL_1_1 00000000 \
RX_CB_VAL_1_2 00000000  RX_CB_VAL_1_3 00000000  RX_CC_DISP_0_0 false \
RX_CC_DISP_0_1 false  RX_CC_DISP_0_2 false  RX_CC_DISP_0_3 false \
RX_CC_DISP_1_0 false  RX_CC_DISP_1_1 false  RX_CC_DISP_1_2 false \
RX_CC_DISP_1_3 false  RX_CC_KEEP_IDLE DISABLE  RX_CC_K_0_0 false  RX_CC_K_0_1\
false  RX_CC_K_0_2 false  RX_CC_K_0_3 false  RX_CC_K_1_0 false  RX_CC_K_1_1\
false  RX_CC_K_1_2 false  RX_CC_K_1_3 false  RX_CC_LEN_SEQ 1  RX_CC_MASK_0_0\
false  RX_CC_MASK_0_1 false  RX_CC_MASK_0_2 false  RX_CC_MASK_0_3 false \
RX_CC_MASK_1_0 false  RX_CC_MASK_1_1 false  RX_CC_MASK_1_2 false \
RX_CC_MASK_1_3 false  RX_CC_NUM_SEQ 0  RX_CC_PERIODICITY 5000  RX_CC_PRECEDENCE\
ENABLE  RX_CC_REPEAT_WAIT 0  RX_CC_VAL\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
RX_CC_VAL_0_0 0000000000  RX_CC_VAL_0_1 0000000000  RX_CC_VAL_0_2 0000000000 \
RX_CC_VAL_0_3 0000000000  RX_CC_VAL_1_0 0000000000  RX_CC_VAL_1_1 0000000000 \
RX_CC_VAL_1_2 0000000000  RX_CC_VAL_1_3 0000000000  RX_COMMA_ALIGN_WORD 1 \
RX_COMMA_DOUBLE_ENABLE false  RX_COMMA_MASK 1111111111  RX_COMMA_M_ENABLE false\
RX_COMMA_M_VAL 1010000011  RX_COMMA_PRESET NONE  RX_COMMA_P_ENABLE false \
RX_COMMA_P_VAL 0101111100  RX_COMMA_SHOW_REALIGN_ENABLE true \
RX_COMMA_VALID_ONLY 0  RX_COUPLING AC  RX_DATA_DECODING RAW  RX_EQ_MODE AUTO \
RX_FRACN_ENABLED false  RX_FRACN_NUMERATOR 0  RX_INT_DATA_WIDTH 32  RX_JTOL_FC\
0  RX_JTOL_LF_SLOPE -20  RX_LINE_RATE 10.3125  RX_OUTCLK_SOURCE RXOUTCLKPMA \
RX_PLL_TYPE LCPLL  RX_PPM_OFFSET 0  RX_RATE_GROUP A  RX_REFCLK_FREQUENCY 156.25\
RX_REFCLK_SOURCE R0  RX_SLIDE_MODE OFF  RX_SSC_PPM 0  RX_TERMINATION\
PROGRAMMABLE  RX_TERMINATION_PROG_VALUE 800  RX_USER_DATA_WIDTH 32 \
TXPROGDIV_FREQ_ENABLE false  TXPROGDIV_FREQ_SOURCE LCPLL  TXPROGDIV_FREQ_VAL\
322.265625  TX_64B66B_CRC false  TX_64B66B_ENCODER false  TX_64B66B_SCRAMBLER\
false  TX_ACTUAL_REFCLK_FREQUENCY 156.25  TX_BUFFER_BYPASS_MODE Fast_Sync \
TX_BUFFER_MODE 1  TX_BUFFER_RESET_ON_RATE_CHANGE ENABLE  TX_DATA_ENCODING RAW \
TX_DIFF_SWING_EMPH_MODE CUSTOM  TX_FRACN_ENABLED false  TX_FRACN_NUMERATOR 0 \
TX_INT_DATA_WIDTH 32  TX_LINE_RATE 10.3125  TX_OUTCLK_SOURCE TXOUTCLKPMA \
TX_PIPM_ENABLE false  TX_PLL_TYPE LCPLL  TX_RATE_GROUP A  TX_REFCLK_FREQUENCY\
156.25  TX_REFCLK_SOURCE R0  TX_USER_DATA_WIDTH 32}\
   CONFIG.PROT5_LR0_SETTINGS {GT_DIRECTION DUPLEX  INS_LOSS_NYQ 20  INTERNAL_PRESET None  OOB_ENABLE false \
PCIE_ENABLE false  PCIE_USERCLK2_FREQ 250  PCIE_USERCLK_FREQ 250  PRESET None \
RESET_SEQUENCE_INTERVAL 0  RXPROGDIV_FREQ_ENABLE false  RXPROGDIV_FREQ_SOURCE\
LCPLL  RXPROGDIV_FREQ_VAL 322.265625  RX_64B66B_CRC false  RX_64B66B_DECODER\
false  RX_64B66B_DESCRAMBLER false  RX_ACTUAL_REFCLK_FREQUENCY 156.25 \
RX_BUFFER_BYPASS_MODE Fast_Sync  RX_BUFFER_BYPASS_MODE_LANE MULTI \
RX_BUFFER_MODE 1  RX_BUFFER_RESET_ON_CB_CHANGE ENABLE \
RX_BUFFER_RESET_ON_COMMAALIGN DISABLE  RX_BUFFER_RESET_ON_RATE_CHANGE ENABLE \
RX_CB_DISP_0_0 false  RX_CB_DISP_0_1 false  RX_CB_DISP_0_2 false \
RX_CB_DISP_0_3 false  RX_CB_DISP_1_0 false  RX_CB_DISP_1_1 false \
RX_CB_DISP_1_2 false  RX_CB_DISP_1_3 false  RX_CB_K_0_0 false  RX_CB_K_0_1\
false  RX_CB_K_0_2 false  RX_CB_K_0_3 false  RX_CB_K_1_0 false  RX_CB_K_1_1\
false  RX_CB_K_1_2 false  RX_CB_K_1_3 false  RX_CB_LEN_SEQ 1  RX_CB_MASK_0_0\
false  RX_CB_MASK_0_1 false  RX_CB_MASK_0_2 false  RX_CB_MASK_0_3 false \
RX_CB_MASK_1_0 false  RX_CB_MASK_1_1 false  RX_CB_MASK_1_2 false \
RX_CB_MASK_1_3 false  RX_CB_MAX_LEVEL 1  RX_CB_MAX_SKEW 1  RX_CB_NUM_SEQ 0 \
RX_CB_VAL_0_0 00000000  RX_CB_VAL_0_1 00000000  RX_CB_VAL_0_2 00000000 \
RX_CB_VAL_0_3 00000000  RX_CB_VAL_1_0 00000000  RX_CB_VAL_1_1 00000000 \
RX_CB_VAL_1_2 00000000  RX_CB_VAL_1_3 00000000  RX_CC_DISP_0_0 false \
RX_CC_DISP_0_1 false  RX_CC_DISP_0_2 false  RX_CC_DISP_0_3 false \
RX_CC_DISP_1_0 false  RX_CC_DISP_1_1 false  RX_CC_DISP_1_2 false \
RX_CC_DISP_1_3 false  RX_CC_KEEP_IDLE DISABLE  RX_CC_K_0_0 false  RX_CC_K_0_1\
false  RX_CC_K_0_2 false  RX_CC_K_0_3 false  RX_CC_K_1_0 false  RX_CC_K_1_1\
false  RX_CC_K_1_2 false  RX_CC_K_1_3 false  RX_CC_LEN_SEQ 1  RX_CC_MASK_0_0\
false  RX_CC_MASK_0_1 false  RX_CC_MASK_0_2 false  RX_CC_MASK_0_3 false \
RX_CC_MASK_1_0 false  RX_CC_MASK_1_1 false  RX_CC_MASK_1_2 false \
RX_CC_MASK_1_3 false  RX_CC_NUM_SEQ 0  RX_CC_PERIODICITY 5000  RX_CC_PRECEDENCE\
ENABLE  RX_CC_REPEAT_WAIT 0  RX_CC_VAL\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
RX_CC_VAL_0_0 0000000000  RX_CC_VAL_0_1 0000000000  RX_CC_VAL_0_2 0000000000 \
RX_CC_VAL_0_3 0000000000  RX_CC_VAL_1_0 0000000000  RX_CC_VAL_1_1 0000000000 \
RX_CC_VAL_1_2 0000000000  RX_CC_VAL_1_3 0000000000  RX_COMMA_ALIGN_WORD 1 \
RX_COMMA_DOUBLE_ENABLE false  RX_COMMA_MASK 1111111111  RX_COMMA_M_ENABLE false\
RX_COMMA_M_VAL 1010000011  RX_COMMA_PRESET NONE  RX_COMMA_P_ENABLE false \
RX_COMMA_P_VAL 0101111100  RX_COMMA_SHOW_REALIGN_ENABLE true \
RX_COMMA_VALID_ONLY 0  RX_COUPLING AC  RX_DATA_DECODING RAW  RX_EQ_MODE AUTO \
RX_FRACN_ENABLED false  RX_FRACN_NUMERATOR 0  RX_INT_DATA_WIDTH 32  RX_JTOL_FC\
0  RX_JTOL_LF_SLOPE -20  RX_LINE_RATE 10.3125  RX_OUTCLK_SOURCE RXOUTCLKPMA \
RX_PLL_TYPE LCPLL  RX_PPM_OFFSET 0  RX_RATE_GROUP A  RX_REFCLK_FREQUENCY 156.25\
RX_REFCLK_SOURCE R0  RX_SLIDE_MODE OFF  RX_SSC_PPM 0  RX_TERMINATION\
PROGRAMMABLE  RX_TERMINATION_PROG_VALUE 800  RX_USER_DATA_WIDTH 32 \
TXPROGDIV_FREQ_ENABLE false  TXPROGDIV_FREQ_SOURCE LCPLL  TXPROGDIV_FREQ_VAL\
322.265625  TX_64B66B_CRC false  TX_64B66B_ENCODER false  TX_64B66B_SCRAMBLER\
false  TX_ACTUAL_REFCLK_FREQUENCY 156.25  TX_BUFFER_BYPASS_MODE Fast_Sync \
TX_BUFFER_MODE 1  TX_BUFFER_RESET_ON_RATE_CHANGE ENABLE  TX_DATA_ENCODING RAW \
TX_DIFF_SWING_EMPH_MODE CUSTOM  TX_FRACN_ENABLED false  TX_FRACN_NUMERATOR 0 \
TX_INT_DATA_WIDTH 32  TX_LINE_RATE 10.3125  TX_OUTCLK_SOURCE TXOUTCLKPMA \
TX_PIPM_ENABLE false  TX_PLL_TYPE LCPLL  TX_RATE_GROUP A  TX_REFCLK_FREQUENCY\
156.25  TX_REFCLK_SOURCE R0  TX_USER_DATA_WIDTH 32}\
   CONFIG.PROT6_LR0_SETTINGS {GT_DIRECTION DUPLEX  INS_LOSS_NYQ 20  INTERNAL_PRESET None  OOB_ENABLE false \
PCIE_ENABLE false  PCIE_USERCLK2_FREQ 250  PCIE_USERCLK_FREQ 250  PRESET None \
RESET_SEQUENCE_INTERVAL 0  RXPROGDIV_FREQ_ENABLE false  RXPROGDIV_FREQ_SOURCE\
LCPLL  RXPROGDIV_FREQ_VAL 322.265625  RX_64B66B_CRC false  RX_64B66B_DECODER\
false  RX_64B66B_DESCRAMBLER false  RX_ACTUAL_REFCLK_FREQUENCY 156.25 \
RX_BUFFER_BYPASS_MODE Fast_Sync  RX_BUFFER_BYPASS_MODE_LANE MULTI \
RX_BUFFER_MODE 1  RX_BUFFER_RESET_ON_CB_CHANGE ENABLE \
RX_BUFFER_RESET_ON_COMMAALIGN DISABLE  RX_BUFFER_RESET_ON_RATE_CHANGE ENABLE \
RX_CB_DISP_0_0 false  RX_CB_DISP_0_1 false  RX_CB_DISP_0_2 false \
RX_CB_DISP_0_3 false  RX_CB_DISP_1_0 false  RX_CB_DISP_1_1 false \
RX_CB_DISP_1_2 false  RX_CB_DISP_1_3 false  RX_CB_K_0_0 false  RX_CB_K_0_1\
false  RX_CB_K_0_2 false  RX_CB_K_0_3 false  RX_CB_K_1_0 false  RX_CB_K_1_1\
false  RX_CB_K_1_2 false  RX_CB_K_1_3 false  RX_CB_LEN_SEQ 1  RX_CB_MASK_0_0\
false  RX_CB_MASK_0_1 false  RX_CB_MASK_0_2 false  RX_CB_MASK_0_3 false \
RX_CB_MASK_1_0 false  RX_CB_MASK_1_1 false  RX_CB_MASK_1_2 false \
RX_CB_MASK_1_3 false  RX_CB_MAX_LEVEL 1  RX_CB_MAX_SKEW 1  RX_CB_NUM_SEQ 0 \
RX_CB_VAL_0_0 00000000  RX_CB_VAL_0_1 00000000  RX_CB_VAL_0_2 00000000 \
RX_CB_VAL_0_3 00000000  RX_CB_VAL_1_0 00000000  RX_CB_VAL_1_1 00000000 \
RX_CB_VAL_1_2 00000000  RX_CB_VAL_1_3 00000000  RX_CC_DISP_0_0 false \
RX_CC_DISP_0_1 false  RX_CC_DISP_0_2 false  RX_CC_DISP_0_3 false \
RX_CC_DISP_1_0 false  RX_CC_DISP_1_1 false  RX_CC_DISP_1_2 false \
RX_CC_DISP_1_3 false  RX_CC_KEEP_IDLE DISABLE  RX_CC_K_0_0 false  RX_CC_K_0_1\
false  RX_CC_K_0_2 false  RX_CC_K_0_3 false  RX_CC_K_1_0 false  RX_CC_K_1_1\
false  RX_CC_K_1_2 false  RX_CC_K_1_3 false  RX_CC_LEN_SEQ 1  RX_CC_MASK_0_0\
false  RX_CC_MASK_0_1 false  RX_CC_MASK_0_2 false  RX_CC_MASK_0_3 false \
RX_CC_MASK_1_0 false  RX_CC_MASK_1_1 false  RX_CC_MASK_1_2 false \
RX_CC_MASK_1_3 false  RX_CC_NUM_SEQ 0  RX_CC_PERIODICITY 5000  RX_CC_PRECEDENCE\
ENABLE  RX_CC_REPEAT_WAIT 0  RX_CC_VAL\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
RX_CC_VAL_0_0 0000000000  RX_CC_VAL_0_1 0000000000  RX_CC_VAL_0_2 0000000000 \
RX_CC_VAL_0_3 0000000000  RX_CC_VAL_1_0 0000000000  RX_CC_VAL_1_1 0000000000 \
RX_CC_VAL_1_2 0000000000  RX_CC_VAL_1_3 0000000000  RX_COMMA_ALIGN_WORD 1 \
RX_COMMA_DOUBLE_ENABLE false  RX_COMMA_MASK 1111111111  RX_COMMA_M_ENABLE false\
RX_COMMA_M_VAL 1010000011  RX_COMMA_PRESET NONE  RX_COMMA_P_ENABLE false \
RX_COMMA_P_VAL 0101111100  RX_COMMA_SHOW_REALIGN_ENABLE true \
RX_COMMA_VALID_ONLY 0  RX_COUPLING AC  RX_DATA_DECODING RAW  RX_EQ_MODE AUTO \
RX_FRACN_ENABLED false  RX_FRACN_NUMERATOR 0  RX_INT_DATA_WIDTH 32  RX_JTOL_FC\
0  RX_JTOL_LF_SLOPE -20  RX_LINE_RATE 10.3125  RX_OUTCLK_SOURCE RXOUTCLKPMA \
RX_PLL_TYPE LCPLL  RX_PPM_OFFSET 0  RX_RATE_GROUP A  RX_REFCLK_FREQUENCY 156.25\
RX_REFCLK_SOURCE R0  RX_SLIDE_MODE OFF  RX_SSC_PPM 0  RX_TERMINATION\
PROGRAMMABLE  RX_TERMINATION_PROG_VALUE 800  RX_USER_DATA_WIDTH 32 \
TXPROGDIV_FREQ_ENABLE false  TXPROGDIV_FREQ_SOURCE LCPLL  TXPROGDIV_FREQ_VAL\
322.265625  TX_64B66B_CRC false  TX_64B66B_ENCODER false  TX_64B66B_SCRAMBLER\
false  TX_ACTUAL_REFCLK_FREQUENCY 156.25  TX_BUFFER_BYPASS_MODE Fast_Sync \
TX_BUFFER_MODE 1  TX_BUFFER_RESET_ON_RATE_CHANGE ENABLE  TX_DATA_ENCODING RAW \
TX_DIFF_SWING_EMPH_MODE CUSTOM  TX_FRACN_ENABLED false  TX_FRACN_NUMERATOR 0 \
TX_INT_DATA_WIDTH 32  TX_LINE_RATE 10.3125  TX_OUTCLK_SOURCE TXOUTCLKPMA \
TX_PIPM_ENABLE false  TX_PLL_TYPE LCPLL  TX_RATE_GROUP A  TX_REFCLK_FREQUENCY\
156.25  TX_REFCLK_SOURCE R0  TX_USER_DATA_WIDTH 32}\
   CONFIG.PROT7_LR0_SETTINGS {GT_DIRECTION DUPLEX  INS_LOSS_NYQ 20  INTERNAL_PRESET None  OOB_ENABLE false \
PCIE_ENABLE false  PCIE_USERCLK2_FREQ 250  PCIE_USERCLK_FREQ 250  PRESET None \
RESET_SEQUENCE_INTERVAL 0  RXPROGDIV_FREQ_ENABLE false  RXPROGDIV_FREQ_SOURCE\
LCPLL  RXPROGDIV_FREQ_VAL 322.265625  RX_64B66B_CRC false  RX_64B66B_DECODER\
false  RX_64B66B_DESCRAMBLER false  RX_ACTUAL_REFCLK_FREQUENCY 156.25 \
RX_BUFFER_BYPASS_MODE Fast_Sync  RX_BUFFER_BYPASS_MODE_LANE MULTI \
RX_BUFFER_MODE 1  RX_BUFFER_RESET_ON_CB_CHANGE ENABLE \
RX_BUFFER_RESET_ON_COMMAALIGN DISABLE  RX_BUFFER_RESET_ON_RATE_CHANGE ENABLE \
RX_CB_DISP_0_0 false  RX_CB_DISP_0_1 false  RX_CB_DISP_0_2 false \
RX_CB_DISP_0_3 false  RX_CB_DISP_1_0 false  RX_CB_DISP_1_1 false \
RX_CB_DISP_1_2 false  RX_CB_DISP_1_3 false  RX_CB_K_0_0 false  RX_CB_K_0_1\
false  RX_CB_K_0_2 false  RX_CB_K_0_3 false  RX_CB_K_1_0 false  RX_CB_K_1_1\
false  RX_CB_K_1_2 false  RX_CB_K_1_3 false  RX_CB_LEN_SEQ 1  RX_CB_MASK_0_0\
false  RX_CB_MASK_0_1 false  RX_CB_MASK_0_2 false  RX_CB_MASK_0_3 false \
RX_CB_MASK_1_0 false  RX_CB_MASK_1_1 false  RX_CB_MASK_1_2 false \
RX_CB_MASK_1_3 false  RX_CB_MAX_LEVEL 1  RX_CB_MAX_SKEW 1  RX_CB_NUM_SEQ 0 \
RX_CB_VAL_0_0 00000000  RX_CB_VAL_0_1 00000000  RX_CB_VAL_0_2 00000000 \
RX_CB_VAL_0_3 00000000  RX_CB_VAL_1_0 00000000  RX_CB_VAL_1_1 00000000 \
RX_CB_VAL_1_2 00000000  RX_CB_VAL_1_3 00000000  RX_CC_DISP_0_0 false \
RX_CC_DISP_0_1 false  RX_CC_DISP_0_2 false  RX_CC_DISP_0_3 false \
RX_CC_DISP_1_0 false  RX_CC_DISP_1_1 false  RX_CC_DISP_1_2 false \
RX_CC_DISP_1_3 false  RX_CC_KEEP_IDLE DISABLE  RX_CC_K_0_0 false  RX_CC_K_0_1\
false  RX_CC_K_0_2 false  RX_CC_K_0_3 false  RX_CC_K_1_0 false  RX_CC_K_1_1\
false  RX_CC_K_1_2 false  RX_CC_K_1_3 false  RX_CC_LEN_SEQ 1  RX_CC_MASK_0_0\
false  RX_CC_MASK_0_1 false  RX_CC_MASK_0_2 false  RX_CC_MASK_0_3 false \
RX_CC_MASK_1_0 false  RX_CC_MASK_1_1 false  RX_CC_MASK_1_2 false \
RX_CC_MASK_1_3 false  RX_CC_NUM_SEQ 0  RX_CC_PERIODICITY 5000  RX_CC_PRECEDENCE\
ENABLE  RX_CC_REPEAT_WAIT 0  RX_CC_VAL\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
RX_CC_VAL_0_0 0000000000  RX_CC_VAL_0_1 0000000000  RX_CC_VAL_0_2 0000000000 \
RX_CC_VAL_0_3 0000000000  RX_CC_VAL_1_0 0000000000  RX_CC_VAL_1_1 0000000000 \
RX_CC_VAL_1_2 0000000000  RX_CC_VAL_1_3 0000000000  RX_COMMA_ALIGN_WORD 1 \
RX_COMMA_DOUBLE_ENABLE false  RX_COMMA_MASK 1111111111  RX_COMMA_M_ENABLE false\
RX_COMMA_M_VAL 1010000011  RX_COMMA_PRESET NONE  RX_COMMA_P_ENABLE false \
RX_COMMA_P_VAL 0101111100  RX_COMMA_SHOW_REALIGN_ENABLE true \
RX_COMMA_VALID_ONLY 0  RX_COUPLING AC  RX_DATA_DECODING RAW  RX_EQ_MODE AUTO \
RX_FRACN_ENABLED false  RX_FRACN_NUMERATOR 0  RX_INT_DATA_WIDTH 32  RX_JTOL_FC\
0  RX_JTOL_LF_SLOPE -20  RX_LINE_RATE 10.3125  RX_OUTCLK_SOURCE RXOUTCLKPMA \
RX_PLL_TYPE LCPLL  RX_PPM_OFFSET 0  RX_RATE_GROUP A  RX_REFCLK_FREQUENCY 156.25\
RX_REFCLK_SOURCE R0  RX_SLIDE_MODE OFF  RX_SSC_PPM 0  RX_TERMINATION\
PROGRAMMABLE  RX_TERMINATION_PROG_VALUE 800  RX_USER_DATA_WIDTH 32 \
TXPROGDIV_FREQ_ENABLE false  TXPROGDIV_FREQ_SOURCE LCPLL  TXPROGDIV_FREQ_VAL\
322.265625  TX_64B66B_CRC false  TX_64B66B_ENCODER false  TX_64B66B_SCRAMBLER\
false  TX_ACTUAL_REFCLK_FREQUENCY 156.25  TX_BUFFER_BYPASS_MODE Fast_Sync \
TX_BUFFER_MODE 1  TX_BUFFER_RESET_ON_RATE_CHANGE ENABLE  TX_DATA_ENCODING RAW \
TX_DIFF_SWING_EMPH_MODE CUSTOM  TX_FRACN_ENABLED false  TX_FRACN_NUMERATOR 0 \
TX_INT_DATA_WIDTH 32  TX_LINE_RATE 10.3125  TX_OUTCLK_SOURCE TXOUTCLKPMA \
TX_PIPM_ENABLE false  TX_PLL_TYPE LCPLL  TX_RATE_GROUP A  TX_REFCLK_FREQUENCY\
156.25  TX_REFCLK_SOURCE R0  TX_USER_DATA_WIDTH 32}\
   CONFIG.PROT_OUTCLK_VALUES {CH0_RXOUTCLK 390.625 CH0_TXOUTCLK 148.5 CH1_RXOUTCLK 390.625 CH1_TXOUTCLK 148.5\
CH2_RXOUTCLK 390.625 CH2_TXOUTCLK 148.5 CH3_RXOUTCLK 390.625 CH3_TXOUTCLK 148.5}\
   CONFIG.REFCLK_STRING {HSCLK0_LCPLLGTREFCLK1 refclk_PROT0_R1_multiple_ext_freq HSCLK1_LCPLLGTREFCLK1\
refclk_PROT0_R1_multiple_ext_freq}\
 ] $gt_quad_base_1

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant xlconstant_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net CH0_DEBUG_1 [get_bd_intf_pins CH0_DEBUG] [get_bd_intf_pins gt_quad_base_1/CH0_DEBUG]
  connect_bd_intf_net -intf_net CH1_DEBUG_1 [get_bd_intf_pins CH1_DEBUG] [get_bd_intf_pins gt_quad_base_1/CH1_DEBUG]
  connect_bd_intf_net -intf_net CH2_DEBUG_1 [get_bd_intf_pins CH2_DEBUG] [get_bd_intf_pins gt_quad_base_1/CH2_DEBUG]
  connect_bd_intf_net -intf_net CH3_DEBUG_1 [get_bd_intf_pins CH3_DEBUG] [get_bd_intf_pins gt_quad_base_1/CH3_DEBUG]
  connect_bd_intf_net -intf_net GT_DEBUG_1 [get_bd_intf_pins GT_DEBUG] [get_bd_intf_pins gt_quad_base_1/GT_DEBUG]
  connect_bd_intf_net -intf_net TX0_GT_IP_Interface_1 [get_bd_intf_pins TX0_GT_IP_Interface] [get_bd_intf_pins gt_quad_base_1/TX0_GT_IP_Interface]
  connect_bd_intf_net -intf_net TX1_GT_IP_Interface_1 [get_bd_intf_pins TX1_GT_IP_Interface] [get_bd_intf_pins gt_quad_base_1/TX1_GT_IP_Interface]
  connect_bd_intf_net -intf_net TX2_GT_IP_Interface_1 [get_bd_intf_pins TX2_GT_IP_Interface] [get_bd_intf_pins gt_quad_base_1/TX2_GT_IP_Interface]
  connect_bd_intf_net -intf_net TX3_GT_IP_Interface_1 [get_bd_intf_pins TX3_GT_IP_Interface] [get_bd_intf_pins gt_quad_base_1/TX3_GT_IP_Interface]

  # Create port connections
  connect_bd_net -net GT_REFCLK1_1 [get_bd_pins GT_REFCLK1] [get_bd_pins gt_quad_base_1/GT_REFCLK0]
  connect_bd_net -net RX_DATA_IN_rxn [get_bd_pins RX_DATA_IN_rxn] [get_bd_pins gt_quad_base_1/rxn]
  connect_bd_net -net RX_DATA_IN_rxp [get_bd_pins RX_DATA_IN_rxp] [get_bd_pins gt_quad_base_1/rxp]
  connect_bd_net -net altclk_1 [get_bd_pins altclk] [get_bd_pins gt_quad_base_1/altclk] [get_bd_pins gt_quad_base_1/apb3clk]
  connect_bd_net -net bufg_gt_1_usrclk [get_bd_pins tx_usrclk] [get_bd_pins bufg_gt_tx/usrclk] [get_bd_pins gt_quad_base_1/ch0_txusrclk] [get_bd_pins gt_quad_base_1/ch1_txusrclk] [get_bd_pins gt_quad_base_1/ch2_txusrclk] [get_bd_pins gt_quad_base_1/ch3_txusrclk]
  connect_bd_net -net gt_quad_base_1_ch0_iloresetdone [get_bd_pins ch0_iloresetdone] [get_bd_pins gt_quad_base_1/ch0_iloresetdone]
  connect_bd_net -net gt_quad_base_1_ch0_txoutclk [get_bd_pins bufg_gt_tx/outclk] [get_bd_pins gt_quad_base_1/ch0_txoutclk]
  connect_bd_net -net gt_quad_base_1_ch1_iloresetdone [get_bd_pins ch1_iloresetdone] [get_bd_pins gt_quad_base_1/ch1_iloresetdone]
  connect_bd_net -net gt_quad_base_1_ch2_iloresetdone [get_bd_pins ch2_iloresetdone] [get_bd_pins gt_quad_base_1/ch2_iloresetdone]
  connect_bd_net -net gt_quad_base_1_ch3_iloresetdone [get_bd_pins ch3_iloresetdone] [get_bd_pins gt_quad_base_1/ch3_iloresetdone]
  connect_bd_net -net gt_quad_base_1_gtpowergood [get_bd_pins gtpowergood] [get_bd_pins gt_quad_base_1/gtpowergood]
  connect_bd_net -net gt_quad_base_1_hsclk0_lcplllock [get_bd_pins hsclk0_lcplllock] [get_bd_pins gt_quad_base_1/hsclk0_lcplllock]
  connect_bd_net -net gt_quad_base_1_hsclk1_lcplllock [get_bd_pins hsclk1_lcplllock] [get_bd_pins gt_quad_base_1/hsclk1_lcplllock]
  connect_bd_net -net gt_quad_base_1_txn [get_bd_pins TX_DATA_OUT_txn] [get_bd_pins gt_quad_base_1/txn]
  connect_bd_net -net gt_quad_base_1_txp [get_bd_pins TX_DATA_OUT_txp] [get_bd_pins gt_quad_base_1/txp]
  connect_bd_net -net hsclk0_lcpllreset_1 [get_bd_pins hsclk0_lcpllreset] [get_bd_pins gt_quad_base_1/hsclk0_lcpllreset]
  connect_bd_net -net hsclk1_lcpllreset_1 [get_bd_pins hsclk1_lcpllreset] [get_bd_pins gt_quad_base_1/hsclk1_lcpllreset]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins gt_quad_base_1/ch0_rxusrclk] [get_bd_pins gt_quad_base_1/ch1_rxusrclk] [get_bd_pins gt_quad_base_1/ch2_rxusrclk] [get_bd_pins gt_quad_base_1/ch3_rxusrclk] [get_bd_pins xlconstant_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: mipi_csi_rx_ss
proc create_hier_cell_mipi_csi_rx_ss { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_mipi_csi_rx_ss() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC_sensor

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 csirxss_s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_csi

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 video_out


  # Create pins
  create_bd_pin -dir O -type intr csirxss_csi_irq
  create_bd_pin -dir I -type clk dphy_clk_200M
  create_bd_pin -dir O -type intr iic2intc_irpt
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir I -type clk video_aclk
  create_bd_pin -dir I -type rst video_aresetn

  # Create instance: axi_iic_1_sensor, and set properties
  set axi_iic_1_sensor [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic axi_iic_1_sensor ]
  set_property -dict [ list \
   CONFIG.IIC_FREQ_KHZ {400} \
 ] $axi_iic_1_sensor

  # Create instance: mipi_csi2_rx_subsyst_0, and set properties
  set mipi_csi2_rx_subsyst_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem mipi_csi2_rx_subsyst_0 ]
  set_property -dict [ list \
   CONFIG.CMN_NUM_LANES {4} \
   CONFIG.CMN_NUM_PIXELS {4} \
   CONFIG.CMN_PXL_FORMAT {RAW10} \
   CONFIG.CMN_VC {0} \
   CONFIG.CSI_BUF_DEPTH {8192} \
   CONFIG.C_CSI2RX_DBG {1} \
   CONFIG.C_CSI_EN_ACTIVELANES {true} \
   CONFIG.C_CSI_FILTER_USERDATATYPE {true} \
   CONFIG.C_DPHY_LANES {4} \
   CONFIG.C_EXDES_BOARD {ZCU102} \
   CONFIG.C_HS_LINE_RATE {1440} \
   CONFIG.C_HS_SETTLE_NS {141} \
   CONFIG.C_STRETCH_LINE_RATE {2500} \
   CONFIG.DPY_EN_REG_IF {false} \
   CONFIG.DPY_LINE_RATE {1440} \
   CONFIG.SupportLevel {1} \
 ] $mipi_csi2_rx_subsyst_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_iic_1_sensor_IIC [get_bd_intf_pins IIC_sensor] [get_bd_intf_pins axi_iic_1_sensor/IIC]
  connect_bd_intf_net -intf_net mipi_csi2_rx_subsyst_0_video_out [get_bd_intf_pins video_out] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/video_out]
  connect_bd_intf_net -intf_net mipi_phy_csi_1 [get_bd_intf_pins mipi_phy_csi] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/mipi_phy_if]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins csirxss_s_axi] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/csirxss_s_axi]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_iic_1_sensor/S_AXI]

  # Create port connections
  connect_bd_net -net axi_iic_1_sensor_iic2intc_irpt [get_bd_pins iic2intc_irpt] [get_bd_pins axi_iic_1_sensor/iic2intc_irpt]
  connect_bd_net -net clk_wizard_0_clk_out1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_iic_1_sensor/s_axi_aclk] [get_bd_pins mipi_csi2_rx_subsyst_0/lite_aclk]
  connect_bd_net -net clk_wizard_0_clk_out2 [get_bd_pins dphy_clk_200M] [get_bd_pins mipi_csi2_rx_subsyst_0/dphy_clk_200M]
  connect_bd_net -net clk_wizard_0_clk_out3 [get_bd_pins video_aclk] [get_bd_pins mipi_csi2_rx_subsyst_0/video_aclk]
  connect_bd_net -net mipi_csi2_rx_subsyst_0_csirxss_csi_irq [get_bd_pins csirxss_csi_irq] [get_bd_pins mipi_csi2_rx_subsyst_0/csirxss_csi_irq]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_iic_1_sensor/s_axi_aresetn] [get_bd_pins mipi_csi2_rx_subsyst_0/lite_aresetn]
  connect_bd_net -net proc_sys_reset_1_peripheral_aresetn [get_bd_pins video_aresetn] [get_bd_pins mipi_csi2_rx_subsyst_0/video_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: cap_pipe
proc create_hier_cell_cap_pipe { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_cap_pipe() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_CTRL

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_CTRL1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_ctrl_1


  # Create pins
  create_bd_pin -dir I -from 31 -to 0 Din
  create_bd_pin -dir O -from 0 -to 0 Dout
  create_bd_pin -dir O -from 0 -to 0 dout_1
  create_bd_pin -dir O -type intr interrupt
  create_bd_pin -dir I -type clk video_clk
  create_bd_pin -dir I -type rst video_rst_n

  # Create instance: ISPPipeline_accel_0, and set properties
  set ISPPipeline_accel_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:ISPPipeline_accel ISPPipeline_accel_0 ]

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_0

  # Create instance: axis_subset_converter_0, and set properties
  set axis_subset_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter axis_subset_converter_0 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {5} \
   CONFIG.S_TDATA_NUM_BYTES {5} \
   CONFIG.TDATA_REMAP {tdata[39:0]} \
 ] $axis_subset_converter_0

  # Create instance: v_frmbuf_wr_0, and set properties
  set v_frmbuf_wr_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr v_frmbuf_wr_0 ]
  set_property -dict [ list \
   CONFIG.AXIMM_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO_DATA_WIDTH {256} \
   CONFIG.HAS_BGR8 {0} \
   CONFIG.HAS_BGRX8 {0} \
   CONFIG.HAS_RGBX8 {0} \
   CONFIG.HAS_UYVY8 {0} \
   CONFIG.HAS_Y8 {0} \
   CONFIG.HAS_YUV8 {0} \
   CONFIG.HAS_YUVX8 {0} \
   CONFIG.HAS_YUYV8 {1} \
   CONFIG.HAS_Y_UV8 {0} \
   CONFIG.MAX_NR_PLANES {1} \
   CONFIG.SAMPLES_PER_CLOCK {4} \
 ] $v_frmbuf_wr_0

  # Create instance: v_proc_ss_0, and set properties
  set v_proc_ss_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_proc_ss v_proc_ss_0 ]
  set_property -dict [ list \
   CONFIG.C_COLORSPACE_SUPPORT {1} \
   CONFIG.C_ENABLE_CSC {true} \
   CONFIG.C_MAX_DATA_WIDTH {8} \
   CONFIG.C_SAMPLES_PER_CLK {4} \
   CONFIG.C_TOPOLOGY {0} \
 ] $v_proc_ss_0

  # Create instance: vcc, and set properties
  set vcc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant vcc ]

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {2} \
   CONFIG.DIN_TO {2} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_1

  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {3} \
   CONFIG.DIN_TO {3} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_2

  # Create instance: xlslice_3, and set properties
  set xlslice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_3 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {4} \
   CONFIG.DIN_TO {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_3

  # Create interface connections
  connect_bd_intf_net -intf_net ISPPipeline_accel_0_m_axis_video [get_bd_intf_pins ISPPipeline_accel_0/m_axis_video] [get_bd_intf_pins v_proc_ss_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins ISPPipeline_accel_0/s_axis_video] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_subset_converter_0/M_AXIS]
  connect_bd_intf_net -intf_net mipi_csi2_rx_subsyst_0_video_out [get_bd_intf_pins S_AXIS] [get_bd_intf_pins axis_subset_converter_0/S_AXIS]
  connect_bd_intf_net -intf_net s_axi_ctrl_1_1 [get_bd_intf_pins s_axi_ctrl_1] [get_bd_intf_pins v_proc_ss_0/s_axi_ctrl]
  connect_bd_intf_net -intf_net smartconnect_2_M00_AXI [get_bd_intf_pins s_axi_CTRL1] [get_bd_intf_pins ISPPipeline_accel_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net smartconnect_2_M03_AXI [get_bd_intf_pins s_axi_CTRL] [get_bd_intf_pins v_frmbuf_wr_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net v_frmbuf_wr_0_m_axi_mm_video [get_bd_intf_pins M00_AXI] [get_bd_intf_pins v_frmbuf_wr_0/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_proc_ss_0_m_axis [get_bd_intf_pins v_frmbuf_wr_0/s_axis_video] [get_bd_intf_pins v_proc_ss_0/m_axis]

  # Create port connections
  connect_bd_net -net ap_rst_n_1 [get_bd_pins video_rst_n] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_subset_converter_0/aresetn]
  connect_bd_net -net axi_gpio_0_gpio_io_o [get_bd_pins Din] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din] [get_bd_pins xlslice_2/Din] [get_bd_pins xlslice_3/Din]
  connect_bd_net -net clk_wizard_0_clk_out3 [get_bd_pins video_clk] [get_bd_pins ISPPipeline_accel_0/ap_clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins v_frmbuf_wr_0/ap_clk] [get_bd_pins v_proc_ss_0/aclk_axis] [get_bd_pins v_proc_ss_0/aclk_ctrl]
  connect_bd_net -net v_frmbuf_wr_0_interrupt [get_bd_pins interrupt] [get_bd_pins v_frmbuf_wr_0/interrupt]
  connect_bd_net -net vcc_dout [get_bd_pins dout_1] [get_bd_pins vcc/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins ISPPipeline_accel_0/ap_rst_n] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_3_Dout [get_bd_pins v_proc_ss_0/aresetn_ctrl] [get_bd_pins xlslice_1/Dout]
  connect_bd_net -net xlslice_4_Dout [get_bd_pins v_frmbuf_wr_0/ap_rst_n] [get_bd_pins xlslice_2/Dout]
  connect_bd_net -net xlslice_5_Dout [get_bd_pins Dout] [get_bd_pins xlslice_3/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hdmi_tx_pipe
proc create_hier_cell_hdmi_tx_pipe { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hdmi_tx_pipe() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 HDMI_CTL_IIC

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CPU_IN

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 TX_DDC_OUT

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 axi4lite

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_video


  # Create pins
  create_bd_pin -dir I -type rst ARESETN
  create_bd_pin -dir I IDT_8T49N241_LOL_IN
  create_bd_pin -dir I -from 3 -to 0 RX_DATA_IN_rxn
  create_bd_pin -dir I -from 3 -to 0 RX_DATA_IN_rxp
  create_bd_pin -dir O -from 3 -to 0 TX_DATA_OUT_txn
  create_bd_pin -dir O -from 3 -to 0 TX_DATA_OUT_txp
  create_bd_pin -dir O -from 0 -to 0 -type rst TX_EN_OUT
  create_bd_pin -dir I TX_HPD_IN
  create_bd_pin -dir I -from 0 -to 0 -type clk TX_REFCLK_N_IN
  create_bd_pin -dir I -from 0 -to 0 -type clk TX_REFCLK_P_IN
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I altclk
  create_bd_pin -dir I -type rst aresetn1
  create_bd_pin -dir O -type intr iic2intc_irpt
  create_bd_pin -dir O -type intr irq
  create_bd_pin -dir O -type intr irq1

  # Create instance: GT_Quad_and_Clk
  create_hier_cell_GT_Quad_and_Clk $hier_obj GT_Quad_and_Clk

  # Create instance: fmch_axi_iic, and set properties
  set fmch_axi_iic [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic fmch_axi_iic ]

  # Create instance: gt_refclk1
  create_hier_cell_gt_refclk1 $hier_obj gt_refclk1

  # Create instance: hdmi_gt_controller_1, and set properties
  set hdmi_gt_controller_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:hdmi_gt_controller hdmi_gt_controller_1 ]
  set_property -dict [ list \
   CONFIG.C_FOR_UPGRADE_DEVICE {xcvc1902} \
   CONFIG.C_FOR_UPGRADE_PART {xcvc1902-vsva2197-1LP-e-S-es1} \
   CONFIG.C_FOR_UPGRADE_SPEEDGRADE {-1LP} \
   CONFIG.C_GT_DEBUG_PORT_EN {true} \
   CONFIG.C_GT_DIRECTION {SIMPLEX_TX} \
   CONFIG.C_INPUT_PIXELS_PER_CLOCK {4} \
   CONFIG.C_NIDRU {false} \
   CONFIG.C_NIDRU_REFCLK_SEL {2} \
   CONFIG.C_RX_PLL_SELECTION {8} \
   CONFIG.C_RX_REFCLK_SEL {0} \
   CONFIG.C_Rx_Protocol {None} \
   CONFIG.C_SPEEDGRADE {-1LP} \
   CONFIG.C_TX_PLL_SELECTION {7} \
   CONFIG.C_TX_REFCLK_SEL {1} \
   CONFIG.C_Tx_No_Of_Channels {4} \
   CONFIG.C_Tx_Protocol {HDMI} \
   CONFIG.C_Txrefclk_Rdy_Invert {true} \
   CONFIG.C_Use_GT_CH4_HDMI {true} \
   CONFIG.C_Use_Oddr_for_Tmds_Clkout {false} \
   CONFIG.C_vid_phy_rx_axi4s_ch_INT_TDATA_WIDTH {40} \
   CONFIG.C_vid_phy_rx_axi4s_ch_TDATA_WIDTH {40} \
   CONFIG.C_vid_phy_tx_axi4s_ch_INT_TDATA_WIDTH {40} \
   CONFIG.C_vid_phy_tx_axi4s_ch_TDATA_WIDTH {40} \
   CONFIG.Transceiver_Width {4} \
   CONFIG.check_refclk_selection {0} \
 ] $hdmi_gt_controller_1

  # Create instance: tx_video_axis_reg_slice, and set properties
  set tx_video_axis_reg_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice tx_video_axis_reg_slice ]

  # Create instance: v_hdmi_tx_ss_0, and set properties
  set v_hdmi_tx_ss_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_hdmi_tx_ss v_hdmi_tx_ss_0 ]
  set_property -dict [ list \
   CONFIG.C_INCLUDE_LOW_RESO_VID {true} \
   CONFIG.C_INCLUDE_YUV420_SUP {true} \
   CONFIG.C_INPUT_PIXELS_PER_CLOCK {4} \
   CONFIG.C_MAX_BITS_PER_COMPONENT {8} \
 ] $v_hdmi_tx_ss_0

  # Create instance: vcc_const, and set properties
  set vcc_const [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant vcc_const ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
 ] $vcc_const

  # Create interface connections
  connect_bd_intf_net -intf_net hdmi_gt_controller_1_ch0_debug [get_bd_intf_pins GT_Quad_and_Clk/CH0_DEBUG] [get_bd_intf_pins hdmi_gt_controller_1/ch0_debug]
  connect_bd_intf_net -intf_net hdmi_gt_controller_1_ch1_debug [get_bd_intf_pins GT_Quad_and_Clk/CH1_DEBUG] [get_bd_intf_pins hdmi_gt_controller_1/ch1_debug]
  connect_bd_intf_net -intf_net hdmi_gt_controller_1_ch2_debug [get_bd_intf_pins GT_Quad_and_Clk/CH2_DEBUG] [get_bd_intf_pins hdmi_gt_controller_1/ch2_debug]
  connect_bd_intf_net -intf_net hdmi_gt_controller_1_ch3_debug [get_bd_intf_pins GT_Quad_and_Clk/CH3_DEBUG] [get_bd_intf_pins hdmi_gt_controller_1/ch3_debug]
  connect_bd_intf_net -intf_net hdmi_gt_controller_1_gt_debug [get_bd_intf_pins GT_Quad_and_Clk/GT_DEBUG] [get_bd_intf_pins hdmi_gt_controller_1/gt_debug]
  connect_bd_intf_net -intf_net hdmi_gt_controller_1_gt_tx0 [get_bd_intf_pins GT_Quad_and_Clk/TX0_GT_IP_Interface] [get_bd_intf_pins hdmi_gt_controller_1/gt_tx0]
  connect_bd_intf_net -intf_net hdmi_gt_controller_1_gt_tx1 [get_bd_intf_pins GT_Quad_and_Clk/TX1_GT_IP_Interface] [get_bd_intf_pins hdmi_gt_controller_1/gt_tx1]
  connect_bd_intf_net -intf_net hdmi_gt_controller_1_gt_tx2 [get_bd_intf_pins GT_Quad_and_Clk/TX2_GT_IP_Interface] [get_bd_intf_pins hdmi_gt_controller_1/gt_tx2]
  connect_bd_intf_net -intf_net hdmi_gt_controller_1_gt_tx3 [get_bd_intf_pins GT_Quad_and_Clk/TX3_GT_IP_Interface] [get_bd_intf_pins hdmi_gt_controller_1/gt_tx3]
  connect_bd_intf_net -intf_net hdmi_gt_controller_1_status_sb_tx [get_bd_intf_pins hdmi_gt_controller_1/status_sb_tx] [get_bd_intf_pins v_hdmi_tx_ss_0/SB_STATUS_IN]
  connect_bd_intf_net -intf_net hdmi_tx_pipe_HDMI_CTL_IIC [get_bd_intf_pins HDMI_CTL_IIC] [get_bd_intf_pins fmch_axi_iic/IIC]
  connect_bd_intf_net -intf_net s_axis_video_1 [get_bd_intf_pins s_axis_video] [get_bd_intf_pins tx_video_axis_reg_slice/S_AXIS]
  connect_bd_intf_net -intf_net smartconnect_100mhz_M00_AXI [get_bd_intf_pins axi4lite] [get_bd_intf_pins hdmi_gt_controller_1/axi4lite]
  connect_bd_intf_net -intf_net smartconnect_100mhz_M02_AXI [get_bd_intf_pins S_AXI_CPU_IN] [get_bd_intf_pins v_hdmi_tx_ss_0/S_AXI_CPU_IN]
  connect_bd_intf_net -intf_net smartconnect_100mhz_M04_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins fmch_axi_iic/S_AXI]
  connect_bd_intf_net -intf_net tx_video_axis_reg_slice_M_AXIS [get_bd_intf_pins tx_video_axis_reg_slice/M_AXIS] [get_bd_intf_pins v_hdmi_tx_ss_0/VIDEO_IN]
  connect_bd_intf_net -intf_net v_hdmi_tx_ss_0_DDC_OUT [get_bd_intf_pins TX_DDC_OUT] [get_bd_intf_pins v_hdmi_tx_ss_0/DDC_OUT]
  connect_bd_intf_net -intf_net v_hdmi_tx_ss_0_LINK_DATA0_OUT [get_bd_intf_pins hdmi_gt_controller_1/tx_axi4s_ch0] [get_bd_intf_pins v_hdmi_tx_ss_0/LINK_DATA0_OUT]
  connect_bd_intf_net -intf_net v_hdmi_tx_ss_0_LINK_DATA1_OUT [get_bd_intf_pins hdmi_gt_controller_1/tx_axi4s_ch1] [get_bd_intf_pins v_hdmi_tx_ss_0/LINK_DATA1_OUT]
  connect_bd_intf_net -intf_net v_hdmi_tx_ss_0_LINK_DATA2_OUT [get_bd_intf_pins hdmi_gt_controller_1/tx_axi4s_ch2] [get_bd_intf_pins v_hdmi_tx_ss_0/LINK_DATA2_OUT]

  # Create port connections
  connect_bd_net -net GT_Quad_and_Clk_ch0_iloresetdone [get_bd_pins GT_Quad_and_Clk/ch0_iloresetdone] [get_bd_pins hdmi_gt_controller_1/gt_ch0_ilo_resetdone]
  connect_bd_net -net GT_Quad_and_Clk_ch1_iloresetdone [get_bd_pins GT_Quad_and_Clk/ch1_iloresetdone] [get_bd_pins hdmi_gt_controller_1/gt_ch1_ilo_resetdone]
  connect_bd_net -net GT_Quad_and_Clk_ch2_iloresetdone [get_bd_pins GT_Quad_and_Clk/ch2_iloresetdone] [get_bd_pins hdmi_gt_controller_1/gt_ch2_ilo_resetdone]
  connect_bd_net -net GT_Quad_and_Clk_ch3_iloresetdone [get_bd_pins GT_Quad_and_Clk/ch3_iloresetdone] [get_bd_pins hdmi_gt_controller_1/gt_ch3_ilo_resetdone]
  connect_bd_net -net GT_Quad_and_Clk_gtpowergood [get_bd_pins GT_Quad_and_Clk/gtpowergood] [get_bd_pins hdmi_gt_controller_1/gtpowergood]
  connect_bd_net -net GT_Quad_and_Clk_hsclk0_lcplllock [get_bd_pins GT_Quad_and_Clk/hsclk0_lcplllock] [get_bd_pins hdmi_gt_controller_1/gt_lcpll0_lock]
  connect_bd_net -net GT_Quad_and_Clk_hsclk1_lcplllock [get_bd_pins GT_Quad_and_Clk/hsclk1_lcplllock] [get_bd_pins hdmi_gt_controller_1/gt_lcpll1_lock]
  connect_bd_net -net GT_Quad_and_Clk_txn_0 [get_bd_pins TX_DATA_OUT_txn] [get_bd_pins GT_Quad_and_Clk/TX_DATA_OUT_txn]
  connect_bd_net -net GT_Quad_and_Clk_txp_0 [get_bd_pins TX_DATA_OUT_txp] [get_bd_pins GT_Quad_and_Clk/TX_DATA_OUT_txp]
  connect_bd_net -net RX_DATA_IN_rxn [get_bd_pins RX_DATA_IN_rxn] [get_bd_pins GT_Quad_and_Clk/RX_DATA_IN_rxn]
  connect_bd_net -net RX_DATA_IN_rxp [get_bd_pins RX_DATA_IN_rxp] [get_bd_pins GT_Quad_and_Clk/RX_DATA_IN_rxp]
  connect_bd_net -net TX_REFCLK_N_IN_1 [get_bd_pins TX_REFCLK_N_IN] [get_bd_pins gt_refclk1/CLK_N_IN]
  connect_bd_net -net TX_REFCLK_P_IN_1 [get_bd_pins TX_REFCLK_P_IN] [get_bd_pins gt_refclk1/CLK_P_IN]
  connect_bd_net -net bufg_gt_1_usrclk [get_bd_pins GT_Quad_and_Clk/tx_usrclk] [get_bd_pins hdmi_gt_controller_1/gt_txusrclk] [get_bd_pins hdmi_gt_controller_1/tx_axi4s_aclk] [get_bd_pins v_hdmi_tx_ss_0/link_clk]
  connect_bd_net -net fmch_axi_iic_iic2intc_irpt [get_bd_pins iic2intc_irpt] [get_bd_pins fmch_axi_iic/iic2intc_irpt]
  connect_bd_net -net gt_refclk1_O [get_bd_pins GT_Quad_and_Clk/GT_REFCLK1] [get_bd_pins gt_refclk1/O]
  connect_bd_net -net gt_refclk1_ODIV2 [get_bd_pins gt_refclk1/ODIV2] [get_bd_pins hdmi_gt_controller_1/gt_refclk1_odiv2]
  connect_bd_net -net hdmi_gt_controller_1_gt_lcpll0_reset [get_bd_pins GT_Quad_and_Clk/hsclk0_lcpllreset] [get_bd_pins hdmi_gt_controller_1/gt_lcpll0_reset]
  connect_bd_net -net hdmi_gt_controller_1_gt_lcpll1_reset [get_bd_pins GT_Quad_and_Clk/hsclk1_lcpllreset] [get_bd_pins hdmi_gt_controller_1/gt_lcpll1_reset]
  connect_bd_net -net hdmi_gt_controller_1_irq [get_bd_pins irq] [get_bd_pins hdmi_gt_controller_1/irq]
  connect_bd_net -net hdmi_gt_controller_1_tx_video_clk [get_bd_pins hdmi_gt_controller_1/tx_video_clk] [get_bd_pins v_hdmi_tx_ss_0/video_clk]
  connect_bd_net -net hdmi_tx_pipe_hdmi_tx_irq [get_bd_pins irq1] [get_bd_pins v_hdmi_tx_ss_0/irq]
  connect_bd_net -net net_bdry_in_SI5324_LOL_IN [get_bd_pins IDT_8T49N241_LOL_IN] [get_bd_pins hdmi_gt_controller_1/tx_refclk_rdy]
  connect_bd_net -net net_bdry_in_TX_HPD_IN [get_bd_pins TX_HPD_IN] [get_bd_pins v_hdmi_tx_ss_0/hpd]
  connect_bd_net -net net_mb_ss_0_clk_out2 [get_bd_pins aclk] [get_bd_pins tx_video_axis_reg_slice/aclk] [get_bd_pins v_hdmi_tx_ss_0/s_axis_audio_aclk] [get_bd_pins v_hdmi_tx_ss_0/s_axis_video_aclk]
  connect_bd_net -net net_mb_ss_0_dcm_locked [get_bd_pins aresetn1] [get_bd_pins tx_video_axis_reg_slice/aresetn] [get_bd_pins v_hdmi_tx_ss_0/s_axis_audio_aresetn] [get_bd_pins v_hdmi_tx_ss_0/s_axis_video_aresetn]
  connect_bd_net -net net_mb_ss_0_peripheral_aresetn [get_bd_pins ARESETN] [get_bd_pins fmch_axi_iic/s_axi_aresetn] [get_bd_pins hdmi_gt_controller_1/axi4lite_aresetn] [get_bd_pins hdmi_gt_controller_1/sb_aresetn] [get_bd_pins v_hdmi_tx_ss_0/s_axi_cpu_aresetn]
  connect_bd_net -net net_mb_ss_0_s_axi_aclk [get_bd_pins altclk] [get_bd_pins GT_Quad_and_Clk/altclk] [get_bd_pins fmch_axi_iic/s_axi_aclk] [get_bd_pins hdmi_gt_controller_1/apb_clk] [get_bd_pins hdmi_gt_controller_1/axi4lite_aclk] [get_bd_pins hdmi_gt_controller_1/sb_aclk] [get_bd_pins v_hdmi_tx_ss_0/s_axi_cpu_aclk]
  connect_bd_net -net net_vcc_const_dout [get_bd_pins TX_EN_OUT] [get_bd_pins hdmi_gt_controller_1/tx_axi4s_aresetn] [get_bd_pins vcc_const/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: mipi_capture_pipe
proc create_hier_cell_mipi_capture_pipe { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_mipi_capture_pipe() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 csi_mipi_phy_if

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 csirxss_s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_CTRL

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_CTRL1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_ctrl_1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 sensor_iic


  # Create pins
  create_bd_pin -dir I -from 31 -to 0 Din
  create_bd_pin -dir O -type intr csirxss_csi_irq
  create_bd_pin -dir O -type intr iic2intc_irpt
  create_bd_pin -dir O -type intr interrupt
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir O -from 0 -to 0 sensor_gpio_rst
  create_bd_pin -dir O -from 0 -to 0 sensor_gpio_spi_cs_n
  create_bd_pin -dir I -type clk video_clk
  create_bd_pin -dir I -type rst video_rst_n

  # Create instance: cap_pipe
  create_hier_cell_cap_pipe $hier_obj cap_pipe

  # Create instance: mipi_csi_rx_ss
  create_hier_cell_mipi_csi_rx_ss $hier_obj mipi_csi_rx_ss

  # Create interface connections
  connect_bd_intf_net -intf_net cap_pipe_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins cap_pipe/M00_AXI]
  connect_bd_intf_net -intf_net csi_mipi_phy_if_1 [get_bd_intf_pins csi_mipi_phy_if] [get_bd_intf_pins mipi_csi_rx_ss/mipi_phy_csi]
  connect_bd_intf_net -intf_net csirxss_s_axi_1 [get_bd_intf_pins csirxss_s_axi] [get_bd_intf_pins mipi_csi_rx_ss/csirxss_s_axi]
  connect_bd_intf_net -intf_net mipi_csi_rx_ss_IIC_sensor [get_bd_intf_pins sensor_iic] [get_bd_intf_pins mipi_csi_rx_ss/IIC_sensor]
  connect_bd_intf_net -intf_net mipi_csi_rx_ss_video_out [get_bd_intf_pins cap_pipe/S_AXIS] [get_bd_intf_pins mipi_csi_rx_ss/video_out]
  connect_bd_intf_net -intf_net s_axi_CTRL1_1 [get_bd_intf_pins s_axi_CTRL1] [get_bd_intf_pins cap_pipe/s_axi_CTRL1]
  connect_bd_intf_net -intf_net s_axi_CTRL_1 [get_bd_intf_pins s_axi_CTRL] [get_bd_intf_pins cap_pipe/s_axi_CTRL]
  connect_bd_intf_net -intf_net s_axi_ctrl_1_1 [get_bd_intf_pins s_axi_ctrl_1] [get_bd_intf_pins cap_pipe/s_axi_ctrl_1]
  connect_bd_intf_net -intf_net smartconnect_gp0_M04_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins mipi_csi_rx_ss/S_AXI]

  # Create port connections
  connect_bd_net -net Din_1 [get_bd_pins Din] [get_bd_pins cap_pipe/Din]
  connect_bd_net -net cap_pipe_Dout [get_bd_pins sensor_gpio_rst] [get_bd_pins cap_pipe/Dout]
  connect_bd_net -net cap_pipe_interrupt [get_bd_pins interrupt] [get_bd_pins cap_pipe/interrupt]
  connect_bd_net -net clk_wiz_clk_out2 [get_bd_pins s_axi_aclk] [get_bd_pins mipi_csi_rx_ss/s_axi_aclk]
  connect_bd_net -net clk_wiz_clk_out3 [get_bd_pins video_clk] [get_bd_pins cap_pipe/video_clk] [get_bd_pins mipi_csi_rx_ss/dphy_clk_200M] [get_bd_pins mipi_csi_rx_ss/video_aclk]
  connect_bd_net -net mipi_csi2_rx_dout1 [get_bd_pins sensor_gpio_spi_cs_n] [get_bd_pins cap_pipe/dout_1]
  connect_bd_net -net mipi_csi_rx_ss_csirxss_csi_irq [get_bd_pins csirxss_csi_irq] [get_bd_pins mipi_csi_rx_ss/csirxss_csi_irq]
  connect_bd_net -net mipi_csi_rx_ss_iic2intc_irpt [get_bd_pins iic2intc_irpt] [get_bd_pins mipi_csi_rx_ss/iic2intc_irpt]
  connect_bd_net -net rst_processor_1_100M_peripheral_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins mipi_csi_rx_ss/s_axi_aresetn]
  connect_bd_net -net rst_processor_pl_200Mhz_peripheral_aresetn [get_bd_pins video_rst_n] [get_bd_pins cap_pipe/video_rst_n] [get_bd_pins mipi_csi_rx_ss/video_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: display_pipe
proc create_hier_cell_display_pipe { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_display_pipe() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 HDMI_CTL_IIC

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CPU_IN

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 TX_DDC_OUT

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 axi4lite

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_ctrl_vmix

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 vmix_mm_axi_vid_rd_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 vmix_mm_axi_vid_rd_1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 vmix_mm_axi_vid_rd_2


  # Create pins
  create_bd_pin -dir I -type rst ARESETN
  create_bd_pin -dir I -from 31 -to 0 Din
  create_bd_pin -dir I IDT_8T49N241_LOL_IN
  create_bd_pin -dir I -from 3 -to 0 RX_DATA_IN_rxn
  create_bd_pin -dir I -from 3 -to 0 RX_DATA_IN_rxp
  create_bd_pin -dir O -from 3 -to 0 TX_DATA_OUT_txn
  create_bd_pin -dir O -from 3 -to 0 TX_DATA_OUT_txp
  create_bd_pin -dir O -from 0 -to 0 -type rst TX_EN_OUT
  create_bd_pin -dir I TX_HPD_IN
  create_bd_pin -dir I -from 0 -to 0 -type clk TX_REFCLK_N_IN
  create_bd_pin -dir I -from 0 -to 0 -type clk TX_REFCLK_P_IN
  create_bd_pin -dir I altclk
  create_bd_pin -dir I -type rst aresetn1
  create_bd_pin -dir O -type intr iic2intc_irpt
  create_bd_pin -dir O -type intr irq
  create_bd_pin -dir O -type intr irq1
  create_bd_pin -dir I -type clk s_axis_aclk
  create_bd_pin -dir I -type rst sc_aresetn
  create_bd_pin -dir O -type intr vmix_intr

  # Create instance: hdmi_tx_pipe
  create_hier_cell_hdmi_tx_pipe $hier_obj hdmi_tx_pipe

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.ADVANCED_PROPERTIES {__view__ { functional { S07_Buffer { R_SIZE 1024 } S00_Buffer { R_SIZE 1024 }\
S06_Buffer { R_SIZE 1024 } S05_Buffer { R_SIZE 1024 } S01_Buffer { R_SIZE 1024\
} S02_Buffer { R_SIZE 1024 } M00_Buffer { R_SIZE 1024 } S03_Buffer { R_SIZE\
1024 } S04_Buffer { R_SIZE 1024 } } }}\
   CONFIG.NUM_SI {4} \
 ] $smartconnect_0

  # Create instance: smartconnect_1, and set properties
  set smartconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_1 ]
  set_property -dict [ list \
   CONFIG.ADVANCED_PROPERTIES {__view__ { functional { S07_Buffer { R_SIZE 1024 } S00_Buffer { R_SIZE 1024 }\
S06_Buffer { R_SIZE 1024 } S05_Buffer { R_SIZE 1024 } S01_Buffer { R_SIZE 1024\
} S02_Buffer { R_SIZE 1024 } M00_Buffer { R_SIZE 1024 } S03_Buffer { R_SIZE\
1024 } S04_Buffer { R_SIZE 1024 } } }}\
   CONFIG.NUM_SI {4} \
 ] $smartconnect_1

  # Create instance: v_mix_0, and set properties
  set v_mix_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_mix v_mix_0 ]
  set_property -dict [ list \
   CONFIG.AXIMM_BURST_LENGTH {256} \
   CONFIG.AXIMM_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO10_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO11_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO12_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO13_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO14_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO15_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO16_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO1_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO2_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO3_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO4_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO5_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO6_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO7_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO8_DATA_WIDTH {256} \
   CONFIG.C_M_AXI_MM_VIDEO9_DATA_WIDTH {256} \
   CONFIG.LAYER10_ALPHA {true} \
   CONFIG.LAYER10_VIDEO_FORMAT {10} \
   CONFIG.LAYER11_ALPHA {true} \
   CONFIG.LAYER11_VIDEO_FORMAT {10} \
   CONFIG.LAYER12_ALPHA {true} \
   CONFIG.LAYER12_VIDEO_FORMAT {10} \
   CONFIG.LAYER13_ALPHA {true} \
   CONFIG.LAYER13_VIDEO_FORMAT {26} \
   CONFIG.LAYER1_ALPHA {true} \
   CONFIG.LAYER1_VIDEO_FORMAT {20} \
   CONFIG.LAYER2_ALPHA {true} \
   CONFIG.LAYER2_VIDEO_FORMAT {20} \
   CONFIG.LAYER3_ALPHA {true} \
   CONFIG.LAYER3_VIDEO_FORMAT {20} \
   CONFIG.LAYER4_ALPHA {true} \
   CONFIG.LAYER4_VIDEO_FORMAT {20} \
   CONFIG.LAYER5_ALPHA {true} \
   CONFIG.LAYER5_VIDEO_FORMAT {12} \
   CONFIG.LAYER6_ALPHA {true} \
   CONFIG.LAYER6_VIDEO_FORMAT {12} \
   CONFIG.LAYER7_ALPHA {true} \
   CONFIG.LAYER7_VIDEO_FORMAT {12} \
   CONFIG.LAYER8_ALPHA {true} \
   CONFIG.LAYER8_VIDEO_FORMAT {12} \
   CONFIG.LAYER9_ALPHA {true} \
   CONFIG.LAYER9_VIDEO_FORMAT {26} \
   CONFIG.MAX_DATA_WIDTH {8} \
   CONFIG.NR_LAYERS {10} \
   CONFIG.SAMPLES_PER_CLOCK {4} \
 ] $v_mix_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {96} \
 ] $xlconstant_0

  # Create instance: xlslice_20, and set properties
  set xlslice_20 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_20 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_20

  # Create interface connections
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins TX_DDC_OUT] [get_bd_intf_pins hdmi_tx_pipe/TX_DDC_OUT]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins HDMI_CTL_IIC] [get_bd_intf_pins hdmi_tx_pipe/HDMI_CTL_IIC]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins S_AXI] [get_bd_intf_pins hdmi_tx_pipe/S_AXI]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins S_AXI_CPU_IN] [get_bd_intf_pins hdmi_tx_pipe/S_AXI_CPU_IN]
  connect_bd_intf_net -intf_net Conn8 [get_bd_intf_pins axi4lite] [get_bd_intf_pins hdmi_tx_pipe/axi4lite]
  connect_bd_intf_net -intf_net s_axi_lite_vmix_1 [get_bd_intf_pins s_axi_ctrl_vmix] [get_bd_intf_pins v_mix_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins vmix_mm_axi_vid_rd_0] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_1_M00_AXI [get_bd_intf_pins vmix_mm_axi_vid_rd_1] [get_bd_intf_pins smartconnect_1/M00_AXI]
  connect_bd_intf_net -intf_net v_mix_0_m_axi_mm_video1 [get_bd_intf_pins smartconnect_0/S00_AXI] [get_bd_intf_pins v_mix_0/m_axi_mm_video1]
  connect_bd_intf_net -intf_net v_mix_0_m_axi_mm_video2 [get_bd_intf_pins smartconnect_0/S01_AXI] [get_bd_intf_pins v_mix_0/m_axi_mm_video2]
  connect_bd_intf_net -intf_net v_mix_0_m_axi_mm_video3 [get_bd_intf_pins smartconnect_1/S00_AXI] [get_bd_intf_pins v_mix_0/m_axi_mm_video3]
  connect_bd_intf_net -intf_net v_mix_0_m_axi_mm_video4 [get_bd_intf_pins smartconnect_1/S01_AXI] [get_bd_intf_pins v_mix_0/m_axi_mm_video4]
  connect_bd_intf_net -intf_net v_mix_0_m_axi_mm_video5 [get_bd_intf_pins smartconnect_0/S02_AXI] [get_bd_intf_pins v_mix_0/m_axi_mm_video5]
  connect_bd_intf_net -intf_net v_mix_0_m_axi_mm_video6 [get_bd_intf_pins smartconnect_0/S03_AXI] [get_bd_intf_pins v_mix_0/m_axi_mm_video6]
  connect_bd_intf_net -intf_net v_mix_0_m_axi_mm_video7 [get_bd_intf_pins smartconnect_1/S02_AXI] [get_bd_intf_pins v_mix_0/m_axi_mm_video7]
  connect_bd_intf_net -intf_net v_mix_0_m_axi_mm_video8 [get_bd_intf_pins smartconnect_1/S03_AXI] [get_bd_intf_pins v_mix_0/m_axi_mm_video8]
  connect_bd_intf_net -intf_net v_mix_0_m_axi_mm_video9 [get_bd_intf_pins vmix_mm_axi_vid_rd_2] [get_bd_intf_pins v_mix_0/m_axi_mm_video9]
  connect_bd_intf_net -intf_net v_mix_0_m_axis_video [get_bd_intf_pins hdmi_tx_pipe/s_axis_video] [get_bd_intf_pins v_mix_0/m_axis_video]

  # Create port connections
  connect_bd_net -net ARESETN_2 [get_bd_pins ARESETN] [get_bd_pins hdmi_tx_pipe/ARESETN]
  connect_bd_net -net IDT_8T49N241_LOL_IN_1 [get_bd_pins IDT_8T49N241_LOL_IN] [get_bd_pins hdmi_tx_pipe/IDT_8T49N241_LOL_IN]
  connect_bd_net -net RX_DATA_IN_rxn_1 [get_bd_pins RX_DATA_IN_rxn] [get_bd_pins hdmi_tx_pipe/RX_DATA_IN_rxn]
  connect_bd_net -net RX_DATA_IN_rxp_1 [get_bd_pins RX_DATA_IN_rxp] [get_bd_pins hdmi_tx_pipe/RX_DATA_IN_rxp]
  connect_bd_net -net TX_HPD_IN_1 [get_bd_pins TX_HPD_IN] [get_bd_pins hdmi_tx_pipe/TX_HPD_IN]
  connect_bd_net -net TX_REFCLK_N_IN_1 [get_bd_pins TX_REFCLK_N_IN] [get_bd_pins hdmi_tx_pipe/TX_REFCLK_N_IN]
  connect_bd_net -net TX_REFCLK_P_IN_1 [get_bd_pins TX_REFCLK_P_IN] [get_bd_pins hdmi_tx_pipe/TX_REFCLK_P_IN]
  connect_bd_net -net altclk_1 [get_bd_pins altclk] [get_bd_pins hdmi_tx_pipe/altclk]
  connect_bd_net -net aresetn1_1 [get_bd_pins aresetn1] [get_bd_pins hdmi_tx_pipe/aresetn1]
  connect_bd_net -net aresetn_1 [get_bd_pins sc_aresetn] [get_bd_pins smartconnect_0/aresetn] [get_bd_pins smartconnect_1/aresetn]
  connect_bd_net -net clk_wizard_0_clk_out3 [get_bd_pins s_axis_aclk] [get_bd_pins hdmi_tx_pipe/aclk] [get_bd_pins smartconnect_0/aclk] [get_bd_pins smartconnect_1/aclk] [get_bd_pins v_mix_0/ap_clk]
  connect_bd_net -net hdmi_tx_pipe_TX_EN_OUT [get_bd_pins TX_EN_OUT] [get_bd_pins hdmi_tx_pipe/TX_EN_OUT]
  connect_bd_net -net hdmi_tx_pipe_iic2intc_irpt [get_bd_pins iic2intc_irpt] [get_bd_pins hdmi_tx_pipe/iic2intc_irpt]
  connect_bd_net -net hdmi_tx_pipe_irq [get_bd_pins irq] [get_bd_pins hdmi_tx_pipe/irq]
  connect_bd_net -net hdmi_tx_pipe_irq1 [get_bd_pins irq1] [get_bd_pins hdmi_tx_pipe/irq1]
  connect_bd_net -net hdmi_tx_pipe_txn_0 [get_bd_pins TX_DATA_OUT_txn] [get_bd_pins hdmi_tx_pipe/TX_DATA_OUT_txn]
  connect_bd_net -net hdmi_tx_pipe_txp_0 [get_bd_pins TX_DATA_OUT_txp] [get_bd_pins hdmi_tx_pipe/TX_DATA_OUT_txp]
  connect_bd_net -net ps_gpio_1 [get_bd_pins Din] [get_bd_pins xlslice_20/Din]
  connect_bd_net -net v_mix_0_interrupt [get_bd_pins vmix_intr] [get_bd_pins v_mix_0/interrupt]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins v_mix_0/s_axis_video_TDATA] [get_bd_pins v_mix_0/s_axis_video_TVALID] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlslice_20_Dout [get_bd_pins v_mix_0/ap_rst_n] [get_bd_pins xlslice_20/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set CH0_LPDDR4_0_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:lpddr4_rtl:1.0 CH0_LPDDR4_0_0 ]

  set CH1_LPDDR4_0_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:lpddr4_rtl:1.0 CH1_LPDDR4_0_0 ]

  set HDMI_CTL_IIC [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 HDMI_CTL_IIC ]

  set TX_DDC_OUT [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 TX_DDC_OUT ]

  set csi_mipi_phy_if [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 csi_mipi_phy_if ]

  set sensor_iic [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 sensor_iic ]

  set sys_clk0_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys_clk0_0 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {200000000} \
   ] $sys_clk0_0


  # Create ports
  set IDT_8T49N241_LOL_IN [ create_bd_port -dir I IDT_8T49N241_LOL_IN ]
  set RX_DATA_IN_rxn [ create_bd_port -dir I -from 3 -to 0 RX_DATA_IN_rxn ]
  set RX_DATA_IN_rxp [ create_bd_port -dir I -from 3 -to 0 RX_DATA_IN_rxp ]
  set TX_DATA_OUT_txn [ create_bd_port -dir O -from 3 -to 0 TX_DATA_OUT_txn ]
  set TX_DATA_OUT_txp [ create_bd_port -dir O -from 3 -to 0 TX_DATA_OUT_txp ]
  set TX_EN_OUT [ create_bd_port -dir O -from 0 -to 0 TX_EN_OUT ]
  set TX_HPD_IN [ create_bd_port -dir I TX_HPD_IN ]
  set TX_REFCLK_N_IN [ create_bd_port -dir I TX_REFCLK_N_IN ]
  set TX_REFCLK_P_IN [ create_bd_port -dir I TX_REFCLK_P_IN ]
  set sensor_gpio_flash [ create_bd_port -dir O -from 0 -to 0 sensor_gpio_flash ]
  set sensor_gpio_rst [ create_bd_port -dir O -from 0 -to 0 sensor_gpio_rst ]
  set sensor_gpio_spi_cs_n [ create_bd_port -dir O -from 0 -to 0 sensor_gpio_spi_cs_n ]

  # Create instance: CIPS_0, and set properties
  set CIPS_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:versal_cips CIPS_0 ]
  set_property -dict [ list \
   CONFIG.CPM_CONFIG {PS_HSDP_MODE NONE GT_REFCLK_MHZ 156.25 PS_HSDP0_REFCLK 0 PS_HSDP1_REFCLK 0\
AURORA_LINE_RATE_GPBS 10.0 PS_HSDP_INGRESS_TRAFFIC JTAG PS_HSDP_EGRESS_TRAFFIC\
JTAG PS_USE_NOC_PS_PCI_0 0 PS_USE_PS_NOC_PCI_0 0 PS_USE_PS_NOC_PCI_1 0\
CPM_CLRERR_LANE_MARGIN 0 CPM_DMA_CREDIT_INIT_DEMUX 1 BOOT_SECONDARY_PCIE_ENABLE\
0 CPM_CDO_EN 0 CPM_USE_MODES None CPM_DESIGN_USE_MODE 0 CPM_PERIPHERAL_EN 0\
CPM_PERIPHERAL_TEST_EN 0 CPM_REQ_AGENTS_0_ENABLE 0 CPM_REQ_AGENTS_1_ENABLE 0\
CPM_REQ_AGENTS_0_L2_ENABLE 0 CPM_NUM_HNF_AGENTS 0 CPM_NUM_REQ_AGENTS 0\
CPM_NUM_SLAVE_AGENTS 0 CPM_NUM_HOME_OR_SLAVE_AGENTS 0 CPM_QUAD0_ADDN_PORTS 0\
CPM_QUAD1_ADDN_PORTS 0 CPM_QUAD2_ADDN_PORTS 0 CPM_QUAD3_ADDN_PORTS 0\
CPM_SELECT_GTOUTCLK TXOUTCLK CPM_DMA_IS_MM_ONLY 0 CPM_CCIX_IS_MM_ONLY 0\
CPM_TYPE1_MEMBASE_MEMLIMIT_ENABLE Disabled\
CPM_TYPE1_PREFETCHABLE_MEMBASE_MEMLIMIT Disabled CPM_A0_REFCLK 0 CPM_A1_REFCLK\
0 CPM_CPLL_CTRL_FBDIV 86 CPM_CPLL_CTRL_SRCSEL REF_CLK\
CPM_CORE_REF_CTRL_ACT_FREQMHZ 716.659485 CPM_AUX0_REF_CTRL_ACT_FREQMHZ\
716.659485 CPM_AUX1_REF_CTRL_ACT_FREQMHZ 716.659485\
CPM_DBG_REF_CTRL_ACT_FREQMHZ 358.329742 CPM_LSBUS_REF_CTRL_ACT_FREQMHZ\
143.331894 CPM_CORE_REF_CTRL_FREQMHZ 717 CPM_AUX0_REF_CTRL_FREQMHZ 717\
CPM_AUX1_REF_CTRL_FREQMHZ 717 CPM_DBG_REF_CTRL_FREQMHZ 359\
CPM_LSBUS_REF_CTRL_FREQMHZ 150 CPM_CORE_REF_CTRL_DIVISOR0 2\
CPM_AUX0_REF_CTRL_DIVISOR0 2 CPM_AUX1_REF_CTRL_DIVISOR0 2\
CPM_DBG_REF_CTRL_DIVISOR0 4 CPM_LSBUS_REF_CTRL_DIVISOR0 10\
CPM_AXI_SLV_XDMA_BASE_ADDRR_L 0x11000000 CPM_AXI_SLV_MULTQ_BASE_ADDRR_L\
0x10000000 CPM_AXI_SLV_BRIDGE_BASE_ADDRR_L 0x00000000\
CPM_AXI_SLV_XDMA_BASE_ADDRR_H 0x00000006 CPM_AXI_SLV_MULTQ_BASE_ADDRR_H\
0x00000006 CPM_AXI_SLV_BRIDGE_BASE_ADDRR_H 0x00000000 CPM_NUM_CCIX_CREDIT_LINKS\
0 CPM_CCIX_SELECT_AGENT None CPM_CCIX_PORT_AGGREGATION_ENABLE 0\
CPM_CCIX_PARTIAL_CACHELINE_SUPPORT 0 CPM_PCIE0_CCIX_EN 0 CPM_PCIE1_CCIX_EN 0\
CPM_PCIE0_CCIX_VENDOR_ID 0 CPM_PCIE1_CCIX_VENDOR_ID 0\
CPM_PCIE0_CCIX_OPT_TLP_GEN_AND_RECEPT_EN_CONTROL_INTERNAL 0\
CPM_PCIE1_CCIX_OPT_TLP_GEN_AND_RECEPT_EN_CONTROL_INTERNAL 0\
CPM_CCIX_RSVRD_MEMORY_BASEADDRESS_0 0x00000000 CPM_CCIX_RSVRD_MEMORY_REGION_0 0\
CPM_CCIX_RSVRD_MEMORY_SIZE_0 4GB CPM_CCIX_RSVRD_MEMORY_AGENT_TYPE_0 HA0\
CPM_CCIX_RSVRD_MEMORY_TYPE_0 Other_or_Non_Specified_Memory_Type\
CPM_CCIX_RSVRD_MEMORY_ATTRIB_0 Normal_Non_Cacheable_Memory\
CPM_CCIX_RSVRD_MEMORY_BASEADDRESS_1 0x00000000 CPM_CCIX_RSVRD_MEMORY_REGION_1 0\
CPM_CCIX_RSVRD_MEMORY_SIZE_1 4GB CPM_CCIX_RSVRD_MEMORY_AGENT_TYPE_1 HA0\
CPM_CCIX_RSVRD_MEMORY_TYPE_1 Other_or_Non_Specified_Memory_Type\
CPM_CCIX_RSVRD_MEMORY_ATTRIB_1 Normal_Non_Cacheable_Memory\
CPM_CCIX_RSVRD_MEMORY_BASEADDRESS_2 0x00000000 CPM_CCIX_RSVRD_MEMORY_REGION_2 0\
CPM_CCIX_RSVRD_MEMORY_SIZE_2 4GB CPM_CCIX_RSVRD_MEMORY_AGENT_TYPE_2 HA0\
CPM_CCIX_RSVRD_MEMORY_TYPE_2 Other_or_Non_Specified_Memory_Type\
CPM_CCIX_RSVRD_MEMORY_ATTRIB_2 Normal_Non_Cacheable_Memory\
CPM_CCIX_RSVRD_MEMORY_BASEADDRESS_3 0x00000000 CPM_CCIX_RSVRD_MEMORY_REGION_3 0\
CPM_CCIX_RSVRD_MEMORY_SIZE_3 4GB CPM_CCIX_RSVRD_MEMORY_AGENT_TYPE_3 HA0\
CPM_CCIX_RSVRD_MEMORY_TYPE_3 Other_or_Non_Specified_Memory_Type\
CPM_CCIX_RSVRD_MEMORY_ATTRIB_3 Normal_Non_Cacheable_Memory\
CPM_CCIX_RSVRD_MEMORY_BASEADDRESS_4 0x00000000 CPM_CCIX_RSVRD_MEMORY_REGION_4 0\
CPM_CCIX_RSVRD_MEMORY_SIZE_4 4GB CPM_CCIX_RSVRD_MEMORY_AGENT_TYPE_4 HA0\
CPM_CCIX_RSVRD_MEMORY_TYPE_4 Other_or_Non_Specified_Memory_Type\
CPM_CCIX_RSVRD_MEMORY_ATTRIB_4 Normal_Non_Cacheable_Memory\
CPM_CCIX_RSVRD_MEMORY_BASEADDRESS_5 0x00000000 CPM_CCIX_RSVRD_MEMORY_REGION_5 0\
CPM_CCIX_RSVRD_MEMORY_SIZE_5 4GB CPM_CCIX_RSVRD_MEMORY_AGENT_TYPE_5 HA0\
CPM_CCIX_RSVRD_MEMORY_TYPE_5 Other_or_Non_Specified_Memory_Type\
CPM_CCIX_RSVRD_MEMORY_ATTRIB_5 Normal_Non_Cacheable_Memory\
CPM_CCIX_RSVRD_MEMORY_BASEADDRESS_6 0x00000000 CPM_CCIX_RSVRD_MEMORY_REGION_6 0\
CPM_CCIX_RSVRD_MEMORY_SIZE_6 4GB CPM_CCIX_RSVRD_MEMORY_AGENT_TYPE_6 HA0\
CPM_CCIX_RSVRD_MEMORY_TYPE_6 Other_or_Non_Specified_Memory_Type\
CPM_CCIX_RSVRD_MEMORY_ATTRIB_6 Normal_Non_Cacheable_Memory\
CPM_CCIX_RSVRD_MEMORY_BASEADDRESS_7 0x00000000 CPM_CCIX_RSVRD_MEMORY_REGION_7 0\
CPM_CCIX_RSVRD_MEMORY_SIZE_7 4GB CPM_CCIX_RSVRD_MEMORY_AGENT_TYPE_7 HA0\
CPM_CCIX_RSVRD_MEMORY_TYPE_7 Other_or_Non_Specified_Memory_Type\
CPM_CCIX_RSVRD_MEMORY_ATTRIB_7 Normal_Non_Cacheable_Memory CPM_XPIPE_0_MODE 0\
CPM_XPIPE_1_MODE 0 CPM_XPIPE_2_MODE 0 CPM_XPIPE_3_MODE 0 CPM_XPIPE_0_RSVD 0\
CPM_XPIPE_1_RSVD 0 CPM_XPIPE_2_RSVD 0 CPM_XPIPE_3_RSVD 0 CPM_XPIPE_0_LOC QUAD0\
CPM_XPIPE_1_LOC QUAD1 CPM_XPIPE_2_LOC QUAD2 CPM_XPIPE_3_LOC QUAD3\
CPM_XPIPE_0_INSTANTIATED 0 CPM_XPIPE_1_INSTANTIATED 0 CPM_XPIPE_2_INSTANTIATED\
0 CPM_XPIPE_3_INSTANTIATED 0 CPM_XPIPE_0_CLK_CFG 0 CPM_XPIPE_1_CLK_CFG 0\
CPM_XPIPE_2_CLK_CFG 0 CPM_XPIPE_3_CLK_CFG 0 CPM_XPIPE_0_CLKDLY_CFG 0\
CPM_XPIPE_1_CLKDLY_CFG 0 CPM_XPIPE_2_CLKDLY_CFG 0 CPM_XPIPE_3_CLKDLY_CFG 0\
CPM_XPIPE_0_REG_CFG 0 CPM_XPIPE_1_REG_CFG 0 CPM_XPIPE_2_REG_CFG 0\
CPM_XPIPE_3_REG_CFG 0 CPM_XPIPE_0_LINK0_CFG DISABLE CPM_XPIPE_1_LINK0_CFG\
DISABLE CPM_XPIPE_2_LINK0_CFG DISABLE CPM_XPIPE_3_LINK0_CFG DISABLE\
CPM_XPIPE_0_LINK1_CFG DISABLE CPM_XPIPE_1_LINK1_CFG DISABLE\
CPM_XPIPE_2_LINK1_CFG DISABLE CPM_XPIPE_3_LINK1_CFG DISABLE\
CPM_PCIE0_CFG_SPEC_4_0 0 CPM_PCIE1_CFG_SPEC_4_0 0 CPM_PCIE0_CFG_VEND_ID 10EE\
CPM_PCIE1_CFG_VEND_ID 10EE CPM_PCIE0_LINK_DEBUG_EN 0 CPM_PCIE1_LINK_DEBUG_EN 0\
CPM_PCIE0_LINK_DEBUG_AXIST_EN 0 CPM_PCIE1_LINK_DEBUG_AXIST_EN 0\
CPM_PCIE0_PL_USER_SPARE 0 CPM_PCIE1_PL_USER_SPARE 0\
CPM_PCIE0_PL_UPSTREAM_FACING 1 CPM_PCIE1_PL_UPSTREAM_FACING 1\
CPM_PCIE0_ASYNC_MODE SRNS CPM_PCIE1_ASYNC_MODE SRNS CPM_PCIE0_AXIBAR_NUM 1\
CPM_PCIE1_AXIBAR_NUM 1 CPM_PCIE0_PORT_TYPE PCI_Express_Endpoint_device\
CPM_PCIE1_PORT_TYPE PCI_Express_Endpoint_device CPM_PCIE0_FUNCTIONAL_MODE None\
CPM_PCIE1_FUNCTIONAL_MODE None CPM_PCIE0_MODES None CPM_PCIE1_MODES None\
CPM_PCIE0_MODE_SELECTION Basic CPM_PCIE1_MODE_SELECTION Basic\
CPM_PCIE0_EXT_PCIE_CFG_SPACE_ENABLED None CPM_PCIE1_EXT_PCIE_CFG_SPACE_ENABLED\
None CPM_PCIE0_LEGACY_EXT_PCIE_CFG_SPACE_ENABLED 0\
CPM_PCIE1_LEGACY_EXT_PCIE_CFG_SPACE_ENABLED 0 CPM_PCIE0_TL_PF_ENABLE_REG 1\
CPM_PCIE1_TL_PF_ENABLE_REG 1 CPM_PCIE0_TL_USER_SPARE 0 CPM_PCIE1_TL_USER_SPARE\
0 CPM_PCIE0_EN_PARITY 0 CPM_PCIE1_EN_PARITY 0 CPM_PCIE0_EDR_LINK_SPEED None\
CPM_PCIE1_EDR_LINK_SPEED None CPM_PCIE0_CONTROLLER_ENABLE 0\
CPM_PCIE1_CONTROLLER_ENABLE 0 CPM_PCIE0_TL2CFG_IF_PARITY_CHK 0\
CPM_PCIE1_TL2CFG_IF_PARITY_CHK 0 CPM_PCIE0_TYPE1_MEMBASE_MEMLIMIT_ENABLE\
Disabled CPM_PCIE1_TYPE1_MEMBASE_MEMLIMIT_ENABLE Disabled\
CPM_PCIE0_TYPE1_PREFETCHABLE_MEMBASE_MEMLIMIT Disabled\
CPM_PCIE1_TYPE1_PREFETCHABLE_MEMBASE_MEMLIMIT Disabled\
CPM_PCIE0_TYPE1_MEMBASE_MEMLIMIT_BRIDGE_ENABLE Disabled\
CPM_PCIE0_TYPE1_PREFETCHABLE_MEMBASE_BRIDGE_MEMLIMIT Disabled\
CPM_PCIE0_USER_CLK2_FREQ 125_MHz CPM_PCIE1_USER_CLK2_FREQ 125_MHz\
CPM_PCIE0_USER_EDR_CLK2_FREQ 312.5_MHz CPM_PCIE1_USER_EDR_CLK2_FREQ 312.5_MHz\
CPM_PCIE0_CORE_CLK_FREQ 500 CPM_PCIE1_CORE_CLK_FREQ 500\
CPM_PCIE0_CORE_EDR_CLK_FREQ 625 CPM_PCIE1_CORE_EDR_CLK_FREQ 625\
CPM_PCIE0_REF_CLK_FREQ 100_MHz CPM_PCIE1_REF_CLK_FREQ 100_MHz\
CPM_PCIE0_USER_CLK_FREQ 125_MHz CPM_PCIE1_USER_CLK_FREQ 125_MHz\
CPM_PCIE0_USER_EDR_CLK_FREQ 312.5_MHz CPM_PCIE1_USER_EDR_CLK_FREQ 312.5_MHz\
CPM_PCIE_CHANNELS_FOR_POWER 0 CPM_PCIE0_MODE0_FOR_POWER NONE\
CPM_PCIE0_LINK_WIDTH0_FOR_POWER 0 CPM_PCIE0_LINK_SPEED0_FOR_POWER GEN1\
CPM_PCIE1_MODE1_FOR_POWER NONE CPM_PCIE1_LINK_WIDTH1_FOR_POWER 0\
CPM_PCIE1_LINK_SPEED1_FOR_POWER GEN1 CPM_PCIE0_PM_ASPML0S_TIMEOUT 0\
CPM_PCIE1_PM_ASPML0S_TIMEOUT 0 CPM_PCIE0_PF0_PM_CSR_NOSOFTRESET 1\
CPM_PCIE1_PF0_PM_CSR_NOSOFTRESET 1 CPM_PCIE0_PF0_PM_CAP_SUPP_D1_STATE 1\
CPM_PCIE1_PF0_PM_CAP_SUPP_D1_STATE 1 CPM_PCIE0_PF0_LINK_CAP_ASPM_SUPPORT\
No_ASPM CPM_PCIE1_PF0_LINK_CAP_ASPM_SUPPORT No_ASPM\
CPM_PCIE0_PM_ENABLE_L23_ENTRY 0 CPM_PCIE1_PM_ENABLE_L23_ENTRY 0\
CPM_PCIE0_PM_ENABLE_SLOT_POWER_CAPTURE 1 CPM_PCIE1_PM_ENABLE_SLOT_POWER_CAPTURE\
1 CPM_PCIE0_PF0_PM_CAP_PMESUPPORT_D0 1 CPM_PCIE1_PF0_PM_CAP_PMESUPPORT_D0 1\
CPM_PCIE0_PF0_PM_CAP_PMESUPPORT_D1 1 CPM_PCIE1_PF0_PM_CAP_PMESUPPORT_D1 1\
CPM_PCIE0_PF0_PM_CAP_PMESUPPORT_D3COLD 1 CPM_PCIE1_PF0_PM_CAP_PMESUPPORT_D3COLD\
1 CPM_PCIE0_PF0_PM_CAP_PMESUPPORT_D3HOT 1 CPM_PCIE1_PF0_PM_CAP_PMESUPPORT_D3HOT\
1 CPM_PCIE0_PM_L1_REENTRY_DELAY 0 CPM_PCIE1_PM_L1_REENTRY_DELAY 0\
CPM_PCIE0_PM_ASPML1_ENTRY_DELAY 0 CPM_PCIE1_PM_ASPML1_ENTRY_DELAY 0\
CPM_PCIE0_PM_PME_TURNOFF_ACK_DELAY 0 CPM_PCIE1_PM_PME_TURNOFF_ACK_DELAY 0\
CPM_PCIE0_PL_LINK_CAP_MAX_LINK_WIDTH NONE CPM_PCIE1_PL_LINK_CAP_MAX_LINK_WIDTH\
NONE CPM_PCIE0_PL_LINK_CAP_MAX_LINK_SPEED Gen3\
CPM_PCIE1_PL_LINK_CAP_MAX_LINK_SPEED Gen3 CPM_PCIE0_MAX_LINK_SPEED 2.5_GT/s\
CPM_PCIE1_MAX_LINK_SPEED 2.5_GT/s CPM_PCIE0_LANE_REVERSAL_EN 0\
CPM_PCIE1_LANE_REVERSAL_EN 0 CPM_PCIE0_MAILBOX_ENABLE 0\
CPM_PCIE0_PF0_CLASS_CODE 0 CPM_PCIE1_PF0_CLASS_CODE 58000\
CPM_PCIE0_PF1_CLASS_CODE 0x000 CPM_PCIE1_PF1_CLASS_CODE 0x000\
CPM_PCIE0_PF2_CLASS_CODE 0x000 CPM_PCIE1_PF2_CLASS_CODE 0x000\
CPM_PCIE0_PF3_CLASS_CODE 0x000 CPM_PCIE1_PF3_CLASS_CODE 0x000\
CPM_PCIE0_PF0_SUB_CLASS_VALUE 80 CPM_PCIE1_PF0_SUB_CLASS_VALUE 80\
CPM_PCIE0_PF1_SUB_CLASS_VALUE 80 CPM_PCIE1_PF1_SUB_CLASS_VALUE 80\
CPM_PCIE0_PF2_SUB_CLASS_VALUE 80 CPM_PCIE1_PF2_SUB_CLASS_VALUE 80\
CPM_PCIE0_PF3_SUB_CLASS_VALUE 80 CPM_PCIE1_PF3_SUB_CLASS_VALUE 80\
CPM_PCIE0_PF0_SUB_CLASS_INTF_MENU Other_memory_controller\
CPM_PCIE1_PF0_SUB_CLASS_INTF_MENU Other_memory_controller\
CPM_PCIE0_PF1_SUB_CLASS_INTF_MENU Other_memory_controller\
CPM_PCIE1_PF1_SUB_CLASS_INTF_MENU Other_memory_controller\
CPM_PCIE0_PF2_SUB_CLASS_INTF_MENU Other_memory_controller\
CPM_PCIE1_PF2_SUB_CLASS_INTF_MENU Other_memory_controller\
CPM_PCIE0_PF3_SUB_CLASS_INTF_MENU Other_memory_controller\
CPM_PCIE1_PF3_SUB_CLASS_INTF_MENU Other_memory_controller\
CPM_PCIE0_PF0_BASE_CLASS_MENU Memory_controller CPM_PCIE1_PF0_BASE_CLASS_MENU\
Memory_controller CPM_PCIE0_PF1_BASE_CLASS_MENU Memory_controller\
CPM_PCIE1_PF1_BASE_CLASS_MENU Memory_controller CPM_PCIE0_PF2_BASE_CLASS_MENU\
Memory_controller CPM_PCIE1_PF2_BASE_CLASS_MENU Memory_controller\
CPM_PCIE0_PF3_BASE_CLASS_MENU Memory_controller CPM_PCIE1_PF3_BASE_CLASS_MENU\
Memory_controller CPM_PCIE0_PF0_BASE_CLASS_VALUE 05\
CPM_PCIE1_PF0_BASE_CLASS_VALUE 05 CPM_PCIE0_PF1_BASE_CLASS_VALUE 05\
CPM_PCIE1_PF1_BASE_CLASS_VALUE 05 CPM_PCIE0_PF2_BASE_CLASS_VALUE 05\
CPM_PCIE1_PF2_BASE_CLASS_VALUE 05 CPM_PCIE0_PF3_BASE_CLASS_VALUE 05\
CPM_PCIE1_PF3_BASE_CLASS_VALUE 05 CPM_PCIE0_PF0_USE_CLASS_CODE_LOOKUP_ASSISTANT\
1 CPM_PCIE1_PF0_USE_CLASS_CODE_LOOKUP_ASSISTANT 1\
CPM_PCIE0_PF1_USE_CLASS_CODE_LOOKUP_ASSISTANT 1\
CPM_PCIE1_PF1_USE_CLASS_CODE_LOOKUP_ASSISTANT 1\
CPM_PCIE0_PF2_USE_CLASS_CODE_LOOKUP_ASSISTANT 1\
CPM_PCIE1_PF2_USE_CLASS_CODE_LOOKUP_ASSISTANT 1\
CPM_PCIE0_PF3_USE_CLASS_CODE_LOOKUP_ASSISTANT 1\
CPM_PCIE1_PF3_USE_CLASS_CODE_LOOKUP_ASSISTANT 1\
CPM_PCIE0_PF0_DEV_CAP_ENDPOINT_L0S_LATENCY less_than_64ns\
CPM_PCIE1_PF0_DEV_CAP_ENDPOINT_L0S_LATENCY less_than_64ns\
CPM_PCIE0_PF0_DEV_CAP_ENDPOINT_L1S_LATENCY less_than_1us\
CPM_PCIE1_PF0_DEV_CAP_ENDPOINT_L1S_LATENCY less_than_1us\
CPM_PCIE0_PF0_DEV_CAP_EXT_TAG_EN 0 CPM_PCIE1_PF0_DEV_CAP_EXT_TAG_EN 0\
CPM_PCIE0_PF0_DEV_CAP_10B_TAG_EN 0 CPM_PCIE1_PF0_DEV_CAP_10B_TAG_EN 0\
CPM_PCIE0_PF0_DEV_CAP_FUNCTION_LEVEL_RESET_CAPABLE 0\
CPM_PCIE1_PF0_DEV_CAP_FUNCTION_LEVEL_RESET_CAPABLE 0\
CPM_PCIE0_PF0_DEV_CAP_MAX_PAYLOAD 1024_bytes CPM_PCIE1_PF0_DEV_CAP_MAX_PAYLOAD\
1024_bytes CPM_PCIE0_PF1_VEND_ID 10EE CPM_PCIE1_PF1_VEND_ID 10EE\
CPM_PCIE0_PF2_VEND_ID 10EE CPM_PCIE1_PF2_VEND_ID 10EE CPM_PCIE0_PF3_VEND_ID\
10EE CPM_PCIE1_PF3_VEND_ID 10EE CPM_PCIE0_PF0_CFG_DEV_ID A03F\
CPM_PCIE1_PF0_CFG_DEV_ID A034 CPM_PCIE0_PF1_CFG_DEV_ID A13F\
CPM_PCIE1_PF1_CFG_DEV_ID A134 CPM_PCIE0_PF2_CFG_DEV_ID A23F\
CPM_PCIE1_PF2_CFG_DEV_ID A234 CPM_PCIE0_PF3_CFG_DEV_ID A33F\
CPM_PCIE1_PF3_CFG_DEV_ID A334 CPM_PCIE0_PF0_CFG_REV_ID 0\
CPM_PCIE1_PF0_CFG_REV_ID 0 CPM_PCIE0_PF1_CFG_REV_ID 0 CPM_PCIE1_PF1_CFG_REV_ID\
0 CPM_PCIE0_PF2_CFG_REV_ID 0 CPM_PCIE1_PF2_CFG_REV_ID 0\
CPM_PCIE0_PF3_CFG_REV_ID 0 CPM_PCIE1_PF3_CFG_REV_ID 0\
CPM_PCIE0_PF0_CFG_SUBSYS_ID 7 CPM_PCIE1_PF0_CFG_SUBSYS_ID 7\
CPM_PCIE0_PF1_CFG_SUBSYS_ID 7 CPM_PCIE1_PF1_CFG_SUBSYS_ID 7\
CPM_PCIE0_PF2_CFG_SUBSYS_ID 7 CPM_PCIE1_PF2_CFG_SUBSYS_ID 7\
CPM_PCIE0_PF3_CFG_SUBSYS_ID 7 CPM_PCIE1_PF3_CFG_SUBSYS_ID 7\
CPM_PCIE0_PF0_CFG_SUBSYS_VEND_ID 10EE CPM_PCIE1_PF0_CFG_SUBSYS_VEND_ID 10EE\
CPM_PCIE0_PF1_CFG_SUBSYS_VEND_ID 10EE CPM_PCIE1_PF1_CFG_SUBSYS_VEND_ID 10EE\
CPM_PCIE0_PF2_CFG_SUBSYS_VEND_ID 10EE CPM_PCIE1_PF2_CFG_SUBSYS_VEND_ID 10EE\
CPM_PCIE0_PF3_CFG_SUBSYS_VEND_ID 10EE CPM_PCIE1_PF3_CFG_SUBSYS_VEND_ID 10EE\
CPM_PCIE0_PF0_LINK_STATUS_SLOT_CLOCK_CONFIG 1\
CPM_PCIE1_PF0_LINK_STATUS_SLOT_CLOCK_CONFIG 1 CPM_PCIE0_PF0_INTERFACE_VALUE 0\
CPM_PCIE1_PF0_INTERFACE_VALUE 0 CPM_PCIE0_PF1_INTERFACE_VALUE 00\
CPM_PCIE1_PF1_INTERFACE_VALUE 00 CPM_PCIE0_PF2_INTERFACE_VALUE 00\
CPM_PCIE1_PF2_INTERFACE_VALUE 00 CPM_PCIE0_PF3_INTERFACE_VALUE 00\
CPM_PCIE1_PF3_INTERFACE_VALUE 00 CPM_PCIE0_PF0_CAPABILITY_POINTER 80\
CPM_PCIE1_PF0_CAPABILITY_POINTER 80 CPM_PCIE0_PF1_CAPABILITY_POINTER 80\
CPM_PCIE1_PF1_CAPABILITY_POINTER 80 CPM_PCIE0_PF2_CAPABILITY_POINTER 80\
CPM_PCIE1_PF2_CAPABILITY_POINTER 80 CPM_PCIE0_PF3_CAPABILITY_POINTER 80\
CPM_PCIE1_PF3_CAPABILITY_POINTER 80 CPM_PCIE0_PF0_INTERRUPT_PIN NONE\
CPM_PCIE1_PF0_INTERRUPT_PIN NONE CPM_PCIE0_PF1_INTERRUPT_PIN NONE\
CPM_PCIE1_PF1_INTERRUPT_PIN NONE CPM_PCIE0_PF2_INTERRUPT_PIN NONE\
CPM_PCIE1_PF2_INTERRUPT_PIN NONE CPM_PCIE0_PF3_INTERRUPT_PIN NONE\
CPM_PCIE1_PF3_INTERRUPT_PIN NONE CPM_PCIE0_VC1_BASE_DISABLE 0\
CPM_PCIE1_VC1_BASE_DISABLE 0 CPM_PCIE0_VC0_CAPABILITY_POINTER 80\
CPM_PCIE1_VC0_CAPABILITY_POINTER 80 CPM_PCIE0_PF0_VC_EXTENDED_COUNT 0\
CPM_PCIE1_PF0_VC_EXTENDED_COUNT 0 CPM_PCIE0_PF0_VC_LOW_PRIORITY_EXTENDED_COUNT\
0 CPM_PCIE1_PF0_VC_LOW_PRIORITY_EXTENDED_COUNT 0\
CPM_PCIE0_PF0_VC_ARB_CAPABILITY 0 CPM_PCIE1_PF0_VC_ARB_CAPABILITY 0\
CPM_PCIE0_PF0_VC_ARB_TBL_OFFSET 0 CPM_PCIE1_PF0_VC_ARB_TBL_OFFSET 0\
CPM_PCIE0_BRIDGE_AXI_SLAVE_IF 0 CPM_PCIE0_XDMA_AXILITE_SLAVE_IF 0\
CPM_PCIE0_EDR_IF 0 CPM_PCIE1_EDR_IF 0 CPM_PCIE0_PASID_IF 0 CPM_PCIE1_PASID_IF 0\
CPM_PCIE0_TX_FC_IF 0 CPM_PCIE1_TX_FC_IF 0 CPM_PCIE0_MESG_RSVD_IF 0\
CPM_PCIE1_MESG_RSVD_IF 0 CPM_PCIE0_MESG_TRANSMIT_IF 0\
CPM_PCIE1_MESG_TRANSMIT_IF 0 CPM_PCIE0_CFG_STS_IF 0 CPM_PCIE1_CFG_STS_IF 0\
CPM_PCIE0_CFG_CTL_IF 0 CPM_PCIE1_CFG_CTL_IF 0 CPM_PCIE0_CFG_FC_IF 0\
CPM_PCIE1_CFG_FC_IF 0 CPM_PCIE0_CFG_EXT_IF 0 CPM_PCIE1_CFG_EXT_IF 0\
CPM_PCIE0_CFG_MGMT_IF 0 CPM_PCIE1_CFG_MGMT_IF 0 CPM_PCIE0_COPY_XDMA_PF0_ENABLED\
0 CPM_PCIE0_COPY_PF0_QDMA_ENABLED 1 CPM_PCIE0_COPY_PF0_SRIOV_QDMA_ENABLED 1\
CPM_PCIE0_COPY_PF0_ENABLED 0 CPM_PCIE1_COPY_PF0_ENABLED 0\
CPM_PCIE0_COPY_SRIOV_PF0_ENABLED 1 CPM_PCIE1_COPY_SRIOV_PF0_ENABLED 1\
CPM_PCIE0_PF0_BAR0_BRIDGE_64BIT 0 CPM_PCIE0_PF0_BAR2_BRIDGE_64BIT 0\
CPM_PCIE0_PF0_BAR4_BRIDGE_64BIT 0 CPM_PCIE0_PF0_BAR0_BRIDGE_PREFETCHABLE 0\
CPM_PCIE0_PF0_BAR2_BRIDGE_PREFETCHABLE 0 CPM_PCIE0_PF0_BAR4_BRIDGE_PREFETCHABLE\
0 CPM_PCIE0_PF0_BAR0_BRIDGE_ENABLED 0 CPM_PCIE0_PF0_BAR1_BRIDGE_ENABLED 0\
CPM_PCIE0_PF0_BAR2_BRIDGE_ENABLED 0 CPM_PCIE0_PF0_BAR3_BRIDGE_ENABLED 0\
CPM_PCIE0_PF0_BAR4_BRIDGE_ENABLED 0 CPM_PCIE0_PF0_BAR5_BRIDGE_ENABLED 0\
CPM_PCIE0_PF0_BAR0_BRIDGE_SCALE Bytes CPM_PCIE0_PF0_BAR1_BRIDGE_SCALE Bytes\
CPM_PCIE0_PF0_BAR2_BRIDGE_SCALE Bytes CPM_PCIE0_PF0_BAR3_BRIDGE_SCALE Bytes\
CPM_PCIE0_PF0_BAR4_BRIDGE_SCALE Bytes CPM_PCIE0_PF0_BAR5_BRIDGE_SCALE Bytes\
CPM_PCIE0_PF0_BAR0_BRIDGE_SIZE 128 CPM_PCIE0_PF0_BAR1_BRIDGE_SIZE 128\
CPM_PCIE0_PF0_BAR2_BRIDGE_SIZE 128 CPM_PCIE0_PF0_BAR3_BRIDGE_SIZE 128\
CPM_PCIE0_PF0_BAR4_BRIDGE_SIZE 128 CPM_PCIE0_PF0_BAR5_BRIDGE_SIZE 128\
CPM_PCIE0_PF0_BAR0_BRIDGE_TYPE Memory CPM_PCIE0_PF0_BAR1_BRIDGE_TYPE Memory\
CPM_PCIE0_PF0_BAR2_BRIDGE_TYPE Memory CPM_PCIE0_PF0_BAR3_BRIDGE_TYPE Memory\
CPM_PCIE0_PF0_BAR4_BRIDGE_TYPE Memory CPM_PCIE0_PF0_BAR5_BRIDGE_TYPE Memory\
CPM_PCIE0_PF0_XDMA_64BIT 0 CPM_PCIE0_PF1_XDMA_64BIT 0 CPM_PCIE0_PF2_XDMA_64BIT\
0 CPM_PCIE0_PF3_XDMA_64BIT 0 CPM_PCIE0_PF0_XDMA_PREFETCHABLE 0\
CPM_PCIE0_PF1_XDMA_PREFETCHABLE 0 CPM_PCIE0_PF2_XDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_XDMA_PREFETCHABLE 0 CPM_PCIE0_PF0_BAR0_XDMA_AXCACHE 0\
CPM_PCIE0_PF1_BAR0_XDMA_AXCACHE 0 CPM_PCIE0_PF2_BAR0_XDMA_AXCACHE 0\
CPM_PCIE0_PF3_BAR0_XDMA_AXCACHE 0 CPM_PCIE0_PF0_BAR1_XDMA_AXCACHE 0\
CPM_PCIE0_PF1_BAR1_XDMA_AXCACHE 0 CPM_PCIE0_PF2_BAR1_XDMA_AXCACHE 0\
CPM_PCIE0_PF3_BAR1_XDMA_AXCACHE 0 CPM_PCIE0_PF0_BAR2_XDMA_AXCACHE 0\
CPM_PCIE0_PF1_BAR2_XDMA_AXCACHE 0 CPM_PCIE0_PF2_BAR2_XDMA_AXCACHE 0\
CPM_PCIE0_PF3_BAR2_XDMA_AXCACHE 0 CPM_PCIE0_PF0_BAR3_XDMA_AXCACHE 0\
CPM_PCIE0_PF1_BAR3_XDMA_AXCACHE 0 CPM_PCIE0_PF2_BAR3_XDMA_AXCACHE 0\
CPM_PCIE0_PF3_BAR3_XDMA_AXCACHE 0 CPM_PCIE0_PF0_BAR4_XDMA_AXCACHE 0\
CPM_PCIE0_PF1_BAR4_XDMA_AXCACHE 0 CPM_PCIE0_PF2_BAR4_XDMA_AXCACHE 0\
CPM_PCIE0_PF3_BAR4_XDMA_AXCACHE 0 CPM_PCIE0_PF0_BAR5_XDMA_AXCACHE 0\
CPM_PCIE0_PF1_BAR5_XDMA_AXCACHE 0 CPM_PCIE0_PF2_BAR5_XDMA_AXCACHE 0\
CPM_PCIE0_PF3_BAR5_XDMA_AXCACHE 0 CPM_PCIE0_PF0_BAR0_QDMA_AXCACHE 0\
CPM_PCIE0_PF1_BAR0_QDMA_AXCACHE 0 CPM_PCIE0_PF2_BAR0_QDMA_AXCACHE 0\
CPM_PCIE0_PF3_BAR0_QDMA_AXCACHE 0 CPM_PCIE0_PF0_BAR1_QDMA_AXCACHE 0\
CPM_PCIE0_PF1_BAR1_QDMA_AXCACHE 0 CPM_PCIE0_PF2_BAR1_QDMA_AXCACHE 0\
CPM_PCIE0_PF3_BAR1_QDMA_AXCACHE 0 CPM_PCIE0_PF0_BAR2_QDMA_AXCACHE 0\
CPM_PCIE0_PF1_BAR2_QDMA_AXCACHE 0 CPM_PCIE0_PF2_BAR2_QDMA_AXCACHE 0\
CPM_PCIE0_PF3_BAR2_QDMA_AXCACHE 0 CPM_PCIE0_PF0_BAR3_QDMA_AXCACHE 0\
CPM_PCIE0_PF1_BAR3_QDMA_AXCACHE 0 CPM_PCIE0_PF2_BAR3_QDMA_AXCACHE 0\
CPM_PCIE0_PF3_BAR3_QDMA_AXCACHE 0 CPM_PCIE0_PF0_BAR4_QDMA_AXCACHE 0\
CPM_PCIE0_PF1_BAR4_QDMA_AXCACHE 0 CPM_PCIE0_PF2_BAR4_QDMA_AXCACHE 0\
CPM_PCIE0_PF3_BAR4_QDMA_AXCACHE 0 CPM_PCIE0_PF0_BAR5_QDMA_AXCACHE 0\
CPM_PCIE0_PF1_BAR5_QDMA_AXCACHE 0 CPM_PCIE0_PF2_BAR5_QDMA_AXCACHE 0\
CPM_PCIE0_PF3_BAR5_QDMA_AXCACHE 0 CPM_PCIE0_PF0_XDMA_ENABLED 0\
CPM_PCIE0_PF1_XDMA_ENABLED 0 CPM_PCIE0_PF2_XDMA_ENABLED 0\
CPM_PCIE0_PF3_XDMA_ENABLED 0 CPM_PCIE0_PF0_EXPANSION_ROM_QDMA_ENABLED 0\
CPM_PCIE0_PF1_EXPANSION_ROM_QDMA_ENABLED 0\
CPM_PCIE0_PF2_EXPANSION_ROM_QDMA_ENABLED 0\
CPM_PCIE0_PF3_EXPANSION_ROM_QDMA_ENABLED 0 CPM_PCIE0_PF0_XDMA_SCALE Kilobytes\
CPM_PCIE0_PF1_XDMA_SCALE Kilobytes CPM_PCIE0_PF2_XDMA_SCALE Kilobytes\
CPM_PCIE0_PF3_XDMA_SCALE Kilobytes CPM_PCIE0_PF0_EXPANSION_ROM_QDMA_SCALE\
Kilobytes CPM_PCIE0_PF1_EXPANSION_ROM_QDMA_SCALE Kilobytes\
CPM_PCIE0_PF2_EXPANSION_ROM_QDMA_SCALE Kilobytes\
CPM_PCIE0_PF3_EXPANSION_ROM_QDMA_SCALE Kilobytes CPM_PCIE0_PF0_XDMA_SIZE 128\
CPM_PCIE0_PF1_XDMA_SIZE 128 CPM_PCIE0_PF2_XDMA_SIZE 128 CPM_PCIE0_PF3_XDMA_SIZE\
128 CPM_PCIE0_PF0_EXPANSION_ROM_QDMA_SIZE 2\
CPM_PCIE0_PF1_EXPANSION_ROM_QDMA_SIZE 2 CPM_PCIE0_PF2_EXPANSION_ROM_QDMA_SIZE 2\
CPM_PCIE0_PF3_EXPANSION_ROM_QDMA_SIZE 2 CPM_PCIE0_PF0_BAR0_QDMA_64BIT 1\
CPM_PCIE0_PF1_BAR0_QDMA_64BIT 1 CPM_PCIE0_PF2_BAR0_QDMA_64BIT 1\
CPM_PCIE0_PF3_BAR0_QDMA_64BIT 1 CPM_PCIE0_PF0_BAR1_QDMA_64BIT 0\
CPM_PCIE0_PF1_BAR1_QDMA_64BIT 0 CPM_PCIE0_PF2_BAR1_QDMA_64BIT 0\
CPM_PCIE0_PF3_BAR1_QDMA_64BIT 0 CPM_PCIE0_PF0_BAR2_QDMA_64BIT 0\
CPM_PCIE0_PF1_BAR2_QDMA_64BIT 0 CPM_PCIE0_PF2_BAR2_QDMA_64BIT 0\
CPM_PCIE0_PF3_BAR2_QDMA_64BIT 0 CPM_PCIE0_PF0_BAR3_QDMA_64BIT 0\
CPM_PCIE0_PF1_BAR3_QDMA_64BIT 0 CPM_PCIE0_PF2_BAR3_QDMA_64BIT 0\
CPM_PCIE0_PF3_BAR3_QDMA_64BIT 0 CPM_PCIE0_PF0_BAR4_QDMA_64BIT 0\
CPM_PCIE0_PF1_BAR4_QDMA_64BIT 0 CPM_PCIE0_PF2_BAR4_QDMA_64BIT 0\
CPM_PCIE0_PF3_BAR4_QDMA_64BIT 0 CPM_PCIE0_PF0_BAR5_QDMA_64BIT 0\
CPM_PCIE0_PF1_BAR5_QDMA_64BIT 0 CPM_PCIE0_PF2_BAR5_QDMA_64BIT 0\
CPM_PCIE0_PF3_BAR5_QDMA_64BIT 0 CPM_PCIE0_PF0_BAR0_XDMA_64BIT 1\
CPM_PCIE0_PF1_BAR0_XDMA_64BIT 0 CPM_PCIE0_PF2_BAR0_XDMA_64BIT 0\
CPM_PCIE0_PF3_BAR0_XDMA_64BIT 0 CPM_PCIE0_PF0_BAR1_XDMA_64BIT 0\
CPM_PCIE0_PF1_BAR1_XDMA_64BIT 0 CPM_PCIE0_PF2_BAR1_XDMA_64BIT 0\
CPM_PCIE0_PF3_BAR1_XDMA_64BIT 0 CPM_PCIE0_PF0_BAR2_XDMA_64BIT 0\
CPM_PCIE0_PF1_BAR2_XDMA_64BIT 0 CPM_PCIE0_PF2_BAR2_XDMA_64BIT 0\
CPM_PCIE0_PF3_BAR2_XDMA_64BIT 0 CPM_PCIE0_PF0_BAR3_XDMA_64BIT 0\
CPM_PCIE0_PF1_BAR3_XDMA_64BIT 0 CPM_PCIE0_PF2_BAR3_XDMA_64BIT 0\
CPM_PCIE0_PF3_BAR3_XDMA_64BIT 0 CPM_PCIE0_PF0_BAR4_XDMA_64BIT 0\
CPM_PCIE0_PF1_BAR4_XDMA_64BIT 0 CPM_PCIE0_PF2_BAR4_XDMA_64BIT 0\
CPM_PCIE0_PF3_BAR4_XDMA_64BIT 0 CPM_PCIE0_PF0_BAR5_XDMA_64BIT 0\
CPM_PCIE0_PF1_BAR5_XDMA_64BIT 0 CPM_PCIE0_PF2_BAR5_XDMA_64BIT 0\
CPM_PCIE0_PF3_BAR5_XDMA_64BIT 0 CPM_PCIE0_PF0_BAR0_SRIOV_QDMA_64BIT 1\
CPM_PCIE0_PF1_BAR0_SRIOV_QDMA_64BIT 0 CPM_PCIE0_PF2_BAR0_SRIOV_QDMA_64BIT 0\
CPM_PCIE0_PF3_BAR0_SRIOV_QDMA_64BIT 0 CPM_PCIE0_PF0_BAR1_SRIOV_QDMA_64BIT 0\
CPM_PCIE0_PF1_BAR1_SRIOV_QDMA_64BIT 0 CPM_PCIE0_PF2_BAR1_SRIOV_QDMA_64BIT 0\
CPM_PCIE0_PF3_BAR1_SRIOV_QDMA_64BIT 0 CPM_PCIE0_PF0_BAR2_SRIOV_QDMA_64BIT 0\
CPM_PCIE0_PF1_BAR2_SRIOV_QDMA_64BIT 0 CPM_PCIE0_PF2_BAR2_SRIOV_QDMA_64BIT 0\
CPM_PCIE0_PF3_BAR2_SRIOV_QDMA_64BIT 0 CPM_PCIE0_PF0_BAR3_SRIOV_QDMA_64BIT 0\
CPM_PCIE0_PF1_BAR3_SRIOV_QDMA_64BIT 0 CPM_PCIE0_PF2_BAR3_SRIOV_QDMA_64BIT 0\
CPM_PCIE0_PF3_BAR3_SRIOV_QDMA_64BIT 0 CPM_PCIE0_PF0_BAR4_SRIOV_QDMA_64BIT 0\
CPM_PCIE0_PF1_BAR4_SRIOV_QDMA_64BIT 0 CPM_PCIE0_PF2_BAR4_SRIOV_QDMA_64BIT 0\
CPM_PCIE0_PF3_BAR4_SRIOV_QDMA_64BIT 0 CPM_PCIE0_PF0_BAR5_SRIOV_QDMA_64BIT 0\
CPM_PCIE0_PF1_BAR5_SRIOV_QDMA_64BIT 0 CPM_PCIE0_PF2_BAR5_SRIOV_QDMA_64BIT 0\
CPM_PCIE0_PF3_BAR5_SRIOV_QDMA_64BIT 0 CPM_PCIE0_PF0_BAR0_QDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR0_QDMA_CONTROL 0 CPM_PCIE0_PF2_BAR0_QDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR0_QDMA_CONTROL 0 CPM_PCIE0_PF0_BAR1_QDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR1_QDMA_CONTROL 0 CPM_PCIE0_PF2_BAR1_QDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR1_QDMA_CONTROL 0 CPM_PCIE0_PF0_BAR2_QDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR2_QDMA_CONTROL 0 CPM_PCIE0_PF2_BAR2_QDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR2_QDMA_CONTROL 0 CPM_PCIE0_PF0_BAR3_QDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR3_QDMA_CONTROL 0 CPM_PCIE0_PF2_BAR3_QDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR3_QDMA_CONTROL 0 CPM_PCIE0_PF0_BAR4_QDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR4_QDMA_CONTROL 0 CPM_PCIE0_PF2_BAR4_QDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR4_QDMA_CONTROL 0 CPM_PCIE0_PF0_BAR5_QDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR5_QDMA_CONTROL 0 CPM_PCIE0_PF2_BAR5_QDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR5_QDMA_CONTROL 0 CPM_PCIE0_PF0_BAR0_XDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR0_XDMA_CONTROL 0 CPM_PCIE0_PF2_BAR0_XDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR0_XDMA_CONTROL 0 CPM_PCIE0_PF0_BAR1_XDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR1_XDMA_CONTROL 0 CPM_PCIE0_PF2_BAR1_XDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR1_XDMA_CONTROL 0 CPM_PCIE0_PF0_BAR2_XDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR2_XDMA_CONTROL 0 CPM_PCIE0_PF2_BAR2_XDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR2_XDMA_CONTROL 0 CPM_PCIE0_PF0_BAR3_XDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR3_XDMA_CONTROL 0 CPM_PCIE0_PF2_BAR3_XDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR3_XDMA_CONTROL 0 CPM_PCIE0_PF0_BAR4_XDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR4_XDMA_CONTROL 0 CPM_PCIE0_PF2_BAR4_XDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR4_XDMA_CONTROL 0 CPM_PCIE0_PF0_BAR5_XDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR5_XDMA_CONTROL 0 CPM_PCIE0_PF2_BAR5_XDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR5_XDMA_CONTROL 0 CPM_PCIE0_PF0_BAR0_SRIOV_QDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR0_SRIOV_QDMA_CONTROL 0 CPM_PCIE0_PF2_BAR0_SRIOV_QDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR0_SRIOV_QDMA_CONTROL 0 CPM_PCIE0_PF0_BAR1_SRIOV_QDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR1_SRIOV_QDMA_CONTROL 0 CPM_PCIE0_PF2_BAR1_SRIOV_QDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR1_SRIOV_QDMA_CONTROL 0 CPM_PCIE0_PF0_BAR2_SRIOV_QDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR2_SRIOV_QDMA_CONTROL 0 CPM_PCIE0_PF2_BAR2_SRIOV_QDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR2_SRIOV_QDMA_CONTROL 0 CPM_PCIE0_PF0_BAR3_SRIOV_QDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR3_SRIOV_QDMA_CONTROL 0 CPM_PCIE0_PF2_BAR3_SRIOV_QDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR3_SRIOV_QDMA_CONTROL 0 CPM_PCIE0_PF0_BAR4_SRIOV_QDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR4_SRIOV_QDMA_CONTROL 0 CPM_PCIE0_PF2_BAR4_SRIOV_QDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR4_SRIOV_QDMA_CONTROL 0 CPM_PCIE0_PF0_BAR5_SRIOV_QDMA_CONTROL 0\
CPM_PCIE0_PF1_BAR5_SRIOV_QDMA_CONTROL 0 CPM_PCIE0_PF2_BAR5_SRIOV_QDMA_CONTROL 0\
CPM_PCIE0_PF3_BAR5_SRIOV_QDMA_CONTROL 0 CPM_PCIE0_PF0_BAR0_QDMA_ENABLED 1\
CPM_PCIE0_PF1_BAR0_QDMA_ENABLED 1 CPM_PCIE0_PF2_BAR0_QDMA_ENABLED 1\
CPM_PCIE0_PF3_BAR0_QDMA_ENABLED 1 CPM_PCIE0_PF0_BAR1_QDMA_ENABLED 0\
CPM_PCIE0_PF1_BAR1_QDMA_ENABLED 0 CPM_PCIE0_PF2_BAR1_QDMA_ENABLED 0\
CPM_PCIE0_PF3_BAR1_QDMA_ENABLED 0 CPM_PCIE0_PF0_BAR2_QDMA_ENABLED 0\
CPM_PCIE0_PF1_BAR2_QDMA_ENABLED 0 CPM_PCIE0_PF2_BAR2_QDMA_ENABLED 0\
CPM_PCIE0_PF3_BAR2_QDMA_ENABLED 0 CPM_PCIE0_PF0_BAR3_QDMA_ENABLED 0\
CPM_PCIE0_PF1_BAR3_QDMA_ENABLED 0 CPM_PCIE0_PF2_BAR3_QDMA_ENABLED 0\
CPM_PCIE0_PF3_BAR3_QDMA_ENABLED 0 CPM_PCIE0_PF0_BAR4_QDMA_ENABLED 0\
CPM_PCIE0_PF1_BAR4_QDMA_ENABLED 0 CPM_PCIE0_PF2_BAR4_QDMA_ENABLED 0\
CPM_PCIE0_PF3_BAR4_QDMA_ENABLED 0 CPM_PCIE0_PF0_BAR5_QDMA_ENABLED 0\
CPM_PCIE0_PF1_BAR5_QDMA_ENABLED 0 CPM_PCIE0_PF2_BAR5_QDMA_ENABLED 0\
CPM_PCIE0_PF3_BAR5_QDMA_ENABLED 0 CPM_PCIE0_PF0_BAR0_XDMA_ENABLED 1\
CPM_PCIE0_PF1_BAR0_XDMA_ENABLED 0 CPM_PCIE0_PF2_BAR0_XDMA_ENABLED 0\
CPM_PCIE0_PF3_BAR0_XDMA_ENABLED 0 CPM_PCIE0_PF0_BAR1_XDMA_ENABLED 0\
CPM_PCIE0_PF1_BAR1_XDMA_ENABLED 0 CPM_PCIE0_PF2_BAR1_XDMA_ENABLED 0\
CPM_PCIE0_PF3_BAR1_XDMA_ENABLED 0 CPM_PCIE0_PF0_BAR2_XDMA_ENABLED 0\
CPM_PCIE0_PF1_BAR2_XDMA_ENABLED 0 CPM_PCIE0_PF2_BAR2_XDMA_ENABLED 0\
CPM_PCIE0_PF3_BAR2_XDMA_ENABLED 0 CPM_PCIE0_PF0_BAR3_XDMA_ENABLED 0\
CPM_PCIE0_PF1_BAR3_XDMA_ENABLED 0 CPM_PCIE0_PF2_BAR3_XDMA_ENABLED 0\
CPM_PCIE0_PF3_BAR3_XDMA_ENABLED 0 CPM_PCIE0_PF0_BAR4_XDMA_ENABLED 0\
CPM_PCIE0_PF1_BAR4_XDMA_ENABLED 0 CPM_PCIE0_PF2_BAR4_XDMA_ENABLED 0\
CPM_PCIE0_PF3_BAR4_XDMA_ENABLED 0 CPM_PCIE0_PF0_BAR5_XDMA_ENABLED 0\
CPM_PCIE0_PF1_BAR5_XDMA_ENABLED 0 CPM_PCIE0_PF2_BAR5_XDMA_ENABLED 0\
CPM_PCIE0_PF3_BAR5_XDMA_ENABLED 0 CPM_PCIE0_PF0_BAR0_SRIOV_QDMA_ENABLED 1\
CPM_PCIE0_PF1_BAR0_SRIOV_QDMA_ENABLED 1 CPM_PCIE0_PF2_BAR0_SRIOV_QDMA_ENABLED 1\
CPM_PCIE0_PF3_BAR0_SRIOV_QDMA_ENABLED 1 CPM_PCIE0_PF0_BAR1_SRIOV_QDMA_ENABLED 0\
CPM_PCIE0_PF1_BAR1_SRIOV_QDMA_ENABLED 0 CPM_PCIE0_PF2_BAR1_SRIOV_QDMA_ENABLED 0\
CPM_PCIE0_PF3_BAR1_SRIOV_QDMA_ENABLED 0 CPM_PCIE0_PF0_BAR2_SRIOV_QDMA_ENABLED 0\
CPM_PCIE0_PF1_BAR2_SRIOV_QDMA_ENABLED 0 CPM_PCIE0_PF2_BAR2_SRIOV_QDMA_ENABLED 0\
CPM_PCIE0_PF3_BAR2_SRIOV_QDMA_ENABLED 0 CPM_PCIE0_PF0_BAR3_SRIOV_QDMA_ENABLED 0\
CPM_PCIE0_PF1_BAR3_SRIOV_QDMA_ENABLED 0 CPM_PCIE0_PF2_BAR3_SRIOV_QDMA_ENABLED 0\
CPM_PCIE0_PF3_BAR3_SRIOV_QDMA_ENABLED 0 CPM_PCIE0_PF0_BAR4_SRIOV_QDMA_ENABLED 0\
CPM_PCIE0_PF1_BAR4_SRIOV_QDMA_ENABLED 0 CPM_PCIE0_PF2_BAR4_SRIOV_QDMA_ENABLED 0\
CPM_PCIE0_PF3_BAR4_SRIOV_QDMA_ENABLED 0 CPM_PCIE0_PF0_BAR5_SRIOV_QDMA_ENABLED 0\
CPM_PCIE0_PF1_BAR5_SRIOV_QDMA_ENABLED 0 CPM_PCIE0_PF2_BAR5_SRIOV_QDMA_ENABLED 0\
CPM_PCIE0_PF3_BAR5_SRIOV_QDMA_ENABLED 0 CPM_PCIE0_PF0_BAR0_QDMA_PREFETCHABLE 1\
CPM_PCIE0_PF1_BAR0_QDMA_PREFETCHABLE 1 CPM_PCIE0_PF2_BAR0_QDMA_PREFETCHABLE 1\
CPM_PCIE0_PF3_BAR0_QDMA_PREFETCHABLE 1 CPM_PCIE0_PF0_BAR1_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR1_QDMA_PREFETCHABLE 0 CPM_PCIE0_PF2_BAR1_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR1_QDMA_PREFETCHABLE 0 CPM_PCIE0_PF0_BAR2_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR2_QDMA_PREFETCHABLE 0 CPM_PCIE0_PF2_BAR2_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR2_QDMA_PREFETCHABLE 0 CPM_PCIE0_PF0_BAR3_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR3_QDMA_PREFETCHABLE 0 CPM_PCIE0_PF2_BAR3_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR3_QDMA_PREFETCHABLE 0 CPM_PCIE0_PF0_BAR4_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR4_QDMA_PREFETCHABLE 0 CPM_PCIE0_PF2_BAR4_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR4_QDMA_PREFETCHABLE 0 CPM_PCIE0_PF0_BAR5_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR5_QDMA_PREFETCHABLE 0 CPM_PCIE0_PF2_BAR5_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR5_QDMA_PREFETCHABLE 0 CPM_PCIE0_PF0_BAR0_XDMA_PREFETCHABLE 1\
CPM_PCIE0_PF1_BAR0_XDMA_PREFETCHABLE 0 CPM_PCIE0_PF2_BAR0_XDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR0_XDMA_PREFETCHABLE 0 CPM_PCIE0_PF0_BAR1_XDMA_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR1_XDMA_PREFETCHABLE 0 CPM_PCIE0_PF2_BAR1_XDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR1_XDMA_PREFETCHABLE 0 CPM_PCIE0_PF0_BAR2_XDMA_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR2_XDMA_PREFETCHABLE 0 CPM_PCIE0_PF2_BAR2_XDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR2_XDMA_PREFETCHABLE 0 CPM_PCIE0_PF0_BAR3_XDMA_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR3_XDMA_PREFETCHABLE 0 CPM_PCIE0_PF2_BAR3_XDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR3_XDMA_PREFETCHABLE 0 CPM_PCIE0_PF0_BAR4_XDMA_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR4_XDMA_PREFETCHABLE 0 CPM_PCIE0_PF2_BAR4_XDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR4_XDMA_PREFETCHABLE 0 CPM_PCIE0_PF0_BAR5_XDMA_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR5_XDMA_PREFETCHABLE 0 CPM_PCIE0_PF2_BAR5_XDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR5_XDMA_PREFETCHABLE 0\
CPM_PCIE0_PF0_BAR0_SRIOV_QDMA_PREFETCHABLE 1\
CPM_PCIE0_PF1_BAR0_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF2_BAR0_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR0_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF0_BAR1_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR1_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF2_BAR1_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR1_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF0_BAR2_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR2_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF2_BAR2_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR2_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF0_BAR3_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR3_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF2_BAR3_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR3_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF0_BAR4_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR4_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF2_BAR4_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR4_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF0_BAR5_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR5_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF2_BAR5_SRIOV_QDMA_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR5_SRIOV_QDMA_PREFETCHABLE 0 CPM_PCIE0_PF0_BAR0_QDMA_SCALE\
Kilobytes CPM_PCIE0_PF1_BAR0_QDMA_SCALE Kilobytes CPM_PCIE0_PF2_BAR0_QDMA_SCALE\
Kilobytes CPM_PCIE0_PF3_BAR0_QDMA_SCALE Kilobytes CPM_PCIE0_PF0_BAR1_QDMA_SCALE\
Bytes CPM_PCIE0_PF1_BAR1_QDMA_SCALE Bytes CPM_PCIE0_PF2_BAR1_QDMA_SCALE Bytes\
CPM_PCIE0_PF3_BAR1_QDMA_SCALE Bytes CPM_PCIE0_PF0_BAR2_QDMA_SCALE Bytes\
CPM_PCIE0_PF1_BAR2_QDMA_SCALE Bytes CPM_PCIE0_PF2_BAR2_QDMA_SCALE Bytes\
CPM_PCIE0_PF3_BAR2_QDMA_SCALE Bytes CPM_PCIE0_PF0_BAR3_QDMA_SCALE Bytes\
CPM_PCIE0_PF1_BAR3_QDMA_SCALE Bytes CPM_PCIE0_PF2_BAR3_QDMA_SCALE Bytes\
CPM_PCIE0_PF3_BAR3_QDMA_SCALE Bytes CPM_PCIE0_PF0_BAR4_QDMA_SCALE Bytes\
CPM_PCIE0_PF1_BAR4_QDMA_SCALE Bytes CPM_PCIE0_PF2_BAR4_QDMA_SCALE Bytes\
CPM_PCIE0_PF3_BAR4_QDMA_SCALE Bytes CPM_PCIE0_PF0_BAR5_QDMA_SCALE Bytes\
CPM_PCIE0_PF1_BAR5_QDMA_SCALE Bytes CPM_PCIE0_PF2_BAR5_QDMA_SCALE Bytes\
CPM_PCIE0_PF3_BAR5_QDMA_SCALE Bytes CPM_PCIE0_PF0_BAR0_XDMA_SCALE Kilobytes\
CPM_PCIE0_PF1_BAR0_XDMA_SCALE Bytes CPM_PCIE0_PF2_BAR0_XDMA_SCALE Bytes\
CPM_PCIE0_PF3_BAR0_XDMA_SCALE Bytes CPM_PCIE0_PF0_BAR1_XDMA_SCALE Bytes\
CPM_PCIE0_PF1_BAR1_XDMA_SCALE Bytes CPM_PCIE0_PF2_BAR1_XDMA_SCALE Bytes\
CPM_PCIE0_PF3_BAR1_XDMA_SCALE Bytes CPM_PCIE0_PF0_BAR2_XDMA_SCALE Bytes\
CPM_PCIE0_PF1_BAR2_XDMA_SCALE Bytes CPM_PCIE0_PF2_BAR2_XDMA_SCALE Bytes\
CPM_PCIE0_PF3_BAR2_XDMA_SCALE Bytes CPM_PCIE0_PF0_BAR3_XDMA_SCALE Bytes\
CPM_PCIE0_PF1_BAR3_XDMA_SCALE Bytes CPM_PCIE0_PF2_BAR3_XDMA_SCALE Bytes\
CPM_PCIE0_PF3_BAR3_XDMA_SCALE Bytes CPM_PCIE0_PF0_BAR4_XDMA_SCALE Bytes\
CPM_PCIE0_PF1_BAR4_XDMA_SCALE Bytes CPM_PCIE0_PF2_BAR4_XDMA_SCALE Bytes\
CPM_PCIE0_PF3_BAR4_XDMA_SCALE Bytes CPM_PCIE0_PF0_BAR5_XDMA_SCALE Bytes\
CPM_PCIE0_PF1_BAR5_XDMA_SCALE Bytes CPM_PCIE0_PF2_BAR5_XDMA_SCALE Bytes\
CPM_PCIE0_PF3_BAR5_XDMA_SCALE Bytes CPM_PCIE0_PF0_BAR0_SRIOV_QDMA_SCALE\
Kilobytes CPM_PCIE0_PF1_BAR0_SRIOV_QDMA_SCALE Kilobytes\
CPM_PCIE0_PF2_BAR0_SRIOV_QDMA_SCALE Kilobytes\
CPM_PCIE0_PF3_BAR0_SRIOV_QDMA_SCALE Kilobytes\
CPM_PCIE0_PF0_BAR1_SRIOV_QDMA_SCALE Bytes CPM_PCIE0_PF1_BAR1_SRIOV_QDMA_SCALE\
Bytes CPM_PCIE0_PF2_BAR1_SRIOV_QDMA_SCALE Bytes\
CPM_PCIE0_PF3_BAR1_SRIOV_QDMA_SCALE Bytes CPM_PCIE0_PF0_BAR2_SRIOV_QDMA_SCALE\
Bytes CPM_PCIE0_PF1_BAR2_SRIOV_QDMA_SCALE Bytes\
CPM_PCIE0_PF2_BAR2_SRIOV_QDMA_SCALE Bytes CPM_PCIE0_PF3_BAR2_SRIOV_QDMA_SCALE\
Bytes CPM_PCIE0_PF0_BAR3_SRIOV_QDMA_SCALE Bytes\
CPM_PCIE0_PF1_BAR3_SRIOV_QDMA_SCALE Bytes CPM_PCIE0_PF2_BAR3_SRIOV_QDMA_SCALE\
Bytes CPM_PCIE0_PF3_BAR3_SRIOV_QDMA_SCALE Bytes\
CPM_PCIE0_PF0_BAR4_SRIOV_QDMA_SCALE Bytes CPM_PCIE0_PF1_BAR4_SRIOV_QDMA_SCALE\
Bytes CPM_PCIE0_PF2_BAR4_SRIOV_QDMA_SCALE Bytes\
CPM_PCIE0_PF3_BAR4_SRIOV_QDMA_SCALE Bytes CPM_PCIE0_PF0_BAR5_SRIOV_QDMA_SCALE\
Bytes CPM_PCIE0_PF1_BAR5_SRIOV_QDMA_SCALE Bytes\
CPM_PCIE0_PF2_BAR5_SRIOV_QDMA_SCALE Bytes CPM_PCIE0_PF3_BAR5_SRIOV_QDMA_SCALE\
Bytes CPM_PCIE0_PF0_BAR0_QDMA_SIZE 256 CPM_PCIE0_PF1_BAR0_QDMA_SIZE 256\
CPM_PCIE0_PF2_BAR0_QDMA_SIZE 256 CPM_PCIE0_PF3_BAR0_QDMA_SIZE 256\
CPM_PCIE0_PF0_BAR1_QDMA_SIZE 128 CPM_PCIE0_PF1_BAR1_QDMA_SIZE 128\
CPM_PCIE0_PF2_BAR1_QDMA_SIZE 128 CPM_PCIE0_PF3_BAR1_QDMA_SIZE 128\
CPM_PCIE0_PF0_BAR2_QDMA_SIZE 128 CPM_PCIE0_PF1_BAR2_QDMA_SIZE 128\
CPM_PCIE0_PF2_BAR2_QDMA_SIZE 128 CPM_PCIE0_PF3_BAR2_QDMA_SIZE 128\
CPM_PCIE0_PF0_BAR3_QDMA_SIZE 128 CPM_PCIE0_PF1_BAR3_QDMA_SIZE 128\
CPM_PCIE0_PF2_BAR3_QDMA_SIZE 128 CPM_PCIE0_PF3_BAR3_QDMA_SIZE 128\
CPM_PCIE0_PF0_BAR4_QDMA_SIZE 128 CPM_PCIE0_PF1_BAR4_QDMA_SIZE 128\
CPM_PCIE0_PF2_BAR4_QDMA_SIZE 128 CPM_PCIE0_PF3_BAR4_QDMA_SIZE 128\
CPM_PCIE0_PF0_BAR5_QDMA_SIZE 128 CPM_PCIE0_PF1_BAR5_QDMA_SIZE 128\
CPM_PCIE0_PF2_BAR5_QDMA_SIZE 128 CPM_PCIE0_PF3_BAR5_QDMA_SIZE 128\
CPM_PCIE0_PF0_BAR0_XDMA_SIZE 64 CPM_PCIE0_PF1_BAR0_XDMA_SIZE 128\
CPM_PCIE0_PF2_BAR0_XDMA_SIZE 128 CPM_PCIE0_PF3_BAR0_XDMA_SIZE 128\
CPM_PCIE0_PF0_BAR1_XDMA_SIZE 128 CPM_PCIE0_PF1_BAR1_XDMA_SIZE 128\
CPM_PCIE0_PF2_BAR1_XDMA_SIZE 128 CPM_PCIE0_PF3_BAR1_XDMA_SIZE 128\
CPM_PCIE0_PF0_BAR2_XDMA_SIZE 128 CPM_PCIE0_PF1_BAR2_XDMA_SIZE 128\
CPM_PCIE0_PF2_BAR2_XDMA_SIZE 128 CPM_PCIE0_PF3_BAR2_XDMA_SIZE 128\
CPM_PCIE0_PF0_BAR3_XDMA_SIZE 128 CPM_PCIE0_PF1_BAR3_XDMA_SIZE 128\
CPM_PCIE0_PF2_BAR3_XDMA_SIZE 128 CPM_PCIE0_PF3_BAR3_XDMA_SIZE 128\
CPM_PCIE0_PF0_BAR4_XDMA_SIZE 128 CPM_PCIE0_PF1_BAR4_XDMA_SIZE 128\
CPM_PCIE0_PF2_BAR4_XDMA_SIZE 128 CPM_PCIE0_PF3_BAR4_XDMA_SIZE 128\
CPM_PCIE0_PF0_BAR5_XDMA_SIZE 128 CPM_PCIE0_PF1_BAR5_XDMA_SIZE 128\
CPM_PCIE0_PF2_BAR5_XDMA_SIZE 128 CPM_PCIE0_PF3_BAR5_XDMA_SIZE 128\
CPM_PCIE0_PF0_BAR0_SRIOV_QDMA_SIZE 16 CPM_PCIE0_PF1_BAR0_SRIOV_QDMA_SIZE 128\
CPM_PCIE0_PF2_BAR0_SRIOV_QDMA_SIZE 128 CPM_PCIE0_PF3_BAR0_SRIOV_QDMA_SIZE 128\
CPM_PCIE0_PF0_BAR1_SRIOV_QDMA_SIZE 1 CPM_PCIE0_PF1_BAR1_SRIOV_QDMA_SIZE 1\
CPM_PCIE0_PF2_BAR1_SRIOV_QDMA_SIZE 1 CPM_PCIE0_PF3_BAR1_SRIOV_QDMA_SIZE 1\
CPM_PCIE0_PF0_BAR2_SRIOV_QDMA_SIZE 1 CPM_PCIE0_PF1_BAR2_SRIOV_QDMA_SIZE 1\
CPM_PCIE0_PF2_BAR2_SRIOV_QDMA_SIZE 1 CPM_PCIE0_PF3_BAR2_SRIOV_QDMA_SIZE 1\
CPM_PCIE0_PF0_BAR3_SRIOV_QDMA_SIZE 1 CPM_PCIE0_PF1_BAR3_SRIOV_QDMA_SIZE 1\
CPM_PCIE0_PF2_BAR3_SRIOV_QDMA_SIZE 1 CPM_PCIE0_PF3_BAR3_SRIOV_QDMA_SIZE 1\
CPM_PCIE0_PF0_BAR4_SRIOV_QDMA_SIZE 1 CPM_PCIE0_PF1_BAR4_SRIOV_QDMA_SIZE 1\
CPM_PCIE0_PF2_BAR4_SRIOV_QDMA_SIZE 1 CPM_PCIE0_PF3_BAR4_SRIOV_QDMA_SIZE 1\
CPM_PCIE0_PF0_BAR5_SRIOV_QDMA_SIZE 1 CPM_PCIE0_PF1_BAR5_SRIOV_QDMA_SIZE 1\
CPM_PCIE0_PF2_BAR5_SRIOV_QDMA_SIZE 1 CPM_PCIE0_PF3_BAR5_SRIOV_QDMA_SIZE 1\
CPM_PCIE0_PF0_BAR0_QDMA_TYPE DMA CPM_PCIE0_PF1_BAR0_QDMA_TYPE DMA\
CPM_PCIE0_PF2_BAR0_QDMA_TYPE DMA CPM_PCIE0_PF3_BAR0_QDMA_TYPE DMA\
CPM_PCIE0_PF0_BAR1_QDMA_TYPE AXI_Bridge_Master CPM_PCIE0_PF1_BAR1_QDMA_TYPE\
AXI_Bridge_Master CPM_PCIE0_PF2_BAR1_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF3_BAR1_QDMA_TYPE AXI_Bridge_Master CPM_PCIE0_PF0_BAR2_QDMA_TYPE\
AXI_Bridge_Master CPM_PCIE0_PF1_BAR2_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF2_BAR2_QDMA_TYPE AXI_Bridge_Master CPM_PCIE0_PF3_BAR2_QDMA_TYPE\
AXI_Bridge_Master CPM_PCIE0_PF0_BAR3_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF1_BAR3_QDMA_TYPE AXI_Bridge_Master CPM_PCIE0_PF2_BAR3_QDMA_TYPE\
AXI_Bridge_Master CPM_PCIE0_PF3_BAR3_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF0_BAR4_QDMA_TYPE AXI_Bridge_Master CPM_PCIE0_PF1_BAR4_QDMA_TYPE\
AXI_Bridge_Master CPM_PCIE0_PF2_BAR4_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF3_BAR4_QDMA_TYPE AXI_Bridge_Master CPM_PCIE0_PF0_BAR5_QDMA_TYPE\
AXI_Bridge_Master CPM_PCIE0_PF1_BAR5_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF2_BAR5_QDMA_TYPE AXI_Bridge_Master CPM_PCIE0_PF3_BAR5_QDMA_TYPE\
AXI_Bridge_Master CPM_PCIE0_PF0_BAR0_XDMA_TYPE DMA CPM_PCIE0_PF1_BAR0_XDMA_TYPE\
AXI_Bridge_Master CPM_PCIE0_PF2_BAR0_XDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF3_BAR0_XDMA_TYPE AXI_Bridge_Master CPM_PCIE0_PF0_BAR1_XDMA_TYPE\
AXI_Bridge_Master CPM_PCIE0_PF1_BAR1_XDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF2_BAR1_XDMA_TYPE AXI_Bridge_Master CPM_PCIE0_PF3_BAR1_XDMA_TYPE\
AXI_Bridge_Master CPM_PCIE0_PF0_BAR2_XDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF1_BAR2_XDMA_TYPE AXI_Bridge_Master CPM_PCIE0_PF2_BAR2_XDMA_TYPE\
AXI_Bridge_Master CPM_PCIE0_PF3_BAR2_XDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF0_BAR3_XDMA_TYPE AXI_Bridge_Master CPM_PCIE0_PF1_BAR3_XDMA_TYPE\
AXI_Bridge_Master CPM_PCIE0_PF2_BAR3_XDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF3_BAR3_XDMA_TYPE AXI_Bridge_Master CPM_PCIE0_PF0_BAR4_XDMA_TYPE\
AXI_Bridge_Master CPM_PCIE0_PF1_BAR4_XDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF2_BAR4_XDMA_TYPE AXI_Bridge_Master CPM_PCIE0_PF3_BAR4_XDMA_TYPE\
AXI_Bridge_Master CPM_PCIE0_PF0_BAR5_XDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF1_BAR5_XDMA_TYPE AXI_Bridge_Master CPM_PCIE0_PF2_BAR5_XDMA_TYPE\
AXI_Bridge_Master CPM_PCIE0_PF3_BAR5_XDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF0_BAR0_SRIOV_QDMA_TYPE DMA CPM_PCIE0_PF1_BAR0_SRIOV_QDMA_TYPE DMA\
CPM_PCIE0_PF2_BAR0_SRIOV_QDMA_TYPE DMA CPM_PCIE0_PF3_BAR0_SRIOV_QDMA_TYPE DMA\
CPM_PCIE0_PF0_BAR1_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF1_BAR1_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF2_BAR1_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF3_BAR1_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF0_BAR2_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF1_BAR2_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF2_BAR2_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF3_BAR2_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF0_BAR3_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF1_BAR3_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF2_BAR3_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF3_BAR3_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF0_BAR4_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF1_BAR4_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF2_BAR4_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF3_BAR4_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF0_BAR5_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF1_BAR5_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF2_BAR5_SRIOV_QDMA_TYPE AXI_Bridge_Master\
CPM_PCIE0_PF3_BAR5_SRIOV_QDMA_TYPE AXI_Bridge_Master CPM_PCIE0_PF0_BAR0_64BIT 0\
CPM_PCIE1_PF0_BAR0_64BIT 0 CPM_PCIE0_PF1_BAR0_64BIT 0 CPM_PCIE1_PF1_BAR0_64BIT\
0 CPM_PCIE0_PF2_BAR0_64BIT 0 CPM_PCIE1_PF2_BAR0_64BIT 0\
CPM_PCIE0_PF3_BAR0_64BIT 0 CPM_PCIE1_PF3_BAR0_64BIT 0\
CPM_PCIE0_PF0_SRIOV_BAR0_64BIT 0 CPM_PCIE1_PF0_SRIOV_BAR0_64BIT 0\
CPM_PCIE0_PF1_SRIOV_BAR0_64BIT 0 CPM_PCIE1_PF1_SRIOV_BAR0_64BIT 0\
CPM_PCIE0_PF2_SRIOV_BAR0_64BIT 0 CPM_PCIE1_PF2_SRIOV_BAR0_64BIT 0\
CPM_PCIE0_PF3_SRIOV_BAR0_64BIT 0 CPM_PCIE1_PF3_SRIOV_BAR0_64BIT 0\
CPM_PCIE0_PF0_BAR1_64BIT 0 CPM_PCIE1_PF0_BAR1_64BIT 0 CPM_PCIE0_PF1_BAR1_64BIT\
0 CPM_PCIE1_PF1_BAR1_64BIT 0 CPM_PCIE0_PF2_BAR1_64BIT 0\
CPM_PCIE1_PF2_BAR1_64BIT 0 CPM_PCIE0_PF3_BAR1_64BIT 0 CPM_PCIE1_PF3_BAR1_64BIT\
0 CPM_PCIE0_PF0_SRIOV_BAR1_64BIT 0 CPM_PCIE1_PF0_SRIOV_BAR1_64BIT 0\
CPM_PCIE0_PF1_SRIOV_BAR1_64BIT 0 CPM_PCIE1_PF1_SRIOV_BAR1_64BIT 0\
CPM_PCIE0_PF2_SRIOV_BAR1_64BIT 0 CPM_PCIE1_PF2_SRIOV_BAR1_64BIT 0\
CPM_PCIE0_PF3_SRIOV_BAR1_64BIT 0 CPM_PCIE1_PF3_SRIOV_BAR1_64BIT 0\
CPM_PCIE0_PF0_BAR2_64BIT 0 CPM_PCIE1_PF0_BAR2_64BIT 0 CPM_PCIE0_PF1_BAR2_64BIT\
0 CPM_PCIE1_PF1_BAR2_64BIT 0 CPM_PCIE0_PF2_BAR2_64BIT 0\
CPM_PCIE1_PF2_BAR2_64BIT 0 CPM_PCIE0_PF3_BAR2_64BIT 0 CPM_PCIE1_PF3_BAR2_64BIT\
0 CPM_PCIE0_PF0_SRIOV_BAR2_64BIT 0 CPM_PCIE1_PF0_SRIOV_BAR2_64BIT 0\
CPM_PCIE0_PF1_SRIOV_BAR2_64BIT 0 CPM_PCIE1_PF1_SRIOV_BAR2_64BIT 0\
CPM_PCIE0_PF2_SRIOV_BAR2_64BIT 0 CPM_PCIE1_PF2_SRIOV_BAR2_64BIT 0\
CPM_PCIE0_PF3_SRIOV_BAR2_64BIT 0 CPM_PCIE1_PF3_SRIOV_BAR2_64BIT 0\
CPM_PCIE0_PF0_BAR3_64BIT 0 CPM_PCIE1_PF0_BAR3_64BIT 0 CPM_PCIE0_PF1_BAR3_64BIT\
0 CPM_PCIE1_PF1_BAR3_64BIT 0 CPM_PCIE0_PF2_BAR3_64BIT 0\
CPM_PCIE1_PF2_BAR3_64BIT 0 CPM_PCIE0_PF3_BAR3_64BIT 0 CPM_PCIE1_PF3_BAR3_64BIT\
0 CPM_PCIE0_PF0_SRIOV_BAR3_64BIT 0 CPM_PCIE1_PF0_SRIOV_BAR3_64BIT 0\
CPM_PCIE0_PF1_SRIOV_BAR3_64BIT 0 CPM_PCIE1_PF1_SRIOV_BAR3_64BIT 0\
CPM_PCIE0_PF2_SRIOV_BAR3_64BIT 0 CPM_PCIE1_PF2_SRIOV_BAR3_64BIT 0\
CPM_PCIE0_PF3_SRIOV_BAR3_64BIT 0 CPM_PCIE1_PF3_SRIOV_BAR3_64BIT 0\
CPM_PCIE0_PF0_BAR4_64BIT 0 CPM_PCIE1_PF0_BAR4_64BIT 0 CPM_PCIE0_PF1_BAR4_64BIT\
0 CPM_PCIE1_PF1_BAR4_64BIT 0 CPM_PCIE0_PF2_BAR4_64BIT 0\
CPM_PCIE1_PF2_BAR4_64BIT 0 CPM_PCIE0_PF3_BAR4_64BIT 0 CPM_PCIE1_PF3_BAR4_64BIT\
0 CPM_PCIE0_PF0_SRIOV_BAR4_64BIT 0 CPM_PCIE1_PF0_SRIOV_BAR4_64BIT 0\
CPM_PCIE0_PF1_SRIOV_BAR4_64BIT 0 CPM_PCIE1_PF1_SRIOV_BAR4_64BIT 0\
CPM_PCIE0_PF2_SRIOV_BAR4_64BIT 0 CPM_PCIE1_PF2_SRIOV_BAR4_64BIT 0\
CPM_PCIE0_PF3_SRIOV_BAR4_64BIT 0 CPM_PCIE1_PF3_SRIOV_BAR4_64BIT 0\
CPM_PCIE0_PF0_BAR5_64BIT 0 CPM_PCIE1_PF0_BAR5_64BIT 0 CPM_PCIE0_PF1_BAR5_64BIT\
0 CPM_PCIE1_PF1_BAR5_64BIT 0 CPM_PCIE0_PF2_BAR5_64BIT 0\
CPM_PCIE1_PF2_BAR5_64BIT 0 CPM_PCIE0_PF3_BAR5_64BIT 0 CPM_PCIE1_PF3_BAR5_64BIT\
0 CPM_PCIE0_PF0_SRIOV_BAR5_64BIT 0 CPM_PCIE1_PF0_SRIOV_BAR5_64BIT 0\
CPM_PCIE0_PF1_SRIOV_BAR5_64BIT 0 CPM_PCIE1_PF1_SRIOV_BAR5_64BIT 0\
CPM_PCIE0_PF2_SRIOV_BAR5_64BIT 0 CPM_PCIE1_PF2_SRIOV_BAR5_64BIT 0\
CPM_PCIE0_PF3_SRIOV_BAR5_64BIT 0 CPM_PCIE1_PF3_SRIOV_BAR5_64BIT 0\
CPM_PCIE0_PF0_BAR0_CONTROL 0 CPM_PCIE1_PF0_BAR0_CONTROL 0\
CPM_PCIE0_PF1_BAR0_CONTROL 0 CPM_PCIE1_PF1_BAR0_CONTROL 0\
CPM_PCIE0_PF2_BAR0_CONTROL 0 CPM_PCIE1_PF2_BAR0_CONTROL 0\
CPM_PCIE0_PF3_BAR0_CONTROL 0 CPM_PCIE1_PF3_BAR0_CONTROL 0\
CPM_PCIE0_PF0_SRIOV_BAR0_CONTROL Disabled CPM_PCIE1_PF0_SRIOV_BAR0_CONTROL\
Disabled CPM_PCIE0_PF1_SRIOV_BAR0_CONTROL Disabled\
CPM_PCIE1_PF1_SRIOV_BAR0_CONTROL Disabled CPM_PCIE0_PF2_SRIOV_BAR0_CONTROL\
Disabled CPM_PCIE1_PF2_SRIOV_BAR0_CONTROL Disabled\
CPM_PCIE0_PF3_SRIOV_BAR0_CONTROL Disabled CPM_PCIE1_PF3_SRIOV_BAR0_CONTROL\
Disabled CPM_PCIE0_PF0_BAR1_CONTROL 0 CPM_PCIE1_PF0_BAR1_CONTROL 0\
CPM_PCIE0_PF1_BAR1_CONTROL 0 CPM_PCIE1_PF1_BAR1_CONTROL 0\
CPM_PCIE0_PF2_BAR1_CONTROL 0 CPM_PCIE1_PF2_BAR1_CONTROL 0\
CPM_PCIE0_PF3_BAR1_CONTROL 0 CPM_PCIE1_PF3_BAR1_CONTROL 0\
CPM_PCIE0_PF0_SRIOV_BAR1_CONTROL Disabled CPM_PCIE1_PF0_SRIOV_BAR1_CONTROL\
Disabled CPM_PCIE0_PF1_SRIOV_BAR1_CONTROL Disabled\
CPM_PCIE1_PF1_SRIOV_BAR1_CONTROL Disabled CPM_PCIE0_PF2_SRIOV_BAR1_CONTROL\
Disabled CPM_PCIE1_PF2_SRIOV_BAR1_CONTROL Disabled\
CPM_PCIE0_PF3_SRIOV_BAR1_CONTROL Disabled CPM_PCIE1_PF3_SRIOV_BAR1_CONTROL\
Disabled CPM_PCIE0_PF0_BAR2_CONTROL 0 CPM_PCIE1_PF0_BAR2_CONTROL 0\
CPM_PCIE0_PF1_BAR2_CONTROL 0 CPM_PCIE1_PF1_BAR2_CONTROL 0\
CPM_PCIE0_PF2_BAR2_CONTROL 0 CPM_PCIE1_PF2_BAR2_CONTROL 0\
CPM_PCIE0_PF3_BAR2_CONTROL 0 CPM_PCIE1_PF3_BAR2_CONTROL 0\
CPM_PCIE0_PF0_SRIOV_BAR2_CONTROL Disabled CPM_PCIE1_PF0_SRIOV_BAR2_CONTROL\
Disabled CPM_PCIE0_PF1_SRIOV_BAR2_CONTROL Disabled\
CPM_PCIE1_PF1_SRIOV_BAR2_CONTROL Disabled CPM_PCIE0_PF2_SRIOV_BAR2_CONTROL\
Disabled CPM_PCIE1_PF2_SRIOV_BAR2_CONTROL Disabled\
CPM_PCIE0_PF3_SRIOV_BAR2_CONTROL Disabled CPM_PCIE1_PF3_SRIOV_BAR2_CONTROL\
Disabled CPM_PCIE0_PF0_BAR3_CONTROL 0 CPM_PCIE1_PF0_BAR3_CONTROL 0\
CPM_PCIE0_PF1_BAR3_CONTROL 0 CPM_PCIE1_PF1_BAR3_CONTROL 0\
CPM_PCIE0_PF2_BAR3_CONTROL 0 CPM_PCIE1_PF2_BAR3_CONTROL 0\
CPM_PCIE0_PF3_BAR3_CONTROL 0 CPM_PCIE1_PF3_BAR3_CONTROL 0\
CPM_PCIE0_PF0_SRIOV_BAR3_CONTROL Disabled CPM_PCIE1_PF0_SRIOV_BAR3_CONTROL\
Disabled CPM_PCIE0_PF1_SRIOV_BAR3_CONTROL Disabled\
CPM_PCIE1_PF1_SRIOV_BAR3_CONTROL Disabled CPM_PCIE0_PF2_SRIOV_BAR3_CONTROL\
Disabled CPM_PCIE1_PF2_SRIOV_BAR3_CONTROL Disabled\
CPM_PCIE0_PF3_SRIOV_BAR3_CONTROL Disabled CPM_PCIE1_PF3_SRIOV_BAR3_CONTROL\
Disabled CPM_PCIE0_PF0_BAR4_CONTROL 0 CPM_PCIE1_PF0_BAR4_CONTROL 0\
CPM_PCIE0_PF1_BAR4_CONTROL 0 CPM_PCIE1_PF1_BAR4_CONTROL 0\
CPM_PCIE0_PF2_BAR4_CONTROL 0 CPM_PCIE1_PF2_BAR4_CONTROL 0\
CPM_PCIE0_PF3_BAR4_CONTROL 0 CPM_PCIE1_PF3_BAR4_CONTROL 0\
CPM_PCIE0_PF0_SRIOV_BAR4_CONTROL Disabled CPM_PCIE1_PF0_SRIOV_BAR4_CONTROL\
Disabled CPM_PCIE0_PF1_SRIOV_BAR4_CONTROL Disabled\
CPM_PCIE1_PF1_SRIOV_BAR4_CONTROL Disabled CPM_PCIE0_PF2_SRIOV_BAR4_CONTROL\
Disabled CPM_PCIE1_PF2_SRIOV_BAR4_CONTROL Disabled\
CPM_PCIE0_PF3_SRIOV_BAR4_CONTROL Disabled CPM_PCIE1_PF3_SRIOV_BAR4_CONTROL\
Disabled CPM_PCIE0_PF0_BAR5_CONTROL 0 CPM_PCIE1_PF0_BAR5_CONTROL 0\
CPM_PCIE0_PF1_BAR5_CONTROL 0 CPM_PCIE1_PF1_BAR5_CONTROL 0\
CPM_PCIE0_PF2_BAR5_CONTROL 0 CPM_PCIE1_PF2_BAR5_CONTROL 0\
CPM_PCIE0_PF3_BAR5_CONTROL 0 CPM_PCIE1_PF3_BAR5_CONTROL 0\
CPM_PCIE0_PF0_SRIOV_BAR5_CONTROL Disabled CPM_PCIE1_PF0_SRIOV_BAR5_CONTROL\
Disabled CPM_PCIE0_PF1_SRIOV_BAR5_CONTROL Disabled\
CPM_PCIE1_PF1_SRIOV_BAR5_CONTROL Disabled CPM_PCIE0_PF2_SRIOV_BAR5_CONTROL\
Disabled CPM_PCIE1_PF2_SRIOV_BAR5_CONTROL Disabled\
CPM_PCIE0_PF3_SRIOV_BAR5_CONTROL Disabled CPM_PCIE1_PF3_SRIOV_BAR5_CONTROL\
Disabled CPM_PCIE0_PF0_BAR0_ENABLED 1 CPM_PCIE1_PF0_BAR0_ENABLED 1\
CPM_PCIE0_PF1_BAR0_ENABLED 1 CPM_PCIE1_PF1_BAR0_ENABLED 1\
CPM_PCIE0_PF2_BAR0_ENABLED 1 CPM_PCIE1_PF2_BAR0_ENABLED 1\
CPM_PCIE0_PF3_BAR0_ENABLED 1 CPM_PCIE1_PF3_BAR0_ENABLED 1\
CPM_PCIE0_PF0_SRIOV_BAR0_ENABLED 1 CPM_PCIE1_PF0_SRIOV_BAR0_ENABLED 1\
CPM_PCIE0_PF1_SRIOV_BAR0_ENABLED 1 CPM_PCIE1_PF1_SRIOV_BAR0_ENABLED 1\
CPM_PCIE0_PF2_SRIOV_BAR0_ENABLED 1 CPM_PCIE1_PF2_SRIOV_BAR0_ENABLED 1\
CPM_PCIE0_PF3_SRIOV_BAR0_ENABLED 1 CPM_PCIE1_PF3_SRIOV_BAR0_ENABLED 1\
CPM_PCIE0_PF0_BAR1_ENABLED 0 CPM_PCIE1_PF0_BAR1_ENABLED 0\
CPM_PCIE0_PF1_BAR1_ENABLED 0 CPM_PCIE1_PF1_BAR1_ENABLED 0\
CPM_PCIE0_PF2_BAR1_ENABLED 0 CPM_PCIE1_PF2_BAR1_ENABLED 0\
CPM_PCIE0_PF3_BAR1_ENABLED 0 CPM_PCIE1_PF3_BAR1_ENABLED 0\
CPM_PCIE0_PF0_SRIOV_BAR1_ENABLED 0 CPM_PCIE1_PF0_SRIOV_BAR1_ENABLED 0\
CPM_PCIE0_PF1_SRIOV_BAR1_ENABLED 0 CPM_PCIE1_PF1_SRIOV_BAR1_ENABLED 0\
CPM_PCIE0_PF2_SRIOV_BAR1_ENABLED 0 CPM_PCIE1_PF2_SRIOV_BAR1_ENABLED 0\
CPM_PCIE0_PF3_SRIOV_BAR1_ENABLED 0 CPM_PCIE1_PF3_SRIOV_BAR1_ENABLED 0\
CPM_PCIE0_PF0_BAR2_ENABLED 0 CPM_PCIE1_PF0_BAR2_ENABLED 0\
CPM_PCIE0_PF1_BAR2_ENABLED 0 CPM_PCIE1_PF1_BAR2_ENABLED 0\
CPM_PCIE0_PF2_BAR2_ENABLED 0 CPM_PCIE1_PF2_BAR2_ENABLED 0\
CPM_PCIE0_PF3_BAR2_ENABLED 0 CPM_PCIE1_PF3_BAR2_ENABLED 0\
CPM_PCIE0_PF0_SRIOV_BAR2_ENABLED 0 CPM_PCIE1_PF0_SRIOV_BAR2_ENABLED 0\
CPM_PCIE0_PF1_SRIOV_BAR2_ENABLED 0 CPM_PCIE1_PF1_SRIOV_BAR2_ENABLED 0\
CPM_PCIE0_PF2_SRIOV_BAR2_ENABLED 0 CPM_PCIE1_PF2_SRIOV_BAR2_ENABLED 0\
CPM_PCIE0_PF3_SRIOV_BAR2_ENABLED 0 CPM_PCIE1_PF3_SRIOV_BAR2_ENABLED 0\
CPM_PCIE0_PF0_BAR3_ENABLED 0 CPM_PCIE1_PF0_BAR3_ENABLED 0\
CPM_PCIE0_PF1_BAR3_ENABLED 0 CPM_PCIE1_PF1_BAR3_ENABLED 0\
CPM_PCIE0_PF2_BAR3_ENABLED 0 CPM_PCIE1_PF2_BAR3_ENABLED 0\
CPM_PCIE0_PF3_BAR3_ENABLED 0 CPM_PCIE1_PF3_BAR3_ENABLED 0\
CPM_PCIE0_PF0_SRIOV_BAR3_ENABLED 0 CPM_PCIE1_PF0_SRIOV_BAR3_ENABLED 0\
CPM_PCIE0_PF1_SRIOV_BAR3_ENABLED 0 CPM_PCIE1_PF1_SRIOV_BAR3_ENABLED 0\
CPM_PCIE0_PF2_SRIOV_BAR3_ENABLED 0 CPM_PCIE1_PF2_SRIOV_BAR3_ENABLED 0\
CPM_PCIE0_PF3_SRIOV_BAR3_ENABLED 0 CPM_PCIE1_PF3_SRIOV_BAR3_ENABLED 0\
CPM_PCIE0_PF0_BAR4_ENABLED 0 CPM_PCIE1_PF0_BAR4_ENABLED 0\
CPM_PCIE0_PF1_BAR4_ENABLED 0 CPM_PCIE1_PF1_BAR4_ENABLED 0\
CPM_PCIE0_PF2_BAR4_ENABLED 0 CPM_PCIE1_PF2_BAR4_ENABLED 0\
CPM_PCIE0_PF3_BAR4_ENABLED 0 CPM_PCIE1_PF3_BAR4_ENABLED 0\
CPM_PCIE0_PF0_SRIOV_BAR4_ENABLED 0 CPM_PCIE1_PF0_SRIOV_BAR4_ENABLED 0\
CPM_PCIE0_PF1_SRIOV_BAR4_ENABLED 0 CPM_PCIE1_PF1_SRIOV_BAR4_ENABLED 0\
CPM_PCIE0_PF2_SRIOV_BAR4_ENABLED 0 CPM_PCIE1_PF2_SRIOV_BAR4_ENABLED 0\
CPM_PCIE0_PF3_SRIOV_BAR4_ENABLED 0 CPM_PCIE1_PF3_SRIOV_BAR4_ENABLED 0\
CPM_PCIE0_PF0_BAR5_ENABLED 0 CPM_PCIE1_PF0_BAR5_ENABLED 0\
CPM_PCIE0_PF1_BAR5_ENABLED 0 CPM_PCIE1_PF1_BAR5_ENABLED 0\
CPM_PCIE0_PF2_BAR5_ENABLED 0 CPM_PCIE1_PF2_BAR5_ENABLED 0\
CPM_PCIE0_PF3_BAR5_ENABLED 0 CPM_PCIE1_PF3_BAR5_ENABLED 0\
CPM_PCIE0_PF0_SRIOV_BAR5_ENABLED 0 CPM_PCIE1_PF0_SRIOV_BAR5_ENABLED 0\
CPM_PCIE0_PF1_SRIOV_BAR5_ENABLED 0 CPM_PCIE1_PF1_SRIOV_BAR5_ENABLED 0\
CPM_PCIE0_PF2_SRIOV_BAR5_ENABLED 0 CPM_PCIE1_PF2_SRIOV_BAR5_ENABLED 0\
CPM_PCIE0_PF3_SRIOV_BAR5_ENABLED 0 CPM_PCIE1_PF3_SRIOV_BAR5_ENABLED 0\
CPM_PCIE0_PF0_BAR0_PREFETCHABLE 0 CPM_PCIE1_PF0_BAR0_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR0_PREFETCHABLE 0 CPM_PCIE1_PF1_BAR0_PREFETCHABLE 0\
CPM_PCIE0_PF2_BAR0_PREFETCHABLE 0 CPM_PCIE1_PF2_BAR0_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR0_PREFETCHABLE 0 CPM_PCIE1_PF3_BAR0_PREFETCHABLE 0\
CPM_PCIE0_PF0_SRIOV_BAR0_PREFETCHABLE 0 CPM_PCIE1_PF0_SRIOV_BAR0_PREFETCHABLE 0\
CPM_PCIE0_PF1_SRIOV_BAR0_PREFETCHABLE 0 CPM_PCIE1_PF1_SRIOV_BAR0_PREFETCHABLE 0\
CPM_PCIE0_PF2_SRIOV_BAR0_PREFETCHABLE 0 CPM_PCIE1_PF2_SRIOV_BAR0_PREFETCHABLE 0\
CPM_PCIE0_PF3_SRIOV_BAR0_PREFETCHABLE 0 CPM_PCIE1_PF3_SRIOV_BAR0_PREFETCHABLE 0\
CPM_PCIE0_PF0_BAR1_PREFETCHABLE 0 CPM_PCIE1_PF0_BAR1_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR1_PREFETCHABLE 0 CPM_PCIE1_PF1_BAR1_PREFETCHABLE 0\
CPM_PCIE0_PF2_BAR1_PREFETCHABLE 0 CPM_PCIE1_PF2_BAR1_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR1_PREFETCHABLE 0 CPM_PCIE1_PF3_BAR1_PREFETCHABLE 0\
CPM_PCIE0_PF0_SRIOV_BAR1_PREFETCHABLE 0 CPM_PCIE1_PF0_SRIOV_BAR1_PREFETCHABLE 0\
CPM_PCIE0_PF1_SRIOV_BAR1_PREFETCHABLE 0 CPM_PCIE1_PF1_SRIOV_BAR1_PREFETCHABLE 0\
CPM_PCIE0_PF2_SRIOV_BAR1_PREFETCHABLE 0 CPM_PCIE1_PF2_SRIOV_BAR1_PREFETCHABLE 0\
CPM_PCIE0_PF3_SRIOV_BAR1_PREFETCHABLE 0 CPM_PCIE1_PF3_SRIOV_BAR1_PREFETCHABLE 0\
CPM_PCIE0_PF0_BAR2_PREFETCHABLE 0 CPM_PCIE1_PF0_BAR2_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR2_PREFETCHABLE 0 CPM_PCIE1_PF1_BAR2_PREFETCHABLE 0\
CPM_PCIE0_PF2_BAR2_PREFETCHABLE 0 CPM_PCIE1_PF2_BAR2_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR2_PREFETCHABLE 0 CPM_PCIE1_PF3_BAR2_PREFETCHABLE 0\
CPM_PCIE0_PF0_SRIOV_BAR2_PREFETCHABLE 0 CPM_PCIE1_PF0_SRIOV_BAR2_PREFETCHABLE 0\
CPM_PCIE0_PF1_SRIOV_BAR2_PREFETCHABLE 0 CPM_PCIE1_PF1_SRIOV_BAR2_PREFETCHABLE 0\
CPM_PCIE0_PF2_SRIOV_BAR2_PREFETCHABLE 0 CPM_PCIE1_PF2_SRIOV_BAR2_PREFETCHABLE 0\
CPM_PCIE0_PF3_SRIOV_BAR2_PREFETCHABLE 0 CPM_PCIE1_PF3_SRIOV_BAR2_PREFETCHABLE 0\
CPM_PCIE0_PF0_BAR3_PREFETCHABLE 0 CPM_PCIE1_PF0_BAR3_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR3_PREFETCHABLE 0 CPM_PCIE1_PF1_BAR3_PREFETCHABLE 0\
CPM_PCIE0_PF2_BAR3_PREFETCHABLE 0 CPM_PCIE1_PF2_BAR3_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR3_PREFETCHABLE 0 CPM_PCIE1_PF3_BAR3_PREFETCHABLE 0\
CPM_PCIE0_PF0_SRIOV_BAR3_PREFETCHABLE 0 CPM_PCIE1_PF0_SRIOV_BAR3_PREFETCHABLE 0\
CPM_PCIE0_PF1_SRIOV_BAR3_PREFETCHABLE 0 CPM_PCIE1_PF1_SRIOV_BAR3_PREFETCHABLE 0\
CPM_PCIE0_PF2_SRIOV_BAR3_PREFETCHABLE 0 CPM_PCIE1_PF2_SRIOV_BAR3_PREFETCHABLE 0\
CPM_PCIE0_PF3_SRIOV_BAR3_PREFETCHABLE 0 CPM_PCIE1_PF3_SRIOV_BAR3_PREFETCHABLE 0\
CPM_PCIE0_PF0_BAR4_PREFETCHABLE 0 CPM_PCIE1_PF0_BAR4_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR4_PREFETCHABLE 0 CPM_PCIE1_PF1_BAR4_PREFETCHABLE 0\
CPM_PCIE0_PF2_BAR4_PREFETCHABLE 0 CPM_PCIE1_PF2_BAR4_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR4_PREFETCHABLE 0 CPM_PCIE1_PF3_BAR4_PREFETCHABLE 0\
CPM_PCIE0_PF0_SRIOV_BAR4_PREFETCHABLE 0 CPM_PCIE1_PF0_SRIOV_BAR4_PREFETCHABLE 0\
CPM_PCIE0_PF1_SRIOV_BAR4_PREFETCHABLE 0 CPM_PCIE1_PF1_SRIOV_BAR4_PREFETCHABLE 0\
CPM_PCIE0_PF2_SRIOV_BAR4_PREFETCHABLE 0 CPM_PCIE1_PF2_SRIOV_BAR4_PREFETCHABLE 0\
CPM_PCIE0_PF3_SRIOV_BAR4_PREFETCHABLE 0 CPM_PCIE1_PF3_SRIOV_BAR4_PREFETCHABLE 0\
CPM_PCIE0_PF0_BAR5_PREFETCHABLE 0 CPM_PCIE1_PF0_BAR5_PREFETCHABLE 0\
CPM_PCIE0_PF1_BAR5_PREFETCHABLE 0 CPM_PCIE1_PF1_BAR5_PREFETCHABLE 0\
CPM_PCIE0_PF2_BAR5_PREFETCHABLE 0 CPM_PCIE1_PF2_BAR5_PREFETCHABLE 0\
CPM_PCIE0_PF3_BAR5_PREFETCHABLE 0 CPM_PCIE1_PF3_BAR5_PREFETCHABLE 0\
CPM_PCIE0_PF0_SRIOV_BAR5_PREFETCHABLE 0 CPM_PCIE1_PF0_SRIOV_BAR5_PREFETCHABLE 0\
CPM_PCIE0_PF1_SRIOV_BAR5_PREFETCHABLE 0 CPM_PCIE1_PF1_SRIOV_BAR5_PREFETCHABLE 0\
CPM_PCIE0_PF2_SRIOV_BAR5_PREFETCHABLE 0 CPM_PCIE1_PF2_SRIOV_BAR5_PREFETCHABLE 0\
CPM_PCIE0_PF3_SRIOV_BAR5_PREFETCHABLE 0 CPM_PCIE1_PF3_SRIOV_BAR5_PREFETCHABLE 0\
CPM_PCIE0_PF0_BAR0_SCALE Kilobytes CPM_PCIE1_PF0_BAR0_SCALE Kilobytes\
CPM_PCIE0_PF1_BAR0_SCALE Kilobytes CPM_PCIE1_PF1_BAR0_SCALE Kilobytes\
CPM_PCIE0_PF2_BAR0_SCALE Kilobytes CPM_PCIE1_PF2_BAR0_SCALE Kilobytes\
CPM_PCIE0_PF3_BAR0_SCALE Kilobytes CPM_PCIE1_PF3_BAR0_SCALE Kilobytes\
CPM_PCIE0_PF0_SRIOV_BAR0_SCALE Kilobytes CPM_PCIE1_PF0_SRIOV_BAR0_SCALE\
Kilobytes CPM_PCIE0_PF1_SRIOV_BAR0_SCALE Kilobytes\
CPM_PCIE1_PF1_SRIOV_BAR0_SCALE Kilobytes CPM_PCIE0_PF2_SRIOV_BAR0_SCALE\
Kilobytes CPM_PCIE1_PF2_SRIOV_BAR0_SCALE Kilobytes\
CPM_PCIE0_PF3_SRIOV_BAR0_SCALE Kilobytes CPM_PCIE1_PF3_SRIOV_BAR0_SCALE\
Kilobytes CPM_PCIE0_PF0_BAR1_SCALE Bytes CPM_PCIE1_PF0_BAR1_SCALE Bytes\
CPM_PCIE0_PF1_BAR1_SCALE Bytes CPM_PCIE1_PF1_BAR1_SCALE Bytes\
CPM_PCIE0_PF2_BAR1_SCALE Bytes CPM_PCIE1_PF2_BAR1_SCALE Bytes\
CPM_PCIE0_PF3_BAR1_SCALE Bytes CPM_PCIE1_PF3_BAR1_SCALE Bytes\
CPM_PCIE0_PF0_SRIOV_BAR1_SCALE Bytes CPM_PCIE1_PF0_SRIOV_BAR1_SCALE Bytes\
CPM_PCIE0_PF1_SRIOV_BAR1_SCALE Bytes CPM_PCIE1_PF1_SRIOV_BAR1_SCALE Bytes\
CPM_PCIE0_PF2_SRIOV_BAR1_SCALE Bytes CPM_PCIE1_PF2_SRIOV_BAR1_SCALE Bytes\
CPM_PCIE0_PF3_SRIOV_BAR1_SCALE Bytes CPM_PCIE1_PF3_SRIOV_BAR1_SCALE Bytes\
CPM_PCIE0_PF0_BAR2_SCALE Bytes CPM_PCIE1_PF0_BAR2_SCALE Bytes\
CPM_PCIE0_PF1_BAR2_SCALE Bytes CPM_PCIE1_PF1_BAR2_SCALE Bytes\
CPM_PCIE0_PF2_BAR2_SCALE Bytes CPM_PCIE1_PF2_BAR2_SCALE Bytes\
CPM_PCIE0_PF3_BAR2_SCALE Bytes CPM_PCIE1_PF3_BAR2_SCALE Bytes\
CPM_PCIE0_PF0_SRIOV_BAR2_SCALE Bytes CPM_PCIE1_PF0_SRIOV_BAR2_SCALE Bytes\
CPM_PCIE0_PF1_SRIOV_BAR2_SCALE Bytes CPM_PCIE1_PF1_SRIOV_BAR2_SCALE Bytes\
CPM_PCIE0_PF2_SRIOV_BAR2_SCALE Bytes CPM_PCIE1_PF2_SRIOV_BAR2_SCALE Bytes\
CPM_PCIE0_PF3_SRIOV_BAR2_SCALE Bytes CPM_PCIE1_PF3_SRIOV_BAR2_SCALE Bytes\
CPM_PCIE0_PF0_BAR3_SCALE Bytes CPM_PCIE1_PF0_BAR3_SCALE Bytes\
CPM_PCIE0_PF1_BAR3_SCALE Bytes CPM_PCIE1_PF1_BAR3_SCALE Bytes\
CPM_PCIE0_PF2_BAR3_SCALE Bytes CPM_PCIE1_PF2_BAR3_SCALE Bytes\
CPM_PCIE0_PF3_BAR3_SCALE Bytes CPM_PCIE1_PF3_BAR3_SCALE Bytes\
CPM_PCIE0_PF0_SRIOV_BAR3_SCALE Bytes CPM_PCIE1_PF0_SRIOV_BAR3_SCALE Bytes\
CPM_PCIE0_PF1_SRIOV_BAR3_SCALE Bytes CPM_PCIE1_PF1_SRIOV_BAR3_SCALE Bytes\
CPM_PCIE0_PF2_SRIOV_BAR3_SCALE Bytes CPM_PCIE1_PF2_SRIOV_BAR3_SCALE Bytes\
CPM_PCIE0_PF3_SRIOV_BAR3_SCALE Bytes CPM_PCIE1_PF3_SRIOV_BAR3_SCALE Bytes\
CPM_PCIE0_PF0_BAR4_SCALE Bytes CPM_PCIE1_PF0_BAR4_SCALE Bytes\
CPM_PCIE0_PF1_BAR4_SCALE Bytes CPM_PCIE1_PF1_BAR4_SCALE Bytes\
CPM_PCIE0_PF2_BAR4_SCALE Bytes CPM_PCIE1_PF2_BAR4_SCALE Bytes\
CPM_PCIE0_PF3_BAR4_SCALE Bytes CPM_PCIE1_PF3_BAR4_SCALE Bytes\
CPM_PCIE0_PF0_SRIOV_BAR4_SCALE Bytes CPM_PCIE1_PF0_SRIOV_BAR4_SCALE Bytes\
CPM_PCIE0_PF1_SRIOV_BAR4_SCALE Bytes CPM_PCIE1_PF1_SRIOV_BAR4_SCALE Bytes\
CPM_PCIE0_PF2_SRIOV_BAR4_SCALE Bytes CPM_PCIE1_PF2_SRIOV_BAR4_SCALE Bytes\
CPM_PCIE0_PF3_SRIOV_BAR4_SCALE Bytes CPM_PCIE1_PF3_SRIOV_BAR4_SCALE Bytes\
CPM_PCIE0_PF0_BAR5_SCALE Bytes CPM_PCIE1_PF0_BAR5_SCALE Bytes\
CPM_PCIE0_PF1_BAR5_SCALE Bytes CPM_PCIE1_PF1_BAR5_SCALE Bytes\
CPM_PCIE0_PF2_BAR5_SCALE Bytes CPM_PCIE1_PF2_BAR5_SCALE Bytes\
CPM_PCIE0_PF3_BAR5_SCALE Bytes CPM_PCIE1_PF3_BAR5_SCALE Bytes\
CPM_PCIE0_PF0_SRIOV_BAR5_SCALE Bytes CPM_PCIE1_PF0_SRIOV_BAR5_SCALE Bytes\
CPM_PCIE0_PF1_SRIOV_BAR5_SCALE Bytes CPM_PCIE1_PF1_SRIOV_BAR5_SCALE Bytes\
CPM_PCIE0_PF2_SRIOV_BAR5_SCALE Bytes CPM_PCIE1_PF2_SRIOV_BAR5_SCALE Bytes\
CPM_PCIE0_PF3_SRIOV_BAR5_SCALE Bytes CPM_PCIE1_PF3_SRIOV_BAR5_SCALE Bytes\
CPM_PCIE0_PF0_BAR0_SIZE 128 CPM_PCIE1_PF0_BAR0_SIZE 128 CPM_PCIE0_PF1_BAR0_SIZE\
128 CPM_PCIE1_PF1_BAR0_SIZE 128 CPM_PCIE0_PF2_BAR0_SIZE 128\
CPM_PCIE1_PF2_BAR0_SIZE 128 CPM_PCIE0_PF3_BAR0_SIZE 128 CPM_PCIE1_PF3_BAR0_SIZE\
128 CPM_PCIE0_PF0_SRIOV_BAR0_SIZE 4 CPM_PCIE1_PF0_SRIOV_BAR0_SIZE 4\
CPM_PCIE0_PF1_SRIOV_BAR0_SIZE 4 CPM_PCIE1_PF1_SRIOV_BAR0_SIZE 4\
CPM_PCIE0_PF2_SRIOV_BAR0_SIZE 4 CPM_PCIE1_PF2_SRIOV_BAR0_SIZE 4\
CPM_PCIE0_PF3_SRIOV_BAR0_SIZE 4 CPM_PCIE1_PF3_SRIOV_BAR0_SIZE 4\
CPM_PCIE0_PF0_BAR1_SIZE 128 CPM_PCIE1_PF0_BAR1_SIZE 128 CPM_PCIE0_PF1_BAR1_SIZE\
128 CPM_PCIE1_PF1_BAR1_SIZE 128 CPM_PCIE0_PF2_BAR1_SIZE 128\
CPM_PCIE1_PF2_BAR1_SIZE 128 CPM_PCIE0_PF3_BAR1_SIZE 128 CPM_PCIE1_PF3_BAR1_SIZE\
128 CPM_PCIE0_PF0_SRIOV_BAR1_SIZE 128 CPM_PCIE1_PF0_SRIOV_BAR1_SIZE 128\
CPM_PCIE0_PF1_SRIOV_BAR1_SIZE 128 CPM_PCIE1_PF1_SRIOV_BAR1_SIZE 128\
CPM_PCIE0_PF2_SRIOV_BAR1_SIZE 128 CPM_PCIE1_PF2_SRIOV_BAR1_SIZE 128\
CPM_PCIE0_PF3_SRIOV_BAR1_SIZE 128 CPM_PCIE1_PF3_SRIOV_BAR1_SIZE 128\
CPM_PCIE0_PF0_BAR2_SIZE 128 CPM_PCIE1_PF0_BAR2_SIZE 128 CPM_PCIE0_PF1_BAR2_SIZE\
128 CPM_PCIE1_PF1_BAR2_SIZE 128 CPM_PCIE0_PF2_BAR2_SIZE 128\
CPM_PCIE1_PF2_BAR2_SIZE 128 CPM_PCIE0_PF3_BAR2_SIZE 128 CPM_PCIE1_PF3_BAR2_SIZE\
128 CPM_PCIE0_PF0_SRIOV_BAR2_SIZE 128 CPM_PCIE1_PF0_SRIOV_BAR2_SIZE 128\
CPM_PCIE0_PF1_SRIOV_BAR2_SIZE 128 CPM_PCIE1_PF1_SRIOV_BAR2_SIZE 128\
CPM_PCIE0_PF2_SRIOV_BAR2_SIZE 128 CPM_PCIE1_PF2_SRIOV_BAR2_SIZE 128\
CPM_PCIE0_PF3_SRIOV_BAR2_SIZE 128 CPM_PCIE1_PF3_SRIOV_BAR2_SIZE 128\
CPM_PCIE0_PF0_BAR3_SIZE 128 CPM_PCIE1_PF0_BAR3_SIZE 128 CPM_PCIE0_PF1_BAR3_SIZE\
128 CPM_PCIE1_PF1_BAR3_SIZE 128 CPM_PCIE0_PF2_BAR3_SIZE 128\
CPM_PCIE1_PF2_BAR3_SIZE 128 CPM_PCIE0_PF3_BAR3_SIZE 128 CPM_PCIE1_PF3_BAR3_SIZE\
128 CPM_PCIE0_PF0_SRIOV_BAR3_SIZE 128 CPM_PCIE1_PF0_SRIOV_BAR3_SIZE 128\
CPM_PCIE0_PF1_SRIOV_BAR3_SIZE 128 CPM_PCIE1_PF1_SRIOV_BAR3_SIZE 128\
CPM_PCIE0_PF2_SRIOV_BAR3_SIZE 128 CPM_PCIE1_PF2_SRIOV_BAR3_SIZE 128\
CPM_PCIE0_PF3_SRIOV_BAR3_SIZE 128 CPM_PCIE1_PF3_SRIOV_BAR3_SIZE 128\
CPM_PCIE0_PF0_BAR4_SIZE 128 CPM_PCIE1_PF0_BAR4_SIZE 128 CPM_PCIE0_PF1_BAR4_SIZE\
128 CPM_PCIE1_PF1_BAR4_SIZE 128 CPM_PCIE0_PF2_BAR4_SIZE 128\
CPM_PCIE1_PF2_BAR4_SIZE 128 CPM_PCIE0_PF3_BAR4_SIZE 128 CPM_PCIE1_PF3_BAR4_SIZE\
128 CPM_PCIE0_PF0_SRIOV_BAR4_SIZE 128 CPM_PCIE1_PF0_SRIOV_BAR4_SIZE 128\
CPM_PCIE0_PF1_SRIOV_BAR4_SIZE 128 CPM_PCIE1_PF1_SRIOV_BAR4_SIZE 128\
CPM_PCIE0_PF2_SRIOV_BAR4_SIZE 128 CPM_PCIE1_PF2_SRIOV_BAR4_SIZE 128\
CPM_PCIE0_PF3_SRIOV_BAR4_SIZE 128 CPM_PCIE1_PF3_SRIOV_BAR4_SIZE 128\
CPM_PCIE0_PF0_BAR5_SIZE 128 CPM_PCIE1_PF0_BAR5_SIZE 128 CPM_PCIE0_PF1_BAR5_SIZE\
128 CPM_PCIE1_PF1_BAR5_SIZE 128 CPM_PCIE0_PF2_BAR5_SIZE 128\
CPM_PCIE1_PF2_BAR5_SIZE 128 CPM_PCIE0_PF3_BAR5_SIZE 128 CPM_PCIE1_PF3_BAR5_SIZE\
128 CPM_PCIE0_PF0_SRIOV_BAR5_SIZE 128 CPM_PCIE1_PF0_SRIOV_BAR5_SIZE 128\
CPM_PCIE0_PF1_SRIOV_BAR5_SIZE 128 CPM_PCIE1_PF1_SRIOV_BAR5_SIZE 128\
CPM_PCIE0_PF2_SRIOV_BAR5_SIZE 128 CPM_PCIE1_PF2_SRIOV_BAR5_SIZE 128\
CPM_PCIE0_PF3_SRIOV_BAR5_SIZE 128 CPM_PCIE1_PF3_SRIOV_BAR5_SIZE 128\
CPM_PCIE0_PF0_BAR0_TYPE Memory CPM_PCIE1_PF0_BAR0_TYPE Memory\
CPM_PCIE0_PF1_BAR0_TYPE Memory CPM_PCIE1_PF1_BAR0_TYPE Memory\
CPM_PCIE0_PF2_BAR0_TYPE Memory CPM_PCIE1_PF2_BAR0_TYPE Memory\
CPM_PCIE0_PF3_BAR0_TYPE Memory CPM_PCIE1_PF3_BAR0_TYPE Memory\
CPM_PCIE0_PF0_SRIOV_BAR0_TYPE Memory CPM_PCIE1_PF0_SRIOV_BAR0_TYPE Memory\
CPM_PCIE0_PF1_SRIOV_BAR0_TYPE Memory CPM_PCIE1_PF1_SRIOV_BAR0_TYPE Memory\
CPM_PCIE0_PF2_SRIOV_BAR0_TYPE Memory CPM_PCIE1_PF2_SRIOV_BAR0_TYPE Memory\
CPM_PCIE0_PF3_SRIOV_BAR0_TYPE Memory CPM_PCIE1_PF3_SRIOV_BAR0_TYPE Memory\
CPM_PCIE0_PF0_BAR1_TYPE Memory CPM_PCIE1_PF0_BAR1_TYPE Memory\
CPM_PCIE0_PF1_BAR1_TYPE Memory CPM_PCIE1_PF1_BAR1_TYPE Memory\
CPM_PCIE0_PF2_BAR1_TYPE Memory CPM_PCIE1_PF2_BAR1_TYPE Memory\
CPM_PCIE0_PF3_BAR1_TYPE Memory CPM_PCIE1_PF3_BAR1_TYPE Memory\
CPM_PCIE0_PF0_SRIOV_BAR1_TYPE Memory CPM_PCIE1_PF0_SRIOV_BAR1_TYPE Memory\
CPM_PCIE0_PF1_SRIOV_BAR1_TYPE Memory CPM_PCIE1_PF1_SRIOV_BAR1_TYPE Memory\
CPM_PCIE0_PF2_SRIOV_BAR1_TYPE Memory CPM_PCIE1_PF2_SRIOV_BAR1_TYPE Memory\
CPM_PCIE0_PF3_SRIOV_BAR1_TYPE Memory CPM_PCIE1_PF3_SRIOV_BAR1_TYPE Memory\
CPM_PCIE0_PF0_BAR2_TYPE Memory CPM_PCIE1_PF0_BAR2_TYPE Memory\
CPM_PCIE0_PF1_BAR2_TYPE Memory CPM_PCIE1_PF1_BAR2_TYPE Memory\
CPM_PCIE0_PF2_BAR2_TYPE Memory CPM_PCIE1_PF2_BAR2_TYPE Memory\
CPM_PCIE0_PF3_BAR2_TYPE Memory CPM_PCIE1_PF3_BAR2_TYPE Memory\
CPM_PCIE0_PF0_SRIOV_BAR2_TYPE Memory CPM_PCIE1_PF0_SRIOV_BAR2_TYPE Memory\
CPM_PCIE0_PF1_SRIOV_BAR2_TYPE Memory CPM_PCIE1_PF1_SRIOV_BAR2_TYPE Memory\
CPM_PCIE0_PF2_SRIOV_BAR2_TYPE Memory CPM_PCIE1_PF2_SRIOV_BAR2_TYPE Memory\
CPM_PCIE0_PF3_SRIOV_BAR2_TYPE Memory CPM_PCIE1_PF3_SRIOV_BAR2_TYPE Memory\
CPM_PCIE0_PF0_BAR3_TYPE Memory CPM_PCIE1_PF0_BAR3_TYPE Memory\
CPM_PCIE0_PF1_BAR3_TYPE Memory CPM_PCIE1_PF1_BAR3_TYPE Memory\
CPM_PCIE0_PF2_BAR3_TYPE Memory CPM_PCIE1_PF2_BAR3_TYPE Memory\
CPM_PCIE0_PF3_BAR3_TYPE Memory CPM_PCIE1_PF3_BAR3_TYPE Memory\
CPM_PCIE0_PF0_SRIOV_BAR3_TYPE Memory CPM_PCIE1_PF0_SRIOV_BAR3_TYPE Memory\
CPM_PCIE0_PF1_SRIOV_BAR3_TYPE Memory CPM_PCIE1_PF1_SRIOV_BAR3_TYPE Memory\
CPM_PCIE0_PF2_SRIOV_BAR3_TYPE Memory CPM_PCIE1_PF2_SRIOV_BAR3_TYPE Memory\
CPM_PCIE0_PF3_SRIOV_BAR3_TYPE Memory CPM_PCIE1_PF3_SRIOV_BAR3_TYPE Memory\
CPM_PCIE0_PF0_BAR4_TYPE Memory CPM_PCIE1_PF0_BAR4_TYPE Memory\
CPM_PCIE0_PF1_BAR4_TYPE Memory CPM_PCIE1_PF1_BAR4_TYPE Memory\
CPM_PCIE0_PF2_BAR4_TYPE Memory CPM_PCIE1_PF2_BAR4_TYPE Memory\
CPM_PCIE0_PF3_BAR4_TYPE Memory CPM_PCIE1_PF3_BAR4_TYPE Memory\
CPM_PCIE0_PF0_SRIOV_BAR4_TYPE Memory CPM_PCIE1_PF0_SRIOV_BAR4_TYPE Memory\
CPM_PCIE0_PF1_SRIOV_BAR4_TYPE Memory CPM_PCIE1_PF1_SRIOV_BAR4_TYPE Memory\
CPM_PCIE0_PF2_SRIOV_BAR4_TYPE Memory CPM_PCIE1_PF2_SRIOV_BAR4_TYPE Memory\
CPM_PCIE0_PF3_SRIOV_BAR4_TYPE Memory CPM_PCIE1_PF3_SRIOV_BAR4_TYPE Memory\
CPM_PCIE0_PF0_BAR5_TYPE Memory CPM_PCIE1_PF0_BAR5_TYPE Memory\
CPM_PCIE0_PF1_BAR5_TYPE Memory CPM_PCIE1_PF1_BAR5_TYPE Memory\
CPM_PCIE0_PF2_BAR5_TYPE Memory CPM_PCIE1_PF2_BAR5_TYPE Memory\
CPM_PCIE0_PF3_BAR5_TYPE Memory CPM_PCIE1_PF3_BAR5_TYPE Memory\
CPM_PCIE0_PF0_SRIOV_BAR5_TYPE Memory CPM_PCIE1_PF0_SRIOV_BAR5_TYPE Memory\
CPM_PCIE0_PF1_SRIOV_BAR5_TYPE Memory CPM_PCIE1_PF1_SRIOV_BAR5_TYPE Memory\
CPM_PCIE0_PF2_SRIOV_BAR5_TYPE Memory CPM_PCIE1_PF2_SRIOV_BAR5_TYPE Memory\
CPM_PCIE0_PF3_SRIOV_BAR5_TYPE Memory CPM_PCIE1_PF3_SRIOV_BAR5_TYPE Memory\
CPM_PCIE0_PF0_AXIST_BYPASS_64BIT 0 CPM_PCIE1_PF0_AXIST_BYPASS_64BIT 0\
CPM_PCIE0_PF1_AXIST_BYPASS_64BIT 0 CPM_PCIE1_PF1_AXIST_BYPASS_64BIT 0\
CPM_PCIE0_PF2_AXIST_BYPASS_64BIT 0 CPM_PCIE1_PF2_AXIST_BYPASS_64BIT 0\
CPM_PCIE0_PF3_AXIST_BYPASS_64BIT 0 CPM_PCIE1_PF3_AXIST_BYPASS_64BIT 0\
CPM_PCIE0_PF0_AXILITE_MASTER_64BIT 0 CPM_PCIE1_PF0_AXILITE_MASTER_64BIT 0\
CPM_PCIE0_PF1_AXILITE_MASTER_64BIT 0 CPM_PCIE1_PF1_AXILITE_MASTER_64BIT 0\
CPM_PCIE0_PF2_AXILITE_MASTER_64BIT 0 CPM_PCIE1_PF2_AXILITE_MASTER_64BIT 0\
CPM_PCIE0_PF3_AXILITE_MASTER_64BIT 0 CPM_PCIE1_PF3_AXILITE_MASTER_64BIT 0\
CPM_PCIE0_PF0_AXIST_BYPASS_PREFETCHABLE 0\
CPM_PCIE1_PF0_AXIST_BYPASS_PREFETCHABLE 0\
CPM_PCIE0_PF1_AXIST_BYPASS_PREFETCHABLE 0\
CPM_PCIE1_PF1_AXIST_BYPASS_PREFETCHABLE 0\
CPM_PCIE0_PF2_AXIST_BYPASS_PREFETCHABLE 0\
CPM_PCIE1_PF2_AXIST_BYPASS_PREFETCHABLE 0\
CPM_PCIE0_PF3_AXIST_BYPASS_PREFETCHABLE 0\
CPM_PCIE1_PF3_AXIST_BYPASS_PREFETCHABLE 0\
CPM_PCIE0_PF0_AXILITE_MASTER_PREFETCHABLE 0\
CPM_PCIE1_PF0_AXILITE_MASTER_PREFETCHABLE 0\
CPM_PCIE0_PF1_AXILITE_MASTER_PREFETCHABLE 0\
CPM_PCIE1_PF1_AXILITE_MASTER_PREFETCHABLE 0\
CPM_PCIE0_PF2_AXILITE_MASTER_PREFETCHABLE 0\
CPM_PCIE1_PF2_AXILITE_MASTER_PREFETCHABLE 0\
CPM_PCIE0_PF3_AXILITE_MASTER_PREFETCHABLE 0\
CPM_PCIE1_PF3_AXILITE_MASTER_PREFETCHABLE 0 CPM_PCIE0_PF0_EXPANSION_ROM_ENABLED\
0 CPM_PCIE1_PF0_EXPANSION_ROM_ENABLED 0 CPM_PCIE0_PF1_EXPANSION_ROM_ENABLED 0\
CPM_PCIE1_PF1_EXPANSION_ROM_ENABLED 0 CPM_PCIE0_PF2_EXPANSION_ROM_ENABLED 0\
CPM_PCIE1_PF2_EXPANSION_ROM_ENABLED 0 CPM_PCIE0_PF3_EXPANSION_ROM_ENABLED 0\
CPM_PCIE1_PF3_EXPANSION_ROM_ENABLED 0 CPM_PCIE0_PF0_AXIST_BYPASS_ENABLED 0\
CPM_PCIE1_PF0_AXIST_BYPASS_ENABLED 0 CPM_PCIE0_PF1_AXIST_BYPASS_ENABLED 0\
CPM_PCIE1_PF1_AXIST_BYPASS_ENABLED 0 CPM_PCIE0_PF2_AXIST_BYPASS_ENABLED 0\
CPM_PCIE1_PF2_AXIST_BYPASS_ENABLED 0 CPM_PCIE0_PF3_AXIST_BYPASS_ENABLED 0\
CPM_PCIE1_PF3_AXIST_BYPASS_ENABLED 0 CPM_PCIE0_PF0_AXILITE_MASTER_ENABLED 0\
CPM_PCIE1_PF0_AXILITE_MASTER_ENABLED 0 CPM_PCIE0_PF1_AXILITE_MASTER_ENABLED 0\
CPM_PCIE1_PF1_AXILITE_MASTER_ENABLED 0 CPM_PCIE0_PF2_AXILITE_MASTER_ENABLED 0\
CPM_PCIE1_PF2_AXILITE_MASTER_ENABLED 0 CPM_PCIE0_PF3_AXILITE_MASTER_ENABLED 0\
CPM_PCIE1_PF3_AXILITE_MASTER_ENABLED 0 CPM_PCIE0_PF0_EXPANSION_ROM_SCALE\
Kilobytes CPM_PCIE1_PF0_EXPANSION_ROM_SCALE Kilobytes\
CPM_PCIE0_PF1_EXPANSION_ROM_SCALE Kilobytes CPM_PCIE1_PF1_EXPANSION_ROM_SCALE\
Kilobytes CPM_PCIE0_PF2_EXPANSION_ROM_SCALE Kilobytes\
CPM_PCIE1_PF2_EXPANSION_ROM_SCALE Kilobytes CPM_PCIE0_PF3_EXPANSION_ROM_SCALE\
Kilobytes CPM_PCIE1_PF3_EXPANSION_ROM_SCALE Kilobytes\
CPM_PCIE0_PF0_AXIST_BYPASS_SCALE Kilobytes CPM_PCIE1_PF0_AXIST_BYPASS_SCALE\
Kilobytes CPM_PCIE0_PF1_AXIST_BYPASS_SCALE Kilobytes\
CPM_PCIE1_PF1_AXIST_BYPASS_SCALE Kilobytes CPM_PCIE0_PF2_AXIST_BYPASS_SCALE\
Kilobytes CPM_PCIE1_PF2_AXIST_BYPASS_SCALE Kilobytes\
CPM_PCIE0_PF3_AXIST_BYPASS_SCALE Kilobytes CPM_PCIE1_PF3_AXIST_BYPASS_SCALE\
Kilobytes CPM_PCIE0_PF0_AXILITE_MASTER_SCALE Kilobytes\
CPM_PCIE1_PF0_AXILITE_MASTER_SCALE Kilobytes CPM_PCIE0_PF1_AXILITE_MASTER_SCALE\
Kilobytes CPM_PCIE1_PF1_AXILITE_MASTER_SCALE Kilobytes\
CPM_PCIE0_PF2_AXILITE_MASTER_SCALE Kilobytes CPM_PCIE1_PF2_AXILITE_MASTER_SCALE\
Kilobytes CPM_PCIE0_PF3_AXILITE_MASTER_SCALE Kilobytes\
CPM_PCIE1_PF3_AXILITE_MASTER_SCALE Kilobytes CPM_PCIE0_PF0_EXPANSION_ROM_SIZE 2\
CPM_PCIE1_PF0_EXPANSION_ROM_SIZE 2 CPM_PCIE0_PF1_EXPANSION_ROM_SIZE 2\
CPM_PCIE1_PF1_EXPANSION_ROM_SIZE 2 CPM_PCIE0_PF2_EXPANSION_ROM_SIZE 2\
CPM_PCIE1_PF2_EXPANSION_ROM_SIZE 2 CPM_PCIE0_PF3_EXPANSION_ROM_SIZE 2\
CPM_PCIE1_PF3_EXPANSION_ROM_SIZE 2 CPM_PCIE0_PF0_AXIST_BYPASS_SIZE 128\
CPM_PCIE1_PF0_AXIST_BYPASS_SIZE 128 CPM_PCIE0_PF1_AXIST_BYPASS_SIZE 128\
CPM_PCIE1_PF1_AXIST_BYPASS_SIZE 128 CPM_PCIE0_PF2_AXIST_BYPASS_SIZE 128\
CPM_PCIE1_PF2_AXIST_BYPASS_SIZE 128 CPM_PCIE0_PF3_AXIST_BYPASS_SIZE 128\
CPM_PCIE1_PF3_AXIST_BYPASS_SIZE 128 CPM_PCIE0_PF0_AXILITE_MASTER_SIZE 128\
CPM_PCIE1_PF0_AXILITE_MASTER_SIZE 128 CPM_PCIE0_PF1_AXILITE_MASTER_SIZE 128\
CPM_PCIE1_PF1_AXILITE_MASTER_SIZE 128 CPM_PCIE0_PF2_AXILITE_MASTER_SIZE 128\
CPM_PCIE1_PF2_AXILITE_MASTER_SIZE 128 CPM_PCIE0_PF3_AXILITE_MASTER_SIZE 128\
CPM_PCIE1_PF3_AXILITE_MASTER_SIZE 128 CPM_PCIE0_PF0_PCIEBAR2AXIBAR_BRIDGE_0\
0x0000000000000000 CPM_PCIE0_PF0_PCIEBAR2AXIBAR_BRIDGE_1 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_BRIDGE_2 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_BRIDGE_3 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_BRIDGE_4 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_BRIDGE_5 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_BASEADDR_0 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_BRIDGE_0 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_HIGHADDR_0 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_BASEADDR_1 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_BRIDGE_1 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_HIGHADDR_1 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_BASEADDR_2 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_BRIDGE_2 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_HIGHADDR_2 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_BASEADDR_3 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_BRIDGE_3 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_HIGHADDR_3 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_BASEADDR_4 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_BRIDGE_4 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_HIGHADDR_4 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_BASEADDR_5 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_BRIDGE_5 0x0000000000000000\
CPM_PCIE0_PF0_AXIBAR2PCIE_HIGHADDR_5 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_QDMA_0 0x0000000000000000\
CPM_PCIE0_PF1_PCIEBAR2AXIBAR_QDMA_0 0x0000000000000000\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_QDMA_0 0x0000000000000000\
CPM_PCIE0_PF3_PCIEBAR2AXIBAR_QDMA_0 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_SRIOV_QDMA_0 0x0000000000000000\
CPM_PCIE0_PF1_PCIEBAR2AXIBAR_SRIOV_QDMA_0 0x0000000000000000\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_SRIOV_QDMA_0 0x0000000000000000\
CPM_PCIE0_PF3_PCIEBAR2AXIBAR_SRIOV_QDMA_0 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_XDMA_0 0 CPM_PCIE0_PF1_PCIEBAR2AXIBAR_XDMA_0 0\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_XDMA_0 0 CPM_PCIE0_PF3_PCIEBAR2AXIBAR_XDMA_0 0\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_QDMA_1 0x0000000000000000\
CPM_PCIE0_PF1_PCIEBAR2AXIBAR_QDMA_1 0x0000000000000000\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_QDMA_1 0x0000000000000000\
CPM_PCIE0_PF3_PCIEBAR2AXIBAR_QDMA_1 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_SRIOV_QDMA_1 0x0000000000000000\
CPM_PCIE0_PF1_PCIEBAR2AXIBAR_SRIOV_QDMA_1 0x0000000000000000\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_SRIOV_QDMA_1 0x0000000000000000\
CPM_PCIE0_PF3_PCIEBAR2AXIBAR_SRIOV_QDMA_1 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_XDMA_1 0 CPM_PCIE0_PF1_PCIEBAR2AXIBAR_XDMA_1 0\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_XDMA_1 0 CPM_PCIE0_PF3_PCIEBAR2AXIBAR_XDMA_1 0\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_QDMA_2 0x0000000000000000\
CPM_PCIE0_PF1_PCIEBAR2AXIBAR_QDMA_2 0x0000000000000000\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_QDMA_2 0x0000000000000000\
CPM_PCIE0_PF3_PCIEBAR2AXIBAR_QDMA_2 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_SRIOV_QDMA_2 0x0000000000000000\
CPM_PCIE0_PF1_PCIEBAR2AXIBAR_SRIOV_QDMA_2 0x0000000000000000\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_SRIOV_QDMA_2 0x0000000000000000\
CPM_PCIE0_PF3_PCIEBAR2AXIBAR_SRIOV_QDMA_2 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_XDMA_2 0 CPM_PCIE0_PF1_PCIEBAR2AXIBAR_XDMA_2 0\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_XDMA_2 0 CPM_PCIE0_PF3_PCIEBAR2AXIBAR_XDMA_2 0\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_QDMA_3 0x0000000000000000\
CPM_PCIE0_PF1_PCIEBAR2AXIBAR_QDMA_3 0x0000000000000000\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_QDMA_3 0x0000000000000000\
CPM_PCIE0_PF3_PCIEBAR2AXIBAR_QDMA_3 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_SRIOV_QDMA_3 0x0000000000000000\
CPM_PCIE0_PF1_PCIEBAR2AXIBAR_SRIOV_QDMA_3 0x0000000000000000\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_SRIOV_QDMA_3 0x0000000000000000\
CPM_PCIE0_PF3_PCIEBAR2AXIBAR_SRIOV_QDMA_3 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_XDMA_3 0 CPM_PCIE0_PF1_PCIEBAR2AXIBAR_XDMA_3 0\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_XDMA_3 0 CPM_PCIE0_PF3_PCIEBAR2AXIBAR_XDMA_3 0\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_QDMA_4 0x0000000000000000\
CPM_PCIE0_PF1_PCIEBAR2AXIBAR_QDMA_4 0x0000000000000000\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_QDMA_4 0x0000000000000000\
CPM_PCIE0_PF3_PCIEBAR2AXIBAR_QDMA_4 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_SRIOV_QDMA_4 0x0000000000000000\
CPM_PCIE0_PF1_PCIEBAR2AXIBAR_SRIOV_QDMA_4 0x0000000000000000\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_SRIOV_QDMA_4 0x0000000000000000\
CPM_PCIE0_PF3_PCIEBAR2AXIBAR_SRIOV_QDMA_4 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_XDMA_4 0 CPM_PCIE0_PF1_PCIEBAR2AXIBAR_XDMA_4 0\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_XDMA_4 0 CPM_PCIE0_PF3_PCIEBAR2AXIBAR_XDMA_4 0\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_QDMA_5 0x0000000000000000\
CPM_PCIE0_PF1_PCIEBAR2AXIBAR_QDMA_5 0x0000000000000000\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_QDMA_5 0x0000000000000000\
CPM_PCIE0_PF3_PCIEBAR2AXIBAR_QDMA_5 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_SRIOV_QDMA_5 0x0000000000000000\
CPM_PCIE0_PF1_PCIEBAR2AXIBAR_SRIOV_QDMA_5 0x0000000000000000\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_SRIOV_QDMA_5 0x0000000000000000\
CPM_PCIE0_PF3_PCIEBAR2AXIBAR_SRIOV_QDMA_5 0x0000000000000000\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_XDMA_5 0 CPM_PCIE0_PF1_PCIEBAR2AXIBAR_XDMA_5 0\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_XDMA_5 0 CPM_PCIE0_PF3_PCIEBAR2AXIBAR_XDMA_5 0\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_AXIL_MASTER 0\
CPM_PCIE1_PF0_PCIEBAR2AXIBAR_AXIL_MASTER 0\
CPM_PCIE0_PF1_PCIEBAR2AXIBAR_AXIL_MASTER 0\
CPM_PCIE1_PF1_PCIEBAR2AXIBAR_AXIL_MASTER 0\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_AXIL_MASTER 0\
CPM_PCIE1_PF2_PCIEBAR2AXIBAR_AXIL_MASTER 0\
CPM_PCIE0_PF3_PCIEBAR2AXIBAR_AXIL_MASTER 0\
CPM_PCIE1_PF3_PCIEBAR2AXIBAR_AXIL_MASTER 0\
CPM_PCIE0_PF0_PCIEBAR2AXIBAR_AXIST_BYPASS 0\
CPM_PCIE1_PF0_PCIEBAR2AXIBAR_AXIST_BYPASS 0\
CPM_PCIE0_PF1_PCIEBAR2AXIBAR_AXIST_BYPASS 0\
CPM_PCIE1_PF1_PCIEBAR2AXIBAR_AXIST_BYPASS 0\
CPM_PCIE0_PF2_PCIEBAR2AXIBAR_AXIST_BYPASS 0\
CPM_PCIE1_PF2_PCIEBAR2AXIBAR_AXIST_BYPASS 0\
CPM_PCIE0_PF3_PCIEBAR2AXIBAR_AXIST_BYPASS 0\
CPM_PCIE1_PF3_PCIEBAR2AXIBAR_AXIST_BYPASS 0 CPM_PCIE0_MCAP_CAP_NEXTPTR 0\
CPM_PCIE1_MCAP_CAP_NEXTPTR 0 CPM_PCIE0_PF0_VC_CAP_NEXTPTR 0\
CPM_PCIE1_PF0_VC_CAP_NEXTPTR 0 CPM_PCIE0_PF0_PL16_CAP_NEXTPTR 0\
CPM_PCIE1_PF0_PL16_CAP_NEXTPTR 0 CPM_PCIE0_PF0_MARGINING_CAP_NEXTPTR 0\
CPM_PCIE1_PF0_MARGINING_CAP_NEXTPTR 0 CPM_PCIE0_PF0_SECONDARY_PCIE_CAP_NEXTPTR\
0 CPM_PCIE1_PF0_SECONDARY_PCIE_CAP_NEXTPTR 0 CPM_PCIE0_PF0_CAP_NEXTPTR 0\
CPM_PCIE1_PF0_CAP_NEXTPTR 0 CPM_PCIE0_PF1_CAP_NEXTPTR 0\
CPM_PCIE1_PF1_CAP_NEXTPTR 0 CPM_PCIE0_PF2_CAP_NEXTPTR 0\
CPM_PCIE1_PF2_CAP_NEXTPTR 0 CPM_PCIE0_PF3_CAP_NEXTPTR 0\
CPM_PCIE1_PF3_CAP_NEXTPTR 0 CPM_PCIE0_PF0_PM_CAP_NEXTPTR 0\
CPM_PCIE1_PF0_PM_CAP_NEXTPTR 0 CPM_PCIE0_PF1_PM_CAP_NEXTPTR 0\
CPM_PCIE1_PF1_PM_CAP_NEXTPTR 0 CPM_PCIE0_PF2_PM_CAP_NEXTPTR 0\
CPM_PCIE1_PF2_PM_CAP_NEXTPTR 0 CPM_PCIE0_PF3_PM_CAP_NEXTPTR 0\
CPM_PCIE1_PF3_PM_CAP_NEXTPTR 0 CPM_PCIE0_PF0_PRI_CAP_NEXTPTR 0\
CPM_PCIE1_PF0_PRI_CAP_NEXTPTR 0 CPM_PCIE0_PF1_PRI_CAP_NEXTPTR 0\
CPM_PCIE1_PF1_PRI_CAP_NEXTPTR 0 CPM_PCIE0_PF2_PRI_CAP_NEXTPTR 0\
CPM_PCIE1_PF2_PRI_CAP_NEXTPTR 0 CPM_PCIE0_PF3_PRI_CAP_NEXTPTR 0\
CPM_PCIE1_PF3_PRI_CAP_NEXTPTR 0 CPM_PCIE0_PF0_DSN_CAP_NEXTPTR 10C\
CPM_PCIE1_PF0_DSN_CAP_NEXTPTR 0 CPM_PCIE0_PF1_DSN_CAP_NEXTPTR 10C\
CPM_PCIE1_PF1_DSN_CAP_NEXTPTR 10C CPM_PCIE0_PF2_DSN_CAP_NEXTPTR 10C\
CPM_PCIE1_PF2_DSN_CAP_NEXTPTR 10C CPM_PCIE0_PF3_DSN_CAP_NEXTPTR 10C\
CPM_PCIE1_PF3_DSN_CAP_NEXTPTR 10C CPM_PCIE0_PF0_SRIOV_CAP_NEXTPTR 0\
CPM_PCIE1_PF0_SRIOV_CAP_NEXTPTR 0 CPM_PCIE0_PF1_SRIOV_CAP_NEXTPTR 0\
CPM_PCIE1_PF1_SRIOV_CAP_NEXTPTR 0 CPM_PCIE0_PF2_SRIOV_CAP_NEXTPTR 0\
CPM_PCIE1_PF2_SRIOV_CAP_NEXTPTR 0 CPM_PCIE0_PF3_SRIOV_CAP_NEXTPTR 0\
CPM_PCIE1_PF3_SRIOV_CAP_NEXTPTR 0 CPM_PCIE0_PF0_PASID_CAP_NEXTPTR 0\
CPM_PCIE1_PF0_PASID_CAP_NEXTPTR 0 CPM_PCIE0_PF1_PASID_CAP_NEXTPTR 0\
CPM_PCIE1_PF1_PASID_CAP_NEXTPTR 0 CPM_PCIE0_PF2_PASID_CAP_NEXTPTR 0\
CPM_PCIE1_PF2_PASID_CAP_NEXTPTR 0 CPM_PCIE0_PF3_PASID_CAP_NEXTPTR 0\
CPM_PCIE1_PF3_PASID_CAP_NEXTPTR 0 CPM_PCIE0_PF0_AER_CAP_NEXTPTR 0\
CPM_PCIE1_PF0_AER_CAP_NEXTPTR 0 CPM_PCIE0_PF1_AER_CAP_NEXTPTR 0\
CPM_PCIE1_PF1_AER_CAP_NEXTPTR 0 CPM_PCIE0_PF2_AER_CAP_NEXTPTR 0\
CPM_PCIE1_PF2_AER_CAP_NEXTPTR 0 CPM_PCIE0_PF3_AER_CAP_NEXTPTR 0\
CPM_PCIE1_PF3_AER_CAP_NEXTPTR 0 CPM_PCIE0_PF0_DLL_FEATURE_CAP_NEXTPTR 0\
CPM_PCIE1_PF0_DLL_FEATURE_CAP_NEXTPTR 0 CPM_PCIE0_PF1_DLL_FEATURE_CAP_NEXTPTR 0\
CPM_PCIE1_PF1_DLL_FEATURE_CAP_NEXTPTR 0 CPM_PCIE0_PF2_DLL_FEATURE_CAP_NEXTPTR 0\
CPM_PCIE1_PF2_DLL_FEATURE_CAP_NEXTPTR 0 CPM_PCIE0_PF3_DLL_FEATURE_CAP_NEXTPTR 0\
CPM_PCIE1_PF3_DLL_FEATURE_CAP_NEXTPTR 0 CPM_PCIE0_PF0_MSI_CAP_NEXTPTR 0\
CPM_PCIE1_PF0_MSI_CAP_NEXTPTR 0 CPM_PCIE0_PF1_MSI_CAP_NEXTPTR 0\
CPM_PCIE1_PF1_MSI_CAP_NEXTPTR 0 CPM_PCIE0_PF2_MSI_CAP_NEXTPTR 0\
CPM_PCIE1_PF2_MSI_CAP_NEXTPTR 0 CPM_PCIE0_PF3_MSI_CAP_NEXTPTR 0\
CPM_PCIE1_PF3_MSI_CAP_NEXTPTR 0 CPM_PCIE0_PF0_ATS_CAP_NEXTPTR 0\
CPM_PCIE1_PF0_ATS_CAP_NEXTPTR 0 CPM_PCIE0_VFG0_ATS_CAP_NEXTPTR 0\
CPM_PCIE1_VFG0_ATS_CAP_NEXTPTR 0 CPM_PCIE0_PF1_ATS_CAP_NEXTPTR 0\
CPM_PCIE1_PF1_ATS_CAP_NEXTPTR 0 CPM_PCIE0_VFG1_ATS_CAP_NEXTPTR 0\
CPM_PCIE1_VFG1_ATS_CAP_NEXTPTR 0 CPM_PCIE0_PF2_ATS_CAP_NEXTPTR 0\
CPM_PCIE1_PF2_ATS_CAP_NEXTPTR 0 CPM_PCIE0_VFG2_ATS_CAP_NEXTPTR 0\
CPM_PCIE1_VFG2_ATS_CAP_NEXTPTR 0 CPM_PCIE0_PF3_ATS_CAP_NEXTPTR 0\
CPM_PCIE1_PF3_ATS_CAP_NEXTPTR 0 CPM_PCIE0_VFG3_ATS_CAP_NEXTPTR 0\
CPM_PCIE1_VFG3_ATS_CAP_NEXTPTR 0 CPM_PCIE0_PF0_ARI_CAP_NEXTPTR 0\
CPM_PCIE1_PF0_ARI_CAP_NEXTPTR 0 CPM_PCIE0_VFG0_ARI_CAP_NEXTPTR 0\
CPM_PCIE1_VFG0_ARI_CAP_NEXTPTR 0 CPM_PCIE0_PF1_ARI_CAP_NEXTPTR 0\
CPM_PCIE1_PF1_ARI_CAP_NEXTPTR 0 CPM_PCIE0_VFG1_ARI_CAP_NEXTPTR 0\
CPM_PCIE1_VFG1_ARI_CAP_NEXTPTR 0 CPM_PCIE0_PF2_ARI_CAP_NEXTPTR 0\
CPM_PCIE1_PF2_ARI_CAP_NEXTPTR 0 CPM_PCIE0_VFG2_ARI_CAP_NEXTPTR 0\
CPM_PCIE1_VFG2_ARI_CAP_NEXTPTR 0 CPM_PCIE0_PF3_ARI_CAP_NEXTPTR 0\
CPM_PCIE1_PF3_ARI_CAP_NEXTPTR 0 CPM_PCIE0_VFG3_ARI_CAP_NEXTPTR 0\
CPM_PCIE1_VFG3_ARI_CAP_NEXTPTR 0 CPM_PCIE0_PF0_TPHR_CAP_NEXTPTR 0\
CPM_PCIE1_PF0_TPHR_CAP_NEXTPTR 0 CPM_PCIE0_VFG0_TPHR_CAP_NEXTPTR 0\
CPM_PCIE1_VFG0_TPHR_CAP_NEXTPTR 0 CPM_PCIE0_PF1_TPHR_CAP_NEXTPTR 0\
CPM_PCIE1_PF1_TPHR_CAP_NEXTPTR 0 CPM_PCIE0_VFG1_TPHR_CAP_NEXTPTR 0\
CPM_PCIE1_VFG1_TPHR_CAP_NEXTPTR 0 CPM_PCIE0_PF2_TPHR_CAP_NEXTPTR 0\
CPM_PCIE1_PF2_TPHR_CAP_NEXTPTR 0 CPM_PCIE0_VFG2_TPHR_CAP_NEXTPTR 0\
CPM_PCIE1_VFG2_TPHR_CAP_NEXTPTR 0 CPM_PCIE0_PF3_TPHR_CAP_NEXTPTR 0\
CPM_PCIE1_PF3_TPHR_CAP_NEXTPTR 0 CPM_PCIE0_VFG3_TPHR_CAP_NEXTPTR 0\
CPM_PCIE1_VFG3_TPHR_CAP_NEXTPTR 0 CPM_PCIE0_PF0_MSIX_CAP_NEXTPTR 0\
CPM_PCIE1_PF0_MSIX_CAP_NEXTPTR 0 CPM_PCIE0_VFG0_MSIX_CAP_NEXTPTR 0\
CPM_PCIE1_VFG0_MSIX_CAP_NEXTPTR 0 CPM_PCIE0_PF1_MSIX_CAP_NEXTPTR 0\
CPM_PCIE1_PF1_MSIX_CAP_NEXTPTR 0 CPM_PCIE0_VFG1_MSIX_CAP_NEXTPTR 0\
CPM_PCIE1_VFG1_MSIX_CAP_NEXTPTR 0 CPM_PCIE0_PF2_MSIX_CAP_NEXTPTR 0\
CPM_PCIE1_PF2_MSIX_CAP_NEXTPTR 0 CPM_PCIE0_VFG2_MSIX_CAP_NEXTPTR 0\
CPM_PCIE1_VFG2_MSIX_CAP_NEXTPTR 0 CPM_PCIE0_PF3_MSIX_CAP_NEXTPTR 0\
CPM_PCIE1_PF3_MSIX_CAP_NEXTPTR 0 CPM_PCIE0_VFG3_MSIX_CAP_NEXTPTR 0\
CPM_PCIE1_VFG3_MSIX_CAP_NEXTPTR 0 CPM_PCIE0_SRIOV_FIRST_VF_OFFSET 4\
CPM_PCIE1_SRIOV_FIRST_VF_OFFSET 4 CPM_PCIE0_PF0_SRIOV_VF_DEVICE_ID 0\
CPM_PCIE1_PF0_SRIOV_VF_DEVICE_ID 0 CPM_PCIE0_PF1_SRIOV_VF_DEVICE_ID 0\
CPM_PCIE1_PF1_SRIOV_VF_DEVICE_ID 0 CPM_PCIE0_PF2_SRIOV_VF_DEVICE_ID 0\
CPM_PCIE1_PF2_SRIOV_VF_DEVICE_ID 0 CPM_PCIE0_PF3_SRIOV_VF_DEVICE_ID 0\
CPM_PCIE1_PF3_SRIOV_VF_DEVICE_ID 0 CPM_PCIE0_PF0_SRIOV_FIRST_VF_OFFSET 4\
CPM_PCIE1_PF0_SRIOV_FIRST_VF_OFFSET 4 CPM_PCIE0_PF1_SRIOV_FIRST_VF_OFFSET 7\
CPM_PCIE1_PF1_SRIOV_FIRST_VF_OFFSET 7 CPM_PCIE0_PF2_SRIOV_FIRST_VF_OFFSET 10\
CPM_PCIE1_PF2_SRIOV_FIRST_VF_OFFSET 10 CPM_PCIE0_PF3_SRIOV_FIRST_VF_OFFSET 13\
CPM_PCIE1_PF3_SRIOV_FIRST_VF_OFFSET 13 CPM_PCIE0_PF0_SRIOV_FUNC_DEP_LINK 0\
CPM_PCIE1_PF0_SRIOV_FUNC_DEP_LINK 0 CPM_PCIE0_PF1_SRIOV_FUNC_DEP_LINK 0\
CPM_PCIE1_PF1_SRIOV_FUNC_DEP_LINK 0 CPM_PCIE0_PF2_SRIOV_FUNC_DEP_LINK 0\
CPM_PCIE1_PF2_SRIOV_FUNC_DEP_LINK 0 CPM_PCIE0_PF3_SRIOV_FUNC_DEP_LINK 0\
CPM_PCIE1_PF3_SRIOV_FUNC_DEP_LINK 0 CPM_PCIE0_PF0_SRIOV_SUPPORTED_PAGE_SIZE 553\
CPM_PCIE1_PF0_SRIOV_SUPPORTED_PAGE_SIZE 553\
CPM_PCIE0_PF1_SRIOV_SUPPORTED_PAGE_SIZE 553\
CPM_PCIE1_PF1_SRIOV_SUPPORTED_PAGE_SIZE 553\
CPM_PCIE0_PF2_SRIOV_SUPPORTED_PAGE_SIZE 553\
CPM_PCIE1_PF2_SRIOV_SUPPORTED_PAGE_SIZE 553\
CPM_PCIE0_PF3_SRIOV_SUPPORTED_PAGE_SIZE 553\
CPM_PCIE1_PF3_SRIOV_SUPPORTED_PAGE_SIZE 553\
CPM_PCIE0_PF0_SRIOV_ARI_CAPBL_HIER_PRESERVED 0\
CPM_PCIE1_PF0_SRIOV_ARI_CAPBL_HIER_PRESERVED 0\
CPM_PCIE0_PF1_SRIOV_ARI_CAPBL_HIER_PRESERVED 0\
CPM_PCIE1_PF1_SRIOV_ARI_CAPBL_HIER_PRESERVED 0\
CPM_PCIE0_PF2_SRIOV_ARI_CAPBL_HIER_PRESERVED 0\
CPM_PCIE1_PF2_SRIOV_ARI_CAPBL_HIER_PRESERVED 0\
CPM_PCIE0_PF3_SRIOV_ARI_CAPBL_HIER_PRESERVED 0\
CPM_PCIE1_PF3_SRIOV_ARI_CAPBL_HIER_PRESERVED 0 CPM_PCIE0_PF0_SRIOV_CAP_TOTAL_VF\
0 CPM_PCIE1_PF0_SRIOV_CAP_TOTAL_VF 0 CPM_PCIE0_PF1_SRIOV_CAP_TOTAL_VF 0\
CPM_PCIE1_PF1_SRIOV_CAP_TOTAL_VF 0 CPM_PCIE0_PF2_SRIOV_CAP_TOTAL_VF 0\
CPM_PCIE1_PF2_SRIOV_CAP_TOTAL_VF 0 CPM_PCIE0_PF3_SRIOV_CAP_TOTAL_VF 0\
CPM_PCIE1_PF3_SRIOV_CAP_TOTAL_VF 0 CPM_PCIE0_PF0_SRIOV_CAP_INITIAL_VF 4\
CPM_PCIE1_PF0_SRIOV_CAP_INITIAL_VF 4 CPM_PCIE0_PF1_SRIOV_CAP_INITIAL_VF 4\
CPM_PCIE1_PF1_SRIOV_CAP_INITIAL_VF 4 CPM_PCIE0_PF2_SRIOV_CAP_INITIAL_VF 4\
CPM_PCIE1_PF2_SRIOV_CAP_INITIAL_VF 4 CPM_PCIE0_PF3_SRIOV_CAP_INITIAL_VF 4\
CPM_PCIE1_PF3_SRIOV_CAP_INITIAL_VF 4 CPM_PCIE0_MSI_X_OPTIONS None\
CPM_PCIE1_MSI_X_OPTIONS None CPM_PCIE0_MSIX_RP_ENABLED 1\
CPM_PCIE1_MSIX_RP_ENABLED 1 CPM_PCIE0_PF0_MSIX_ENABLED 1\
CPM_PCIE1_PF0_MSIX_ENABLED 1 CPM_PCIE0_VFG0_MSIX_ENABLED 1\
CPM_PCIE1_VFG0_MSIX_ENABLED 1 CPM_PCIE0_PF1_MSIX_ENABLED 1\
CPM_PCIE1_PF1_MSIX_ENABLED 1 CPM_PCIE0_VFG1_MSIX_ENABLED 1\
CPM_PCIE1_VFG1_MSIX_ENABLED 1 CPM_PCIE0_PF2_MSIX_ENABLED 1\
CPM_PCIE1_PF2_MSIX_ENABLED 1 CPM_PCIE0_VFG2_MSIX_ENABLED 1\
CPM_PCIE1_VFG2_MSIX_ENABLED 1 CPM_PCIE0_PF3_MSIX_ENABLED 1\
CPM_PCIE1_PF3_MSIX_ENABLED 1 CPM_PCIE0_VFG3_MSIX_ENABLED 1\
CPM_PCIE1_VFG3_MSIX_ENABLED 1 CPM_PCIE0_PF0_MSIX_CAP_PBA_BIR BAR_0\
CPM_PCIE1_PF0_MSIX_CAP_PBA_BIR BAR_0 CPM_PCIE0_VFG0_MSIX_CAP_PBA_BIR BAR_0\
CPM_PCIE1_VFG0_MSIX_CAP_PBA_BIR BAR_0 CPM_PCIE0_PF1_MSIX_CAP_PBA_BIR BAR_0\
CPM_PCIE1_PF1_MSIX_CAP_PBA_BIR BAR_0 CPM_PCIE0_VFG1_MSIX_CAP_PBA_BIR BAR_0\
CPM_PCIE1_VFG1_MSIX_CAP_PBA_BIR BAR_0 CPM_PCIE0_PF2_MSIX_CAP_PBA_BIR BAR_0\
CPM_PCIE1_PF2_MSIX_CAP_PBA_BIR BAR_0 CPM_PCIE0_VFG2_MSIX_CAP_PBA_BIR BAR_0\
CPM_PCIE1_VFG2_MSIX_CAP_PBA_BIR BAR_0 CPM_PCIE0_PF3_MSIX_CAP_PBA_BIR BAR_0\
CPM_PCIE1_PF3_MSIX_CAP_PBA_BIR BAR_0 CPM_PCIE0_VFG3_MSIX_CAP_PBA_BIR BAR_0\
CPM_PCIE1_VFG3_MSIX_CAP_PBA_BIR BAR_0 CPM_PCIE0_PF0_MSIX_CAP_PBA_OFFSET 50\
CPM_PCIE1_PF0_MSIX_CAP_PBA_OFFSET 50 CPM_PCIE0_VFG0_MSIX_CAP_PBA_OFFSET 50\
CPM_PCIE1_VFG0_MSIX_CAP_PBA_OFFSET 50 CPM_PCIE0_PF1_MSIX_CAP_PBA_OFFSET 50\
CPM_PCIE1_PF1_MSIX_CAP_PBA_OFFSET 50 CPM_PCIE0_VFG1_MSIX_CAP_PBA_OFFSET 50\
CPM_PCIE1_VFG1_MSIX_CAP_PBA_OFFSET 50 CPM_PCIE0_PF2_MSIX_CAP_PBA_OFFSET 50\
CPM_PCIE1_PF2_MSIX_CAP_PBA_OFFSET 50 CPM_PCIE0_VFG2_MSIX_CAP_PBA_OFFSET 50\
CPM_PCIE1_VFG2_MSIX_CAP_PBA_OFFSET 50 CPM_PCIE0_PF3_MSIX_CAP_PBA_OFFSET 50\
CPM_PCIE1_PF3_MSIX_CAP_PBA_OFFSET 50 CPM_PCIE0_VFG3_MSIX_CAP_PBA_OFFSET 50\
CPM_PCIE1_VFG3_MSIX_CAP_PBA_OFFSET 50 CPM_PCIE0_PF0_MSIX_CAP_TABLE_BIR BAR_0\
CPM_PCIE1_PF0_MSIX_CAP_TABLE_BIR BAR_0 CPM_PCIE0_VFG0_MSIX_CAP_TABLE_BIR BAR_0\
CPM_PCIE1_VFG0_MSIX_CAP_TABLE_BIR BAR_0 CPM_PCIE0_PF1_MSIX_CAP_TABLE_BIR BAR_0\
CPM_PCIE1_PF1_MSIX_CAP_TABLE_BIR BAR_0 CPM_PCIE0_VFG1_MSIX_CAP_TABLE_BIR BAR_0\
CPM_PCIE1_VFG1_MSIX_CAP_TABLE_BIR BAR_0 CPM_PCIE0_PF2_MSIX_CAP_TABLE_BIR BAR_0\
CPM_PCIE1_PF2_MSIX_CAP_TABLE_BIR BAR_0 CPM_PCIE0_VFG2_MSIX_CAP_TABLE_BIR BAR_0\
CPM_PCIE1_VFG2_MSIX_CAP_TABLE_BIR BAR_0 CPM_PCIE0_PF3_MSIX_CAP_TABLE_BIR BAR_0\
CPM_PCIE1_PF3_MSIX_CAP_TABLE_BIR BAR_0 CPM_PCIE0_VFG3_MSIX_CAP_TABLE_BIR BAR_0\
CPM_PCIE1_VFG3_MSIX_CAP_TABLE_BIR BAR_0 CPM_PCIE0_PF0_MSIX_CAP_TABLE_OFFSET 40\
CPM_PCIE1_PF0_MSIX_CAP_TABLE_OFFSET 40 CPM_PCIE0_VFG0_MSIX_CAP_TABLE_OFFSET 40\
CPM_PCIE1_VFG0_MSIX_CAP_TABLE_OFFSET 40 CPM_PCIE0_PF1_MSIX_CAP_TABLE_OFFSET 40\
CPM_PCIE1_PF1_MSIX_CAP_TABLE_OFFSET 40 CPM_PCIE0_VFG1_MSIX_CAP_TABLE_OFFSET 40\
CPM_PCIE1_VFG1_MSIX_CAP_TABLE_OFFSET 40 CPM_PCIE0_PF2_MSIX_CAP_TABLE_OFFSET 40\
CPM_PCIE1_PF2_MSIX_CAP_TABLE_OFFSET 40 CPM_PCIE0_VFG2_MSIX_CAP_TABLE_OFFSET 40\
CPM_PCIE1_VFG2_MSIX_CAP_TABLE_OFFSET 40 CPM_PCIE0_PF3_MSIX_CAP_TABLE_OFFSET 40\
CPM_PCIE1_PF3_MSIX_CAP_TABLE_OFFSET 40 CPM_PCIE0_VFG3_MSIX_CAP_TABLE_OFFSET 40\
CPM_PCIE1_VFG3_MSIX_CAP_TABLE_OFFSET 40 CPM_PCIE0_PF0_MSIX_CAP_TABLE_SIZE 001\
CPM_PCIE1_PF0_MSIX_CAP_TABLE_SIZE 001 CPM_PCIE0_VFG0_MSIX_CAP_TABLE_SIZE 001\
CPM_PCIE1_VFG0_MSIX_CAP_TABLE_SIZE 001 CPM_PCIE0_PF1_MSIX_CAP_TABLE_SIZE 001\
CPM_PCIE1_PF1_MSIX_CAP_TABLE_SIZE 001 CPM_PCIE0_VFG1_MSIX_CAP_TABLE_SIZE 001\
CPM_PCIE1_VFG1_MSIX_CAP_TABLE_SIZE 001 CPM_PCIE0_PF2_MSIX_CAP_TABLE_SIZE 001\
CPM_PCIE1_PF2_MSIX_CAP_TABLE_SIZE 001 CPM_PCIE0_VFG2_MSIX_CAP_TABLE_SIZE 001\
CPM_PCIE1_VFG2_MSIX_CAP_TABLE_SIZE 001 CPM_PCIE0_PF3_MSIX_CAP_TABLE_SIZE 001\
CPM_PCIE1_PF3_MSIX_CAP_TABLE_SIZE 001 CPM_PCIE0_VFG3_MSIX_CAP_TABLE_SIZE 001\
CPM_PCIE1_VFG3_MSIX_CAP_TABLE_SIZE 001 CPM_PCIE0_PF0_MSI_ENABLED 1\
CPM_PCIE1_PF0_MSI_ENABLED 1 CPM_PCIE0_PF1_MSI_ENABLED 1\
CPM_PCIE1_PF1_MSI_ENABLED 1 CPM_PCIE0_PF2_MSI_ENABLED 1\
CPM_PCIE1_PF2_MSI_ENABLED 1 CPM_PCIE0_PF3_MSI_ENABLED 1\
CPM_PCIE1_PF3_MSI_ENABLED 1 CPM_PCIE0_PF0_MSI_CAP_PERVECMASKCAP 0\
CPM_PCIE1_PF0_MSI_CAP_PERVECMASKCAP 0 CPM_PCIE0_PF1_MSI_CAP_PERVECMASKCAP 0\
CPM_PCIE1_PF1_MSI_CAP_PERVECMASKCAP 0 CPM_PCIE0_PF2_MSI_CAP_PERVECMASKCAP 0\
CPM_PCIE1_PF2_MSI_CAP_PERVECMASKCAP 0 CPM_PCIE0_PF3_MSI_CAP_PERVECMASKCAP 0\
CPM_PCIE1_PF3_MSI_CAP_PERVECMASKCAP 0 CPM_PCIE0_PF0_MSI_CAP_MULTIMSGCAP\
1_vector CPM_PCIE1_PF0_MSI_CAP_MULTIMSGCAP 1_vector\
CPM_PCIE0_PF1_MSI_CAP_MULTIMSGCAP 1_vector CPM_PCIE1_PF1_MSI_CAP_MULTIMSGCAP\
1_vector CPM_PCIE0_PF2_MSI_CAP_MULTIMSGCAP 1_vector\
CPM_PCIE1_PF2_MSI_CAP_MULTIMSGCAP 1_vector CPM_PCIE0_PF3_MSI_CAP_MULTIMSGCAP\
1_vector CPM_PCIE1_PF3_MSI_CAP_MULTIMSGCAP 1_vector CPM_PCIE0_PF0_SRIOV_CAP_VER\
1 CPM_PCIE1_PF0_SRIOV_CAP_VER 1 CPM_PCIE0_PF1_SRIOV_CAP_VER 1\
CPM_PCIE1_PF1_SRIOV_CAP_VER 1 CPM_PCIE0_PF2_SRIOV_CAP_VER 1\
CPM_PCIE1_PF2_SRIOV_CAP_VER 1 CPM_PCIE0_PF3_SRIOV_CAP_VER 1\
CPM_PCIE1_PF3_SRIOV_CAP_VER 1 CPM_PCIE0_PF0_PM_CAP_VER_ID 3\
CPM_PCIE1_PF0_PM_CAP_VER_ID 3 CPM_PCIE0_PF0_VC_CAP_VER 1\
CPM_PCIE1_PF0_VC_CAP_VER 1 CPM_PCIE0_PF0_MARGINING_CAP_VER 1\
CPM_PCIE1_PF0_MARGINING_CAP_VER 1 CPM_PCIE0_PF0_DLL_FEATURE_CAP_VER 1\
CPM_PCIE1_PF0_DLL_FEATURE_CAP_VER 1 CPM_PCIE0_PF0_ARI_CAP_VER 1\
CPM_PCIE1_PF0_ARI_CAP_VER 1 CPM_PCIE0_PF0_TPHR_CAP_VER 1\
CPM_PCIE1_PF0_TPHR_CAP_VER 1 CPM_PCIE0_PF0_PL16_CAP_VER 1\
CPM_PCIE1_PF0_PL16_CAP_VER 1 CPM_PCIE0_PF0_PM_CAP_ID 0 CPM_PCIE1_PF0_PM_CAP_ID\
0 CPM_PCIE0_PF0_PL16_CAP_ID 0 CPM_PCIE1_PF0_PL16_CAP_ID 0\
CPM_PCIE0_PF0_MARGINING_CAP_ID 0 CPM_PCIE1_PF0_MARGINING_CAP_ID 0\
CPM_PCIE0_PF0_DLL_FEATURE_CAP_ID 0 CPM_PCIE1_PF0_DLL_FEATURE_CAP_ID 0\
CPM_PCIE0_PF0_TPHR_ENABLE 0 CPM_PCIE1_PF0_TPHR_ENABLE 0\
CPM_PCIE0_PF0_TPHR_CAP_ST_TABLE_SIZE 16 CPM_PCIE1_PF0_TPHR_CAP_ST_TABLE_SIZE 16\
CPM_PCIE0_PF0_TPHR_CAP_ST_TABLE_LOC ST_Table_not_present\
CPM_PCIE1_PF0_TPHR_CAP_ST_TABLE_LOC ST_Table_not_present\
CPM_PCIE0_PF0_TPHR_CAP_INT_VEC_MODE 1 CPM_PCIE1_PF0_TPHR_CAP_INT_VEC_MODE 1\
CPM_PCIE0_PF0_TPHR_CAP_DEV_SPECIFIC_MODE 1\
CPM_PCIE1_PF0_TPHR_CAP_DEV_SPECIFIC_MODE 1 CPM_PCIE0_PF0_ARI_CAP_NEXT_FUNC 0\
CPM_PCIE1_PF0_ARI_CAP_NEXT_FUNC 0 CPM_PCIE0_PF1_ARI_CAP_NEXT_FUNC 0\
CPM_PCIE1_PF1_ARI_CAP_NEXT_FUNC 0 CPM_PCIE0_PF2_ARI_CAP_NEXT_FUNC 0\
CPM_PCIE1_PF2_ARI_CAP_NEXT_FUNC 0 CPM_PCIE0_PF3_ARI_CAP_NEXT_FUNC 0\
CPM_PCIE1_PF3_ARI_CAP_NEXT_FUNC 0 CPM_PCIE0_PF0_PASID_CAP_MAX_PASID_WIDTH 1\
CPM_PCIE1_PF0_PASID_CAP_MAX_PASID_WIDTH 1\
CPM_PCIE0_PF2_PASID_CAP_MAX_PASID_WIDTH 1\
CPM_PCIE1_PF2_PASID_CAP_MAX_PASID_WIDTH 1\
CPM_PCIE0_PF0_AER_CAP_ECRC_GEN_AND_CHECK_CAPABLE 0\
CPM_PCIE1_PF0_AER_CAP_ECRC_GEN_AND_CHECK_CAPABLE 0 CPM_PCIE0_MCAP_ENABLE 0\
CPM_PCIE1_MCAP_ENABLE 0 CPM_PCIE0_PF0_TPHR_CAP_ENABLE 0\
CPM_PCIE1_PF0_TPHR_CAP_ENABLE 0 CPM_PCIE0_SRIOV_CAP_ENABLE 0\
CPM_PCIE1_SRIOV_CAP_ENABLE 0 CPM_PCIE0_AER_CAP_ENABLED 1\
CPM_PCIE1_AER_CAP_ENABLED 0 CPM_PCIE0_ARI_CAP_ENABLED 1\
CPM_PCIE1_ARI_CAP_ENABLED 1 CPM_PCIE0_PF0_VC_CAP_ENABLED 0\
CPM_PCIE1_PF0_VC_CAP_ENABLED 0 CPM_PCIE0_PF0_DSN_CAP_ENABLE 0\
CPM_PCIE1_PF0_DSN_CAP_ENABLE 0 CPM_PCIE0_PF1_DSN_CAP_ENABLE 0\
CPM_PCIE1_PF1_DSN_CAP_ENABLE 0 CPM_PCIE0_PF2_DSN_CAP_ENABLE 0\
CPM_PCIE1_PF2_DSN_CAP_ENABLE 0 CPM_PCIE0_PF3_DSN_CAP_ENABLE 0\
CPM_PCIE1_PF3_DSN_CAP_ENABLE 0 CPM_PCIE0_PF0_SRIOV_CAP_ENABLE 0\
CPM_PCIE1_PF0_SRIOV_CAP_ENABLE 0 CPM_PCIE0_PF1_SRIOV_CAP_ENABLE 0\
CPM_PCIE1_PF1_SRIOV_CAP_ENABLE 0 CPM_PCIE0_PF2_SRIOV_CAP_ENABLE 0\
CPM_PCIE1_PF2_SRIOV_CAP_ENABLE 0 CPM_PCIE0_PF3_SRIOV_CAP_ENABLE 0\
CPM_PCIE1_PF3_SRIOV_CAP_ENABLE 0 CPM_PCIE0_ATS_PRI_CAP_ON 0\
CPM_PCIE1_ATS_PRI_CAP_ON 0 CPM_PCIE0_PF0_ATS_CAP_ON 0 CPM_PCIE1_PF0_ATS_CAP_ON\
0 CPM_PCIE0_VFG0_ATS_CAP_ON 0 CPM_PCIE1_VFG0_ATS_CAP_ON 0\
CPM_PCIE0_PF1_ATS_CAP_ON 0 CPM_PCIE1_PF1_ATS_CAP_ON 0 CPM_PCIE0_VFG1_ATS_CAP_ON\
0 CPM_PCIE1_VFG1_ATS_CAP_ON 0 CPM_PCIE0_PF2_ATS_CAP_ON 0\
CPM_PCIE1_PF2_ATS_CAP_ON 0 CPM_PCIE0_VFG2_ATS_CAP_ON 0\
CPM_PCIE1_VFG2_ATS_CAP_ON 0 CPM_PCIE0_PF3_ATS_CAP_ON 0 CPM_PCIE1_PF3_ATS_CAP_ON\
0 CPM_PCIE0_VFG3_ATS_CAP_ON 0 CPM_PCIE1_VFG3_ATS_CAP_ON 0\
CPM_PCIE0_PF0_PRI_CAP_ON 0 CPM_PCIE1_PF0_PRI_CAP_ON 0 CPM_PCIE0_VFG0_PRI_CAP_ON\
0 CPM_PCIE1_VFG0_PRI_CAP_ON 0 CPM_PCIE0_PF1_PRI_CAP_ON 0\
CPM_PCIE1_PF1_PRI_CAP_ON 0 CPM_PCIE0_VFG1_PRI_CAP_ON 0\
CPM_PCIE1_VFG1_PRI_CAP_ON 0 CPM_PCIE0_PF2_PRI_CAP_ON 0 CPM_PCIE1_PF2_PRI_CAP_ON\
0 CPM_PCIE0_VFG2_PRI_CAP_ON 0 CPM_PCIE1_VFG2_PRI_CAP_ON 0\
CPM_PCIE0_PF3_PRI_CAP_ON 0 CPM_PCIE1_PF3_PRI_CAP_ON 0 CPM_PCIE0_VFG3_PRI_CAP_ON\
0 CPM_PCIE1_VFG3_PRI_CAP_ON 0 CPM_PCIE0_PF0_PL16_CAP_ON 0\
CPM_PCIE1_PF0_PL16_CAP_ON 0 CPM_PCIE0_PF0_DLL_FEATURE_CAP_ON 1\
CPM_PCIE1_PF0_DLL_FEATURE_CAP_ON 0 CPM_PCIE0_PF0_MARGINING_CAP_ON 0\
CPM_PCIE1_PF0_MARGINING_CAP_ON 0 CPM_PCIE0_PF0_PASID_CAP_ON 0\
CPM_PCIE1_PF0_PASID_CAP_ON 0 CPM_PCIE0_AXISTEN_USER_SPARE 0\
CPM_PCIE1_AXISTEN_USER_SPARE 0 CPM_PCIE0_AXISTEN_IF_TX_PARITY_EN 0\
CPM_PCIE1_AXISTEN_IF_TX_PARITY_EN 0 CPM_PCIE0_AXISTEN_IF_RX_PARITY_EN 0\
CPM_PCIE1_AXISTEN_IF_RX_PARITY_EN 0 CPM_PCIE0_AXISTEN_IF_COMPL_TIMEOUT_REG0\
BEBC20 CPM_PCIE1_AXISTEN_IF_COMPL_TIMEOUT_REG0 BEBC20\
CPM_PCIE0_AXISTEN_IF_COMPL_TIMEOUT_REG1 2FAF080\
CPM_PCIE1_AXISTEN_IF_COMPL_TIMEOUT_REG1 2FAF080\
CPM_PCIE0_AXISTEN_IF_ENABLE_RX_TAG_SCALING 0\
CPM_PCIE1_AXISTEN_IF_ENABLE_RX_TAG_SCALING 0\
CPM_PCIE0_AXISTEN_IF_ENABLE_TX_TAG_SCALING 0\
CPM_PCIE1_AXISTEN_IF_ENABLE_TX_TAG_SCALING 0\
CPM_PCIE0_AXISTEN_IF_RQ_ALIGNMENT_MODE DWORD_Aligned\
CPM_PCIE1_AXISTEN_IF_RQ_ALIGNMENT_MODE DWORD_Aligned\
CPM_PCIE0_AXISTEN_IF_RC_ALIGNMENT_MODE DWORD_Aligned\
CPM_PCIE1_AXISTEN_IF_RC_ALIGNMENT_MODE DWORD_Aligned\
CPM_PCIE0_AXISTEN_IF_CQ_ALIGNMENT_MODE DWORD_Aligned\
CPM_PCIE1_AXISTEN_IF_CQ_ALIGNMENT_MODE DWORD_Aligned\
CPM_PCIE0_AXISTEN_IF_CC_ALIGNMENT_MODE DWORD_Aligned\
CPM_PCIE1_AXISTEN_IF_CC_ALIGNMENT_MODE DWORD_Aligned\
CPM_PCIE0_AXISTEN_IF_EXT_512_RQ_STRADDLE 1\
CPM_PCIE1_AXISTEN_IF_EXT_512_RQ_STRADDLE 1\
CPM_PCIE0_AXISTEN_IF_EXT_512_RC_STRADDLE 1\
CPM_PCIE1_AXISTEN_IF_EXT_512_RC_STRADDLE 1\
CPM_PCIE0_AXISTEN_IF_EXT_512_CQ_STRADDLE 0\
CPM_PCIE1_AXISTEN_IF_EXT_512_CQ_STRADDLE 0\
CPM_PCIE0_AXISTEN_IF_EXT_512_CC_STRADDLE 0\
CPM_PCIE1_AXISTEN_IF_EXT_512_CC_STRADDLE 0 CPM_PCIE0_AXISTEN_IF_WIDTH 64\
CPM_PCIE1_AXISTEN_IF_WIDTH 64 CPM_PCIE0_AXISTEN_IF_EXT_512 0\
CPM_PCIE1_AXISTEN_IF_EXT_512 0 CPM_PCIE0_AXISTEN_IF_RC_STRADDLE 0\
CPM_PCIE1_AXISTEN_IF_RC_STRADDLE 0\
CPM_PCIE0_AXISTEN_IF_EXT_512_RC_4TLP_STRADDLE 1\
CPM_PCIE1_AXISTEN_IF_EXT_512_RC_4TLP_STRADDLE 1\
CPM_PCIE0_AXISTEN_IF_ENABLE_256_TAGS 0 CPM_PCIE1_AXISTEN_IF_ENABLE_256_TAGS 0\
CPM_PCIE0_AXISTEN_IF_ENABLE_CLIENT_TAG 0 CPM_PCIE1_AXISTEN_IF_ENABLE_CLIENT_TAG\
0 CPM_PCIE0_AXISTEN_IF_ENABLE_RX_MSG_INTFC 0\
CPM_PCIE1_AXISTEN_IF_ENABLE_RX_MSG_INTFC 0\
CPM_PCIE0_AXISTEN_IF_ENABLE_INTERNAL_MSIX_TABLE 0\
CPM_PCIE1_AXISTEN_IF_ENABLE_INTERNAL_MSIX_TABLE 0\
CPM_PCIE0_AXISTEN_IF_ENABLE_MESSAGE_RID_CHECK 1\
CPM_PCIE1_AXISTEN_IF_ENABLE_MESSAGE_RID_CHECK 1\
CPM_PCIE0_AXISTEN_IF_ENABLE_MSG_ROUTE 0 CPM_PCIE1_AXISTEN_IF_ENABLE_MSG_ROUTE 0\
CPM_PCIE0_AXISTEN_MSIX_VECTORS_PER_FUNCTION 8\
CPM_PCIE1_AXISTEN_MSIX_VECTORS_PER_FUNCTION 8\
CPM_PCIE0_AXISTEN_IF_SIM_SHORT_CPL_TIMEOUT 0\
CPM_PCIE1_AXISTEN_IF_SIM_SHORT_CPL_TIMEOUT 0\
CPM_PCIE0_AXISTEN_IF_EXTEND_CPL_TIMEOUT 16ms_to_1s\
CPM_PCIE1_AXISTEN_IF_EXTEND_CPL_TIMEOUT 16ms_to_1s CPM_PCIE0_DSC_BYPASS_RD 0\
CPM_PCIE1_DSC_BYPASS_RD 0 CPM_PCIE0_DSC_BYPASS_WR 0 CPM_PCIE1_DSC_BYPASS_WR 0\
CPM_PCIE0_QDMA_MULTQ_MAX 2048 CPM_PCIE0_QDMA_PARITY_SETTINGS None\
CPM_PCIE0_DMA_ROOT_PORT 0 CPM_PCIE0_DMA_MSI_RX_PIN_ENABLED FALSE\
CPM_PCIE0_DMA_ENABLE_SECURE 0 CPM_PCIE0_DMA_DATA_WIDTH 256bits\
CPM_PCIE0_DMA_INTF AXI4 CPM_PCIE0_DMA_METERING_ENABLE 1 CPM_PCIE0_DMA_MASK\
256bits CPM_XDMA_TL_PF_VISIBLE 1 CPM_XDMA_2PF_INTERRUPT_ENABLE 0\
CPM_PCIE0_XDMA_DSC_BYPASS_RD 0000 CPM_PCIE0_XDMA_DSC_BYPASS_WR 0000\
CPM_PCIE0_XDMA_AXI_ID_WIDTH 2 CPM_PCIE0_XDMA_PARITY_SETTINGS None\
CPM_PCIE0_XDMA_STS_PORTS 0 CPM_PCIE0_XDMA_RNUM_CHNL 1 CPM_PCIE0_XDMA_WNUM_CHNL\
1 CPM_PCIE0_XDMA_RNUM_RIDS 2 CPM_PCIE0_XDMA_WNUM_RIDS 2 CPM_PCIE0_XDMA_IRQ 1\
CPM_PCIE0_NUM_USR_IRQ 1}\
   CONFIG.PS_PMC_CONFIG {SMON_ALARMS Set_Alarms_On SMON_ENABLE_INT_VOLTAGE_MONITORING 0\
SMON_ENABLE_TEMP_AVERAGING 0 SMON_INTERFACE_TO_USE None\
SMON_INT_MEASUREMENT_ENABLE 0 SMON_INT_MEASUREMENT_MODE 0\
SMON_INT_MEASUREMENT_ALARM_ENABLE 0 SMON_INT_MEASUREMENT_AVG_ENABLE 0\
SMON_INT_MEASUREMENT_TH_HIGH 0 SMON_INT_MEASUREMENT_TH_LOW 0\
SMON_MEASUREMENT_COUNT 86 SMON_MEASUREMENT_LIST\
CUSTOMER__BANK_VOLTAGE:GT_AVAUX-GT_AVAUX_PKG_103,GT_AVAUX_PKG_104,GT_AVAUX_PKG_105,GT_AVAUX_PKG_106,GT_AVAUX_PKG_200,GT_AVAUX_PKG_201,GT_AVAUX_PKG_202,GT_AVAUX_PKG_203,GT_AVAUX_PKG_204,GT_AVAUX_PKG_205,GT_AVAUX_PKG_206#GT_AVCC-GT_AVCC_PKG_103,GT_AVCC_PKG_104,GT_AVCC_PKG_105,GT_AVCC_PKG_106,GT_AVCC_PKG_200,GT_AVCC_PKG_201,GT_AVCC_PKG_202,GT_AVCC_PKG_203,GT_AVCC_PKG_204,GT_AVCC_PKG_205,GT_AVCC_PKG_206#GT_AVTT-GT_AVTT_PKG_103,GT_AVTT_PKG_104,GT_AVTT_PKG_105,GT_AVTT_PKG_106,GT_AVTT_PKG_200,GT_AVTT_PKG_201,GT_AVTT_PKG_202,GT_AVTT_PKG_203,GT_AVTT_PKG_204,GT_AVTT_PKG_205,GT_AVTT_PKG_206#VCC-LPD_MIO_VCC_502,PMC_DIO_VCC_503,PMC_MIO_VCC_500,PMC_MIO_VCC_501,VCC_IO_700,VCC_IO_701,VCC_IO_702,VCC_IO_703,VCC_IO_704,VCC_IO_705,VCC_IO_706,VCC_IO_707,VCC_IO_708,VCC_IO_709,VCC_IO_710,VCC_IO_711,VCC_IO_PKG_306,VCC_IO_PKG_406#VCCAUX-LPD_MIO_VCCAUX_502,PMC_DIO_VCCAUX_503,PMC_MIO_VCCAUX_500,PMC_MIO_VCCAUX_501,VCCAUX_IO_PKG_306,VCCAUX_IO_PKG_406#VCCO-LPD_MIO_VCCO_502,PMC_DIO_VCCO_503,PMC_MIO_VCCO_500,PMC_MIO_VCCO_501,VCCO_700,VCCO_701,VCCO_702,VCCO_703,VCCO_704,VCCO_705,VCCO_706,VCCO_707,VCCO_708,VCCO_709,VCCO_710,VCCO_711,VCCO_PKG_306,VCCO_PKG_406|CUSTOMER__DEDICATED_PAD:VP-VP_VN|CUSTOMER__SUPPLY_VOLTAGE:VCC-VCC_BATT,VCC_PMC,VCC_PSFP,VCC_PSLP,VCC_RAM,VCC_SOC#VCCAUX-VCCAUX,VCCAUX_PMC,VCCAUX_SYSMON#VCCINT-VCCINT_PL\
SMON_OT {{THRESHOLD_LOWER -55} {THRESHOLD_UPPER 125}} SMON_PMBUS_ADDRESS 0x0\
SMON_PMBUS_UNRESTRICTED 0 SMON_REFERENCE_SOURCE Internal\
SMON_TEMP_AVERAGING_SAMPLES 8 SMON_USER_TEMP {{THRESHOLD_LOWER 0}\
{THRESHOLD_UPPER 125} {USER_ALARM_TYPE window}} SMON_VOLTAGE_AVERAGING_SAMPLES\
None PMC_CRP_SYSMON_REF_CTRL_ACT_FREQMHZ 299.997009\
PMC_CRP_SYSMON_REF_CTRL_FREQMHZ 299.997009 PMC_CRP_SYSMON_REF_CTRL_SRCSEL\
NPI_REF_CLK PS_I2CSYSMON_PERIPHERAL {{ENABLE 0} {IO {PS_MIO 23 .. 25}}}\
PS_SMON_PL_PORTS_ENABLE 0 SMON_TEMP_THRESHOLD 0 SMON_VAUX_IO_BANK MIO_BANK0\
PMC_QSPI_PERIPHERAL_ENABLE 1 PMC_QSPI_PERIPHERAL_MODE {Dual Parallel}\
PMC_QSPI_PERIPHERAL_DATA_MODE x4 PMC_CRP_QSPI_REF_CTRL_FREQMHZ 300\
PMC_CRP_QSPI_REF_CTRL_ACT_FREQMHZ 199.998001 PMC_QSPI_FBCLK {{ENABLE 1} {IO\
{PMC_MIO 6}}} PMC_QSPI_COHERENCY 0 PMC_QSPI_ROUTE_THROUGH_FPD 0\
PMC_CRP_QSPI_REF_CTRL_SRCSEL PPLL PMC_CRP_QSPI_REF_CTRL_DIVISOR0 6\
PMC_REF_CLK_FREQMHZ 33.333 PMC_OSPI_PERIPHERAL {{ENABLE 0} {IO {PMC_MIO 0 ..\
11}} {MODE Single}} PMC_CRP_OSPI_REF_CTRL_FREQMHZ 200\
PMC_CRP_OSPI_REF_CTRL_ACT_FREQMHZ 200 PMC_OSPI_COHERENCY 0\
PMC_OSPI_ROUTE_THROUGH_FPD 0 PMC_CRP_OSPI_REF_CTRL_SRCSEL PPLL\
PMC_CRP_OSPI_REF_CTRL_DIVISOR0 4 PMC_SD0_PERIPHERAL {{ENABLE 0} {IO {PMC_MIO 13\
.. 25}}} PMC_SD0_SLOT_TYPE {SD 2.0} PMC_SD0_COHERENCY 0\
PMC_SD0_ROUTE_THROUGH_FPD 0 PMC_SD0_DATA_TRANSFER_MODE 4Bit PMC_SD0_SPEED_MODE\
{default speed} PMC_CRP_SDIO0_REF_CTRL_FREQMHZ 200\
PMC_CRP_SDIO0_REF_CTRL_ACT_FREQMHZ 200 PMC_CRP_SDIO0_REF_CTRL_SRCSEL PPLL\
PMC_CRP_SDIO0_REF_CTRL_DIVISOR0 6 PMC_SD1_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO\
26 .. 36}}} PMC_SD1_SLOT_TYPE {SD 3.0} PMC_SD1_COHERENCY 0\
PMC_SD1_ROUTE_THROUGH_FPD 0 PMC_SD1_DATA_TRANSFER_MODE 8Bit PMC_SD1_SPEED_MODE\
{high speed} PMC_CRP_SDIO1_REF_CTRL_FREQMHZ 200\
PMC_CRP_SDIO1_REF_CTRL_ACT_FREQMHZ 199.998001 PMC_CRP_SDIO1_REF_CTRL_SRCSEL\
PPLL PS_CRL_CPM_TOPSW_REF_CTRL_FREQMHZ 480\
PS_CRL_CPM_TOPSW_REF_CTRL_ACT_FREQMHZ 474.995239\
PS_CRL_CPM_TOPSW_REF_CTRL_SRCSEL NPLL PS_CRL_CPM_TOPSW_REF_CTRL_DIVISOR0 2\
PMC_CRP_SDIO1_REF_CTRL_DIVISOR0 6 PMC_SMAP_PERIPHERAL {{ENABLE 0} {IO {32\
Bit}}} BOOT_SECONDARY_PCIE_ENABLE 0 USE_UART0_IN_DEVICE_BOOT 0 PMC_SD0\
{{CD_ENABLE 0} {CD_IO {PMC_MIO 24}} {POW_ENABLE 0} {POW_IO {PMC_MIO 17}}\
{RESET_ENABLE 0} {RESET_IO {PMC_MIO 17}} {WP_ENABLE 0} {WP_IO {PMC_MIO 25}}}\
PMC_SD1 {{CD_ENABLE 1} {CD_IO {PMC_MIO 28}} {POW_ENABLE 1} {POW_IO {PMC_MIO\
51}} {RESET_ENABLE 0} {RESET_IO {PMC_MIO 1}} {WP_ENABLE 0} {WP_IO {PMC_MIO 1}}}\
PS_USB3_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 13 .. 25}}} PMC_I2CPMC_PERIPHERAL\
{{ENABLE 0} {IO {PMC_MIO 2 .. 3}}} PS_SPI0 {{GRP_SS0_ENABLE 0} {GRP_SS0_IO\
{PMC_MIO 15}} {GRP_SS1_ENABLE 0} {GRP_SS1_IO {PMC_MIO 14}} {GRP_SS2_ENABLE 0}\
{GRP_SS2_IO {PMC_MIO 13}} {PERIPHERAL_ENABLE 0} {PERIPHERAL_IO {PMC_MIO 12 ..\
17}}} PS_SPI1 {{GRP_SS0_ENABLE 0} {GRP_SS0_IO {PS_MIO 9}} {GRP_SS1_ENABLE 0}\
{GRP_SS1_IO {PS_MIO 8}} {GRP_SS2_ENABLE 0} {GRP_SS2_IO {PS_MIO 7}}\
{PERIPHERAL_ENABLE 0} {PERIPHERAL_IO {PS_MIO 6 .. 11}}} PMC_EXTERNAL_TAMPER\
{{ENABLE 0} {IO NONE}} PMC_TAMPER_EXTMIO_ENABLE 0 PMC_TAMPER_EXTMIO_ERASE_BBRAM\
0 PMC_TAMPER_EXTMIO_RESPONSE {SYS INTERRUPT} PMC_TAMPER_GLITCHDETECT_ENABLE 0\
PMC_TAMPER_GLITCHDETECT_ERASE_BBRAM 0 PMC_TAMPER_GLITCHDETECT_RESPONSE {SYS\
INTERRUPT} PMC_TAMPER_JTAGDETECT_ENABLE 0 PMC_TAMPER_JTAGDETECT_ERASE_BBRAM 0\
PMC_TAMPER_JTAGDETECT_RESPONSE {SYS INTERRUPT} PMC_TAMPER_TEMPERATURE_ENABLE 0\
PMC_TAMPER_TEMPERATURE_ERASE_BBRAM 0 PMC_TAMPER_TEMPERATURE_RESPONSE {SYS\
INTERRUPT} PMC_TAMPER_TRIGGER_REGISTER 0 PMC_TAMPER_TRIGGER_ERASE_BBRAM 0\
PMC_TAMPER_TRIGGER_RESPONSE {SYS INTERRUPT} PS_LPD_DMA_CHANNEL_ENABLE {{CH0 0}\
{CH1 0} {CH2 0} {CH3 0} {CH4 0} {CH5 0} {CH6 0} {CH7 0}}\
PS_M_AXI_FPD_DATA_WIDTH 32 PS_M_AXI_LPD_DATA_WIDTH 32 PS_NUM_FABRIC_RESETS 1\
PS_S_AXI_FPD_DATA_WIDTH 128 PS_S_AXI_GP2_DATA_WIDTH 128 PS_USE_ENET0_PTP 0\
PS_USE_ENET1_PTP 0 PS_USE_FIFO_ENET0 0 PS_USE_FIFO_ENET1 0 PS_USE_M_AXI_FPD 1\
PS_USE_M_AXI_LPD 1 PS_USE_S_AXI_ACE 0 PS_USE_S_ACP_FPD 0 PS_USE_S_AXI_FPD 0\
PS_USE_S_AXI_GP2 0 PS_USE_S_AXI_LPD 0 PS_GEN_IPI0_ENABLE 1 PS_GEN_IPI1_ENABLE 1\
PS_GEN_IPI2_ENABLE 1 PS_GEN_IPI3_ENABLE 1 PS_GEN_IPI4_ENABLE 1\
PS_GEN_IPI5_ENABLE 1 PS_GEN_IPI6_ENABLE 1 PS_GEN_IPI_PMCNOBUF_ENABLE 1\
PS_GEN_IPI_PMC_ENABLE 1 PS_GEN_IPI_PSM_ENABLE 1 PS_GEN_IPI0_MASTER A72\
PS_GEN_IPI1_MASTER R5_0 PS_GEN_IPI2_MASTER R5_1 PS_GEN_IPI3_MASTER A72\
PS_GEN_IPI4_MASTER A72 PS_GEN_IPI5_MASTER A72 PS_GEN_IPI6_MASTER A72\
PS_GEN_IPI_PMCNOBUF_MASTER PMC PS_GEN_IPI_PMC_MASTER PMC PS_GEN_IPI_PSM_MASTER\
PSM PS_USE_APU_INTERRUPT 0 PS_USE_FTM_GPI 0 PS_IRQ_USAGE {{CH0 1} {CH1 1} {CH10\
0} {CH11 0} {CH12 0} {CH13 0} {CH14 0} {CH15 0} {CH2 1} {CH3 1} {CH4 1} {CH5 1}\
{CH6 1} {CH7 1} {CH8 0} {CH9 0}} PS_USE_APU_EVENT_BUS 0 PS_USE_PSPL_IRQ_FPD 0\
PS_USE_PSPL_IRQ_LPD 0 PS_USE_PSPL_IRQ_PMC 0 PS_USE_RPU_EVENT 0\
PS_USE_RPU_INTERRUPT 0 PMC_USE_NOC_PMC_AXI0 0 PMC_USE_PMC_NOC_AXI0 1\
PS_USE_NOC_FPD_CCI0 0 PS_USE_NOC_FPD_CCI1 0 PS_USE_NOC_FPD_AXI0 0\
PS_USE_NOC_FPD_AXI1 0 PS_USE_FPD_CCI_NOC 1 PS_USE_FPD_CCI_NOC0 0\
PS_USE_FPD_CCI_NOC1 0 PS_USE_FPD_CCI_NOC2 0 PS_USE_FPD_CCI_NOC3 0\
PS_USE_FPD_AXI_NOC0 1 PS_USE_FPD_AXI_NOC1 1 PS_USE_NOC_LPD_AXI0 1\
AURORA_LINE_RATE_GPBS 10.0 DIS_AUTO_POL_CHECK 0 GT_REFCLK_MHZ 156.25\
INIT_CLK_MHZ 125 INV_POLARITY 0 PS_FTM_CTI_IN0 0 PS_FTM_CTI_IN1 0\
PS_FTM_CTI_IN2 0 PS_FTM_CTI_IN3 0 PS_FTM_CTI_OUT0 0 PS_FTM_CTI_OUT1 0\
PS_FTM_CTI_OUT2 0 PS_FTM_CTI_OUT3 0 PS_HSDP0_REFCLK 0 PS_HSDP1_REFCLK 0\
PS_HSDP_EGRESS_TRAFFIC JTAG PS_HSDP_INGRESS_TRAFFIC JTAG PS_HSDP_MODE NONE\
PS_TRACE_PERIPHERAL {{ENABLE 0} {IO {PMC_MIO 30 .. 47}}} PS_TRACE_WIDTH 32Bit\
PS_USE_BSCAN_USER1 0 PS_USE_BSCAN_USER2 0 PS_USE_BSCAN_USER3 0\
PS_USE_BSCAN_USER4 0 PS_USE_CAPTURE 0 PS_USE_STM 0 PS_USE_TRACE_ATB 0\
PMC_CRP_CFU_REF_CTRL_ACT_FREQMHZ 299.997009 PMC_CRP_CFU_REF_CTRL_DIVISOR0 4\
PMC_CRP_CFU_REF_CTRL_FREQMHZ 300 PMC_CRP_CFU_REF_CTRL_SRCSEL PPLL\
PMC_CRP_DFT_OSC_REF_CTRL_ACT_FREQMHZ 400 PMC_CRP_DFT_OSC_REF_CTRL_DIVISOR0 3\
PMC_CRP_DFT_OSC_REF_CTRL_FREQMHZ 400 PMC_CRP_DFT_OSC_REF_CTRL_SRCSEL PPLL\
PMC_CRP_EFUSE_REF_CTRL_ACT_FREQMHZ 100.000000 PMC_CRP_EFUSE_REF_CTRL_FREQMHZ\
100.000000 PMC_CRP_EFUSE_REF_CTRL_SRCSEL IRO_CLK/4\
PMC_CRP_HSM0_REF_CTRL_ACT_FREQMHZ 33.333000 PMC_CRP_HSM0_REF_CTRL_DIVISOR0 36\
PMC_CRP_HSM0_REF_CTRL_FREQMHZ 33.333 PMC_CRP_HSM0_REF_CTRL_SRCSEL PPLL\
PMC_CRP_HSM1_REF_CTRL_ACT_FREQMHZ 133.332001 PMC_CRP_HSM1_REF_CTRL_DIVISOR0 9\
PMC_CRP_HSM1_REF_CTRL_FREQMHZ 133.333 PMC_CRP_HSM1_REF_CTRL_SRCSEL PPLL\
PMC_CRP_I2C_REF_CTRL_ACT_FREQMHZ 100 PMC_CRP_I2C_REF_CTRL_DIVISOR0 12\
PMC_CRP_I2C_REF_CTRL_FREQMHZ 100 PMC_CRP_I2C_REF_CTRL_SRCSEL PPLL\
PMC_CRP_LSBUS_REF_CTRL_ACT_FREQMHZ 99.999001 PMC_CRP_LSBUS_REF_CTRL_DIVISOR0 12\
PMC_CRP_LSBUS_REF_CTRL_FREQMHZ 100 PMC_CRP_LSBUS_REF_CTRL_SRCSEL PPLL\
PMC_CRP_NPI_REF_CTRL_ACT_FREQMHZ 299.997009 PMC_CRP_NPI_REF_CTRL_DIVISOR0 4\
PMC_CRP_NPI_REF_CTRL_FREQMHZ 300 PMC_CRP_NPI_REF_CTRL_SRCSEL PPLL\
PMC_CRP_NPLL_CTRL_CLKOUTDIV 4 PMC_CRP_NPLL_CTRL_FBDIV 114\
PMC_CRP_NPLL_CTRL_SRCSEL REF_CLK PMC_CRP_NPLL_TO_XPD_CTRL_DIVISOR0 1\
PMC_CRP_PL0_REF_CTRL_ACT_FREQMHZ 99.999001 PMC_CRP_PL0_REF_CTRL_DIVISOR0 12\
PMC_CRP_PL0_REF_CTRL_FREQMHZ 240 PMC_CRP_PL0_REF_CTRL_SRCSEL PPLL\
PMC_CRP_PL1_REF_CTRL_ACT_FREQMHZ 100 PMC_CRP_PL1_REF_CTRL_DIVISOR0 3\
PMC_CRP_PL1_REF_CTRL_FREQMHZ 334 PMC_CRP_PL1_REF_CTRL_SRCSEL NPLL\
PMC_CRP_PL2_REF_CTRL_ACT_FREQMHZ 100 PMC_CRP_PL2_REF_CTRL_DIVISOR0 3\
PMC_CRP_PL2_REF_CTRL_FREQMHZ 334 PMC_CRP_PL2_REF_CTRL_SRCSEL NPLL\
PMC_CRP_PL3_REF_CTRL_ACT_FREQMHZ 100 PMC_CRP_PL3_REF_CTRL_DIVISOR0 3\
PMC_CRP_PL3_REF_CTRL_FREQMHZ 334 PMC_CRP_PL3_REF_CTRL_SRCSEL NPLL\
PMC_CRP_PPLL_CTRL_CLKOUTDIV 2 PMC_CRP_PPLL_CTRL_FBDIV 72\
PMC_CRP_PPLL_CTRL_SRCSEL REF_CLK PMC_CRP_PPLL_TO_XPD_CTRL_DIVISOR0 2\
PMC_CRP_SD_DLL_REF_CTRL_ACT_FREQMHZ 1199.988037\
PMC_CRP_SD_DLL_REF_CTRL_DIVISOR0 1 PMC_CRP_SD_DLL_REF_CTRL_FREQMHZ 1200\
PMC_CRP_SD_DLL_REF_CTRL_SRCSEL PPLL PMC_CRP_SWITCH_TIMEOUT_CTRL_ACT_FREQMHZ\
1.000000 PMC_CRP_SWITCH_TIMEOUT_CTRL_DIVISOR0 100\
PMC_CRP_SWITCH_TIMEOUT_CTRL_FREQMHZ 1 PMC_CRP_SWITCH_TIMEOUT_CTRL_SRCSEL\
IRO_CLK/4 PMC_CRP_TEST_PATTERN_REF_CTRL_ACT_FREQMHZ 200\
PMC_CRP_TEST_PATTERN_REF_CTRL_DIVISOR0 6 PMC_CRP_TEST_PATTERN_REF_CTRL_FREQMHZ\
200 PMC_CRP_TEST_PATTERN_REF_CTRL_SRCSEL PPLL\
PMC_CRP_USB_SUSPEND_CTRL_ACT_FREQMHZ 0.200000 PMC_CRP_USB_SUSPEND_CTRL_DIVISOR0\
500 PMC_CRP_USB_SUSPEND_CTRL_FREQMHZ 0.2 PMC_CRP_USB_SUSPEND_CTRL_SRCSEL\
IRO_CLK/4 PSPMC_MANUAL_CLK_ENABLE 1 PS_CRF_ACPU_CTRL_ACT_FREQMHZ 999.989990\
PS_CRF_ACPU_CTRL_DIVISOR0 1 PS_CRF_ACPU_CTRL_FREQMHZ 1000\
PS_CRF_ACPU_CTRL_SRCSEL APLL PS_CRF_APLL_CTRL_CLKOUTDIV 4\
PS_CRF_APLL_CTRL_FBDIV 120 PS_CRF_APLL_CTRL_SRCSEL REF_CLK\
PS_CRF_APLL_TO_XPD_CTRL_DIVISOR0 2 PS_CRF_DBG_FPD_CTRL_ACT_FREQMHZ 299.997009\
PS_CRF_DBG_FPD_CTRL_DIVISOR0 2 PS_CRF_DBG_FPD_CTRL_FREQMHZ 300\
PS_CRF_DBG_FPD_CTRL_SRCSEL PPLL PS_CRF_DBG_TRACE_CTRL_ACT_FREQMHZ 300\
PS_CRF_DBG_TRACE_CTRL_DIVISOR0 3 PS_CRF_DBG_TRACE_CTRL_FREQMHZ 300\
PS_CRF_DBG_TRACE_CTRL_SRCSEL PPLL PS_CRF_FPD_LSBUS_CTRL_ACT_FREQMHZ 99.999001\
PS_CRF_FPD_LSBUS_CTRL_DIVISOR0 6 PS_CRF_FPD_LSBUS_CTRL_FREQMHZ 100\
PS_CRF_FPD_LSBUS_CTRL_SRCSEL PPLL PS_CRF_FPD_TOP_SWITCH_CTRL_ACT_FREQMHZ\
499.994995 PS_CRF_FPD_TOP_SWITCH_CTRL_DIVISOR0 2\
PS_CRF_FPD_TOP_SWITCH_CTRL_FREQMHZ 500 PS_CRF_FPD_TOP_SWITCH_CTRL_SRCSEL APLL\
PS_CRL_CAN0_REF_CTRL_ACT_FREQMHZ 100 PS_CRL_CAN0_REF_CTRL_DIVISOR0 12\
PS_CRL_CAN0_REF_CTRL_FREQMHZ 100 PS_CRL_CAN0_REF_CTRL_SRCSEL PPLL\
PS_CRL_CAN1_REF_CTRL_ACT_FREQMHZ 149.998505 PS_CRL_CAN1_REF_CTRL_DIVISOR0 4\
PS_CRL_CAN1_REF_CTRL_FREQMHZ 160 PS_CRL_CAN1_REF_CTRL_SRCSEL PPLL\
PS_CRL_CPU_R5_CTRL_ACT_FREQMHZ 374.996246 PS_CRL_CPU_R5_CTRL_DIVISOR0 2\
PS_CRL_CPU_R5_CTRL_FREQMHZ 375 PS_CRL_CPU_R5_CTRL_SRCSEL RPLL\
PS_CRL_DBG_LPD_CTRL_ACT_FREQMHZ 299.997009 PS_CRL_DBG_LPD_CTRL_DIVISOR0 2\
PS_CRL_DBG_LPD_CTRL_FREQMHZ 300 PS_CRL_DBG_LPD_CTRL_SRCSEL PPLL\
PS_CRL_DBG_TSTMP_CTRL_ACT_FREQMHZ 299.997009 PS_CRL_DBG_TSTMP_CTRL_DIVISOR0 2\
PS_CRL_DBG_TSTMP_CTRL_FREQMHZ 300 PS_CRL_DBG_TSTMP_CTRL_SRCSEL PPLL\
PS_CRL_GEM0_REF_CTRL_ACT_FREQMHZ 124.998749 PS_CRL_GEM0_REF_CTRL_DIVISOR0 6\
PS_CRL_GEM0_REF_CTRL_FREQMHZ 125 PS_CRL_GEM0_REF_CTRL_SRCSEL RPLL\
PS_CRL_GEM1_REF_CTRL_ACT_FREQMHZ 124.998749 PS_CRL_GEM1_REF_CTRL_DIVISOR0 6\
PS_CRL_GEM1_REF_CTRL_FREQMHZ 125 PS_CRL_GEM1_REF_CTRL_SRCSEL RPLL\
PS_CRL_GEM_TSU_REF_CTRL_ACT_FREQMHZ 249.997498 PS_CRL_GEM_TSU_REF_CTRL_DIVISOR0\
3 PS_CRL_GEM_TSU_REF_CTRL_FREQMHZ 250 PS_CRL_GEM_TSU_REF_CTRL_SRCSEL RPLL\
PS_CRL_I2C0_REF_CTRL_ACT_FREQMHZ 99.999001 PS_CRL_I2C0_REF_CTRL_DIVISOR0 6\
PS_CRL_I2C0_REF_CTRL_FREQMHZ 100 PS_CRL_I2C0_REF_CTRL_SRCSEL PPLL\
PS_CRL_I2C1_REF_CTRL_ACT_FREQMHZ 99.999001 PS_CRL_I2C1_REF_CTRL_DIVISOR0 6\
PS_CRL_I2C1_REF_CTRL_FREQMHZ 100 PS_CRL_I2C1_REF_CTRL_SRCSEL PPLL\
PS_CRL_IOU_SWITCH_CTRL_ACT_FREQMHZ 249.997498 PS_CRL_IOU_SWITCH_CTRL_DIVISOR0 3\
PS_CRL_IOU_SWITCH_CTRL_FREQMHZ 250 PS_CRL_IOU_SWITCH_CTRL_SRCSEL RPLL\
PS_CRL_LPD_LSBUS_CTRL_ACT_FREQMHZ 99.999001 PS_CRL_LPD_LSBUS_CTRL_DIVISOR0 6\
PS_CRL_LPD_LSBUS_CTRL_FREQMHZ 100 PS_CRL_LPD_LSBUS_CTRL_SRCSEL PPLL\
PS_CRL_LPD_TOP_SWITCH_CTRL_ACT_FREQMHZ 374.996246\
PS_CRL_LPD_TOP_SWITCH_CTRL_DIVISOR0 2 PS_CRL_LPD_TOP_SWITCH_CTRL_FREQMHZ 375\
PS_CRL_LPD_TOP_SWITCH_CTRL_SRCSEL RPLL PS_CRL_PSM_REF_CTRL_ACT_FREQMHZ\
299.997009 PS_CRL_PSM_REF_CTRL_DIVISOR0 2 PS_CRL_PSM_REF_CTRL_FREQMHZ 300\
PS_CRL_PSM_REF_CTRL_SRCSEL PPLL PS_CRL_RPLL_CTRL_CLKOUTDIV 4\
PS_CRL_RPLL_CTRL_FBDIV 90 PS_CRL_RPLL_CTRL_SRCSEL REF_CLK\
PS_CRL_RPLL_TO_XPD_CTRL_DIVISOR0 3 PS_CRL_SPI0_REF_CTRL_ACT_FREQMHZ 200\
PS_CRL_SPI0_REF_CTRL_DIVISOR0 6 PS_CRL_SPI0_REF_CTRL_FREQMHZ 200\
PS_CRL_SPI0_REF_CTRL_SRCSEL PPLL PS_CRL_SPI1_REF_CTRL_ACT_FREQMHZ 200\
PS_CRL_SPI1_REF_CTRL_DIVISOR0 6 PS_CRL_SPI1_REF_CTRL_FREQMHZ 200\
PS_CRL_SPI1_REF_CTRL_SRCSEL PPLL PS_CRL_TIMESTAMP_REF_CTRL_ACT_FREQMHZ\
99.999001 PS_CRL_TIMESTAMP_REF_CTRL_DIVISOR0 6\
PS_CRL_TIMESTAMP_REF_CTRL_FREQMHZ 100 PS_CRL_TIMESTAMP_REF_CTRL_SRCSEL PPLL\
PS_CRL_UART0_REF_CTRL_ACT_FREQMHZ 99.999001 PS_CRL_UART0_REF_CTRL_DIVISOR0 6\
PS_CRL_UART0_REF_CTRL_FREQMHZ 100 PS_CRL_UART0_REF_CTRL_SRCSEL PPLL\
PS_CRL_UART1_REF_CTRL_ACT_FREQMHZ 100 PS_CRL_UART1_REF_CTRL_DIVISOR0 12\
PS_CRL_UART1_REF_CTRL_FREQMHZ 100 PS_CRL_UART1_REF_CTRL_SRCSEL PPLL\
PS_CRL_USB0_BUS_REF_CTRL_ACT_FREQMHZ 19.999800\
PS_CRL_USB0_BUS_REF_CTRL_DIVISOR0 30 PS_CRL_USB0_BUS_REF_CTRL_FREQMHZ 60\
PS_CRL_USB0_BUS_REF_CTRL_SRCSEL PPLL PS_CRL_USB3_DUAL_REF_CTRL_ACT_FREQMHZ 100\
PS_CRL_USB3_DUAL_REF_CTRL_DIVISOR0 100 PS_CRL_USB3_DUAL_REF_CTRL_FREQMHZ 100\
PS_CRL_USB3_DUAL_REF_CTRL_SRCSEL PPLL PS_TTC0_REF_CTRL_ACT_FREQMHZ 99.999001\
PS_TTC0_REF_CTRL_FREQMHZ 99.999001 PS_TTC1_REF_CTRL_ACT_FREQMHZ 99.999001\
PS_TTC1_REF_CTRL_FREQMHZ 99.999001 PS_TTC2_REF_CTRL_ACT_FREQMHZ 99.999001\
PS_TTC2_REF_CTRL_FREQMHZ 99.999001 PS_TTC3_REF_CTRL_ACT_FREQMHZ 99.999001\
PS_TTC3_REF_CTRL_FREQMHZ 99.999001 PS_TTC_APB_CLK_TTC0_SEL APB\
PS_TTC_APB_CLK_TTC1_SEL APB PS_TTC_APB_CLK_TTC2_SEL APB PS_TTC_APB_CLK_TTC3_SEL\
APB Component_Name vmk180_trd_platform1_CIPS_0_0 PMC_ALT_REF_CLK_FREQMHZ 33.333\
PMC_BANK_0_IO_STANDARD LVCMOS1.8 PMC_BANK_1_IO_STANDARD LVCMOS1.8 PMC_CIPS_MODE\
ADVANCE PMC_CRP_NOC_REF_CTRL_ACT_FREQMHZ 949.990479\
PMC_CRP_NOC_REF_CTRL_FREQMHZ 960 PMC_CRP_NOC_REF_CTRL_SRCSEL NPLL\
PMC_CRP_PL5_REF_CTRL_FREQMHZ 320 PMC_GPIO0_MIO_PERIPHERAL {{ENABLE 1} {IO\
{PMC_MIO 0 .. 25}}} PMC_GPIO1_MIO_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 26 ..\
51}}} PMC_GPIO_EMIO_PERIPHERAL_ENABLE 0 PMC_GPIO_EMIO_WIDTH 64\
PMC_GPIO_EMIO_WIDTH_HDL 64 PMC_HSM0_CLK_ENABLE 1 PMC_HSM1_CLK_ENABLE 1\
PMC_MIO_EN_FOR_PL_PCIE 0 PMC_MIO_TREE_PERIPHERALS\
{QSPI#QSPI#QSPI#QSPI#QSPI#QSPI#Loopback Clk#QSPI#QSPI#QSPI#QSPI#QSPI#QSPI#USB\
0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB\
0#SD1/eMMC1#SD1/eMMC1#SD1#SD1/eMMC1#SD1/eMMC1#SD1/eMMC1#SD1/eMMC1#SD1/eMMC1#SD1/eMMC1#SD1/eMMC1#SD1/eMMC1#GPIO\
1###CAN 1#CAN 1#UART 0#UART 0#I2C 1#I2C 1#I2C 0#I2C 0#GPIO 1#GPIO\
1##SD1/eMMC1#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet\
0#Enet 0#Enet 0#Enet 0#Enet 1#Enet 1#Enet 1#Enet 1#Enet 1#Enet 1#Enet 1#Enet\
1#Enet 1#Enet 1#Enet 1#Enet 1#Enet 0#Enet 0} PMC_MIO_TREE_SIGNALS\
qspi0_clk#qspi0_io[1]#qspi0_io[2]#qspi0_io[3]#qspi0_io[0]#qspi0_cs_b#qspi_lpbk#qspi1_cs_b#qspi1_io[0]#qspi1_io[1]#qspi1_io[2]#qspi1_io[3]#qspi1_clk#usb2phy_reset#ulpi_tx_data[0]#ulpi_tx_data[1]#ulpi_tx_data[2]#ulpi_tx_data[3]#ulpi_clk#ulpi_tx_data[4]#ulpi_tx_data[5]#ulpi_tx_data[6]#ulpi_tx_data[7]#ulpi_dir#ulpi_stp#ulpi_nxt#clk#dir1/data[7]#detect#cmd#data[0]#data[1]#data[2]#data[3]#sel/data[4]#dir_cmd/data[5]#dir0/data[6]#gpio_1_pin[37]###phy_tx#phy_rx#rxd#txd#scl#sda#scl#sda#gpio_1_pin[48]#gpio_1_pin[49]##buspwr/rst#rgmii_tx_clk#rgmii_txd[0]#rgmii_txd[1]#rgmii_txd[2]#rgmii_txd[3]#rgmii_tx_ctl#rgmii_rx_clk#rgmii_rxd[0]#rgmii_rxd[1]#rgmii_rxd[2]#rgmii_rxd[3]#rgmii_rx_ctl#rgmii_tx_clk#rgmii_txd[0]#rgmii_txd[1]#rgmii_txd[2]#rgmii_txd[3]#rgmii_tx_ctl#rgmii_rx_clk#rgmii_rxd[0]#rgmii_rxd[1]#rgmii_rxd[2]#rgmii_rxd[3]#rgmii_rx_ctl#gem0_mdc#gem0_mdio\
PMC_PL_ALT_REF_CLK_FREQMHZ 33.333 PMC_SHOW_CCI_SMMU_SETTINGS 0 PMC_USE_CFU_SEU\
0 PMC_USE_PL_PMC_AUX_REF_CLK 0 PS_LPD_DMA_CH_TZ {{CH0 NonSecure} {CH1\
NonSecure} {CH2 NonSecure} {CH3 NonSecure} {CH4 NonSecure} {CH5 NonSecure} {CH6\
NonSecure} {CH7 NonSecure}} PS_LPD_DMA_ENABLE 0 PS_BANK_2_IO_STANDARD LVCMOS1.8\
PS_BANK_3_IO_STANDARD LVCMOS1.8 PS_CAN0_CLK {{ENABLE 0} {IO {PMC_MIO 0}}}\
PS_CAN0_PERIPHERAL {{ENABLE 0} {IO {PMC_MIO 8 .. 9}}} PS_CAN1_CLK {{ENABLE 0}\
{IO {PMC_MIO 0}}} PS_CAN1_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 40 .. 41}}}\
PS_DDRC_ENABLE 1 PS_DDR_RAM_HIGHADDR_OFFSET 34359738368\
PS_DDR_RAM_LOWADDR_OFFSET 2147483648 PS_ENABLE_HSDP 0 PS_ENET0_MDIO {{ENABLE 1}\
{IO {PS_MIO 24 .. 25}}} PS_ENET0_PERIPHERAL {{ENABLE 1} {IO {PS_MIO 0 .. 11}}}\
PS_ENET1_MDIO {{ENABLE 0} {IO {PMC_MIO 50 .. 51}}} PS_ENET1_PERIPHERAL {{ENABLE\
1} {IO {PS_MIO 12 .. 23}}} PS_EN_AXI_STATUS_PORTS 0\
PS_EN_PORTS_CONTROLLER_BASED 0 PS_EXPAND_CORESIGHT 0 PS_EXPAND_FPD_SLAVES 0\
PS_EXPAND_GIC 0 PS_EXPAND_LPD_SLAVES 0 PS_GEM0_COHERENCY 0\
PS_GEM0_ROUTE_THROUGH_FPD 1 PS_GEM1_COHERENCY 0 PS_GEM1_ROUTE_THROUGH_FPD 1\
PS_GEM_TSU_CLK_PORT_PAIR 0 PS_GEM_TSU {{ENABLE 0} {IO {PS_MIO 24}}}\
PS_GPIO2_MIO_PERIPHERAL {{ENABLE 1} {IO {PS_MIO 0 .. 25}}}\
PS_GPIO_EMIO_PERIPHERAL_ENABLE 1 PS_GPIO_EMIO_WIDTH 32\
PS_HSDP_SAME_EGRESS_AS_INGRESS_TRAFFIC 1 PS_HSDP_SAME_INGRESS_EGRESS_TRAFFIC\
JTAG PS_I2C0_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 46 .. 47}}} PS_I2C1_PERIPHERAL\
{{ENABLE 1} {IO {PMC_MIO 44 .. 45}}} PS_LPDMA0_COHERENCY 0\
PS_LPDMA0_ROUTE_THROUGH_FPD 0 PS_LPDMA1_COHERENCY 0 PS_LPDMA1_ROUTE_THROUGH_FPD\
0 PS_LPDMA2_COHERENCY 0 PS_LPDMA2_ROUTE_THROUGH_FPD 0 PS_LPDMA3_COHERENCY 0\
PS_LPDMA3_ROUTE_THROUGH_FPD 0 PS_LPDMA4_COHERENCY 0 PS_LPDMA4_ROUTE_THROUGH_FPD\
0 PS_LPDMA5_COHERENCY 0 PS_LPDMA5_ROUTE_THROUGH_FPD 0 PS_LPDMA6_COHERENCY 0\
PS_LPDMA6_ROUTE_THROUGH_FPD 0 PS_LPDMA7_COHERENCY 0 PS_LPDMA7_ROUTE_THROUGH_FPD\
0 PS_M_AXI_GP4_DATA_WIDTH 128 PS_NOC_PS_CCI_DATA_WIDTH 128\
PS_NOC_PS_NCI_DATA_WIDTH 128 PS_NOC_PS_PCI_DATA_WIDTH 128\
PS_NOC_PS_PMC_DATA_WIDTH 128 PS_NUM_F2P0_INTR_INPUTS 1 PS_NUM_F2P1_INTR_INPUTS\
1 PS_PCIE_EP_RESET1_IO None PS_PCIE_EP_RESET2_IO None\
PS_PCIE1_PERIPHERAL_ENABLE 0 PS_PCIE2_PERIPHERAL_ENABLE 0\
PS_PCIE_PERIPHERAL_ENABLE 0 PS_PCIE_RESET {{ENABLE 0} {IO {PS_MIO 18 .. 19}}}\
PS_PCIE_ROOT_RESET1_IO None PS_PCIE_ROOT_RESET1_POLARITY {Active Low}\
PS_PCIE_ROOT_RESET2_IO None PS_PCIE_ROOT_RESET2_POLARITY {Active Low}\
PS_PL_DONE 0 PS_PMCPL_CLK0_BUF 1 PS_PMCPL_CLK1_BUF 1 PS_PMCPL_CLK2_BUF 1\
PS_PMCPL_CLK3_BUF 1 PS_PMCPL_IRO_CLK_BUF 1 PS_PMU_PERIPHERAL_ENABLE 0\
PS_PS_ENABLE 0 PS_PS_NOC_CCI_DATA_WIDTH 128 PS_PS_NOC_NCI_DATA_WIDTH 128\
PS_PS_NOC_PCI_DATA_WIDTH 128 PS_PS_NOC_PMC_DATA_WIDTH 128\
PS_PS_NOC_RPU_DATA_WIDTH 128 PS_RPU_COHERENCY 0 PS_SLR_TYPE master\
PS_S_AXI_ACE_DATA_WIDTH 128 PS_S_AXI_ACP_DATA_WIDTH 128 PS_S_AXI_LPD_DATA_WIDTH\
128 PS_TRISTATE_INVERTED 0 PS_TTC0_CLK {{ENABLE 0} {IO {PS_MIO 6}}}\
PS_TTC0_PERIPHERAL_ENABLE 1 PS_TTC0_WAVEOUT {{ENABLE 0} {IO {PS_MIO 7}}}\
PS_TTC1_CLK {{ENABLE 0} {IO {PS_MIO 12}}} PS_TTC1_PERIPHERAL_ENABLE 1\
PS_TTC1_WAVEOUT {{ENABLE 0} {IO {PS_MIO 13}}} PS_TTC2_CLK {{ENABLE 0} {IO\
{PS_MIO 2}}} PS_TTC2_PERIPHERAL_ENABLE 1 PS_TTC2_WAVEOUT {{ENABLE 0} {IO\
{PS_MIO 3}}} PS_TTC3_CLK {{ENABLE 0} {IO {PS_MIO 16}}}\
PS_TTC3_PERIPHERAL_ENABLE 1 PS_TTC3_WAVEOUT {{ENABLE 0} {IO {PS_MIO 17}}}\
PS_UART0_BAUD_RATE 115200 PS_UART0_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 42 ..\
43}}} PS_UART0_RTS_CTS {{ENABLE 0} {IO {PS_MIO 2 .. 3}}} PS_UART1_BAUD_RATE\
115200 PS_UART1_PERIPHERAL {{ENABLE 0} {IO {PMC_MIO 4 .. 5}}} PS_UART1_RTS_CTS\
{{ENABLE 0} {IO {PMC_MIO 6 .. 7}}} PS_USB_COHERENCY 0 PS_USB_ROUTE_THROUGH_FPD\
0 PS_USE_ACE_LITE 0 PS_USE_AXI4_EXT_USER_BITS 0 PS_USE_CLK 0 PS_USE_DEBUG_TEST\
0 PS_USE_DIFF_RW_CLK_S_AXI_FPD 0 PS_USE_DIFF_RW_CLK_S_AXI_GP2 0\
PS_USE_DIFF_RW_CLK_S_AXI_LPD 0 PS_USE_FTM_GPO 0 PS_USE_HSDP_PL 0\
PS_USE_NOC_PS_PCI_0 0 PS_USE_NOC_PS_PMC_0 0 PS_USE_NPI_CLK 0 PS_USE_NPI_RST 0\
PS_USE_PL_FPD_AUX_REF_CLK 0 PS_USE_PL_LPD_AUX_REF_CLK 0 PS_USE_PMC 0\
PS_USE_PMCPL_CLK0 1 PS_USE_PMCPL_CLK1 0 PS_USE_PMCPL_CLK2 0 PS_USE_PMCPL_CLK3 0\
PS_USE_PMCPL_IRO_CLK 0 PS_USE_PS_NOC_PCI_0 0 PS_USE_PS_NOC_PCI_1 0\
PS_USE_PS_NOC_PMC_0 0 PS_USE_PS_NOC_PMC_1 0 PS_USE_RTC 0 PS_USE_SMMU 0\
PS_USE_STARTUP 0 PS_WDT0_REF_CTRL_ACT_FREQMHZ 99.999001\
PS_WDT0_REF_CTRL_FREQMHZ 99.999001 PS_WDT0_REF_CTRL_SEL APB\
PS_WDT1_REF_CTRL_ACT_FREQMHZ 100 PS_WDT1_REF_CTRL_FREQMHZ 100\
PS_WDT1_REF_CTRL_SEL NONE PS_WWDT0_CLK {{ENABLE 0} {IO APB}}\
PS_WWDT0_PERIPHERAL {{ENABLE 1} {IO EMIO}} PS_WWDT1_CLK {{ENABLE 0} {IO\
{PMC_MIO 6}}} PS_WWDT1_PERIPHERAL {{ENABLE 0} {IO {PMC_MIO 6 .. 11}}}\
SEM_MEM_SCAN 0 SEM_NPI_SCAN 0 PL_SEM_GPIO_ENABLE 0 SEM_ERROR_HANDLE_OPTIONS\
{Detect & Correct} SEM_EVENT_LOG_OPTIONS {Log & Notify}\
SEM_MEM_BUILT_IN_SELF_TEST 0 SEM_MEM_ENABLE_ALL_TEST_FEATURE 0\
SEM_MEM_ENABLE_SCAN_AFTER 0 SEM_MEM_GOLDEN_ECC 0 SEM_MEM_GOLDEN_ECC_SW 0\
SEM_NPI_BUILT_IN_SELF_TEST 0 SEM_NPI_ENABLE_ALL_TEST_FEATURE 0\
SEM_NPI_ENABLE_SCAN_AFTER 0 SEM_NPI_GOLDEN_CHECKSUM_SW 0\
SEM_TIME_INTERVAL_BETWEEN_SCANS 0 SPP_PSPMC_FROM_CORE_WIDTH 12000\
SPP_PSPMC_TO_CORE_WIDTH 12000 DEVICE_INTEGRITY_MODE Custom\
PMC_PMC_NOC_ADDR_WIDTH 64 PMC_PMC_NOC_DATA_WIDTH 128 PMC_NOC_PMC_ADDR_WIDTH 64\
PMC_NOC_PMC_DATA_WIDTH 128 SMON_MEAS0 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00}\
{ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
GT_AVAUX_PKG_103}} SMON_MEAS1 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER\
2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME GT_AVAUX_PKG_104}}\
SMON_MEAS2 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN\
0} {ENABLE 0} {MODE {2 V unipolar}} {NAME GT_AVAUX_PKG_105}} SMON_MEAS3\
{{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE\
0} {MODE {2 V unipolar}} {NAME GT_AVAUX_PKG_106}} SMON_MEAS4 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V\
unipolar}} {NAME GT_AVAUX_PKG_200}} SMON_MEAS5 {{ALARM_ENABLE 0} {ALARM_LOWER\
0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
GT_AVAUX_PKG_201}} SMON_MEAS6 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER\
2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME GT_AVAUX_PKG_202}}\
SMON_MEAS7 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN\
0} {ENABLE 0} {MODE {2 V unipolar}} {NAME GT_AVAUX_PKG_203}} SMON_MEAS8\
{{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE\
0} {MODE {2 V unipolar}} {NAME GT_AVAUX_PKG_204}} SMON_MEAS9 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V\
unipolar}} {NAME GT_AVAUX_PKG_205}} SMON_MEAS10 {{ALARM_ENABLE 0} {ALARM_LOWER\
0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
GT_AVAUX_PKG_206}} SMON_MEAS11 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00}\
{ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
GT_AVCC_PKG_103}} SMON_MEAS12 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER\
2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME GT_AVCC_PKG_104}}\
SMON_MEAS13 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN\
0} {ENABLE 0} {MODE {2 V unipolar}} {NAME GT_AVCC_PKG_105}} SMON_MEAS14\
{{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE\
0} {MODE {2 V unipolar}} {NAME GT_AVCC_PKG_106}} SMON_MEAS15 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V\
unipolar}} {NAME GT_AVCC_PKG_200}} SMON_MEAS16 {{ALARM_ENABLE 0} {ALARM_LOWER\
0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
GT_AVCC_PKG_201}} SMON_MEAS17 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER\
2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME GT_AVCC_PKG_202}}\
SMON_MEAS18 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN\
0} {ENABLE 0} {MODE {2 V unipolar}} {NAME GT_AVCC_PKG_203}} SMON_MEAS19\
{{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE\
0} {MODE {2 V unipolar}} {NAME GT_AVCC_PKG_204}} SMON_MEAS20 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V\
unipolar}} {NAME GT_AVCC_PKG_205}} SMON_MEAS21 {{ALARM_ENABLE 0} {ALARM_LOWER\
0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
GT_AVCC_PKG_206}} SMON_MEAS22 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER\
2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME GT_AVTT_PKG_103}}\
SMON_MEAS23 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN\
0} {ENABLE 0} {MODE {2 V unipolar}} {NAME GT_AVTT_PKG_104}} SMON_MEAS24\
{{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE\
0} {MODE {2 V unipolar}} {NAME GT_AVTT_PKG_105}} SMON_MEAS25 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V\
unipolar}} {NAME GT_AVTT_PKG_106}} SMON_MEAS26 {{ALARM_ENABLE 0} {ALARM_LOWER\
0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
GT_AVTT_PKG_200}} SMON_MEAS27 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER\
2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME GT_AVTT_PKG_201}}\
SMON_MEAS28 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN\
0} {ENABLE 0} {MODE {2 V unipolar}} {NAME GT_AVTT_PKG_202}} SMON_MEAS29\
{{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE\
0} {MODE {2 V unipolar}} {NAME GT_AVTT_PKG_203}} SMON_MEAS30 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V\
unipolar}} {NAME GT_AVTT_PKG_204}} SMON_MEAS31 {{ALARM_ENABLE 0} {ALARM_LOWER\
0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
GT_AVTT_PKG_205}} SMON_MEAS32 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER\
2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME GT_AVTT_PKG_206}}\
SMON_MEAS33 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN\
0} {ENABLE 0} {MODE {2 V unipolar}} {NAME LPD_MIO_VCCAUX_502}} SMON_MEAS34\
{{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE\
0} {MODE {4 V unipolar}} {NAME LPD_MIO_VCCO_502}} SMON_MEAS35 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V\
unipolar}} {NAME LPD_MIO_VCC_502}} SMON_MEAS36 {{ALARM_ENABLE 0} {ALARM_LOWER\
0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
PMC_DIO_VCCAUX_503}} SMON_MEAS37 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00}\
{ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {4 V unipolar}} {NAME\
PMC_DIO_VCCO_503}} SMON_MEAS38 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00}\
{ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
PMC_DIO_VCC_503}} SMON_MEAS39 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER\
2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
PMC_MIO_VCCAUX_500}} SMON_MEAS40 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00}\
{ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
PMC_MIO_VCCAUX_501}} SMON_MEAS41 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00}\
{ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {4 V unipolar}} {NAME\
PMC_MIO_VCCO_500}} SMON_MEAS42 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00}\
{ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {4 V unipolar}} {NAME\
PMC_MIO_VCCO_501}} SMON_MEAS43 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00}\
{ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
PMC_MIO_VCC_500}} SMON_MEAS44 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER\
2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME PMC_MIO_VCC_501}}\
SMON_MEAS45 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN\
0} {ENABLE 0} {MODE {2 V unipolar}} {NAME VCCAUX}} SMON_MEAS46 {{ALARM_ENABLE\
0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V\
unipolar}} {NAME VCCAUX_IO_PKG_306}} SMON_MEAS47 {{ALARM_ENABLE 0} {ALARM_LOWER\
0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
VCCAUX_IO_PKG_406}} SMON_MEAS48 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00}\
{ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
VCCAUX_PMC}} SMON_MEAS49 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER\
2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME VCCAUX_SYSMON}}\
SMON_MEAS50 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN\
0} {ENABLE 0} {MODE {2 V unipolar}} {NAME VCCINT_PL}} SMON_MEAS51\
{{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE\
0} {MODE {2 V unipolar}} {NAME VCCO_700}} SMON_MEAS52 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V\
unipolar}} {NAME VCCO_701}} SMON_MEAS53 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00}\
{ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
VCCO_702}} SMON_MEAS54 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME VCCO_703}} SMON_MEAS55\
{{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE\
0} {MODE {2 V unipolar}} {NAME VCCO_704}} SMON_MEAS56 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V\
unipolar}} {NAME VCCO_705}} SMON_MEAS57 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00}\
{ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
VCCO_706}} SMON_MEAS58 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME VCCO_707}} SMON_MEAS59\
{{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE\
0} {MODE {2 V unipolar}} {NAME VCCO_708}} SMON_MEAS60 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V\
unipolar}} {NAME VCCO_709}} SMON_MEAS61 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00}\
{ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
VCCO_710}} SMON_MEAS62 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME VCCO_711}} SMON_MEAS63\
{{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE\
0} {MODE {4 V unipolar}} {NAME VCCO_PKG_306}} SMON_MEAS64 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {4 V\
unipolar}} {NAME VCCO_PKG_406}} SMON_MEAS65 {{ALARM_ENABLE 0} {ALARM_LOWER\
0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
VCC_BATT}} SMON_MEAS66 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME VCC_IO_700}} SMON_MEAS67\
{{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE\
0} {MODE {2 V unipolar}} {NAME VCC_IO_701}} SMON_MEAS68 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V\
unipolar}} {NAME VCC_IO_702}} SMON_MEAS69 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00}\
{ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
VCC_IO_703}} SMON_MEAS70 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER\
2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME VCC_IO_704}}\
SMON_MEAS71 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN\
0} {ENABLE 0} {MODE {2 V unipolar}} {NAME VCC_IO_705}} SMON_MEAS72\
{{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE\
0} {MODE {2 V unipolar}} {NAME VCC_IO_706}} SMON_MEAS73 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V\
unipolar}} {NAME VCC_IO_707}} SMON_MEAS74 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00}\
{ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
VCC_IO_708}} SMON_MEAS75 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER\
2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME VCC_IO_709}}\
SMON_MEAS76 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN\
0} {ENABLE 0} {MODE {2 V unipolar}} {NAME VCC_IO_710}} SMON_MEAS77\
{{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE\
0} {MODE {2 V unipolar}} {NAME VCC_IO_711}} SMON_MEAS78 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V\
unipolar}} {NAME VCC_IO_PKG_306}} SMON_MEAS79 {{ALARM_ENABLE 0} {ALARM_LOWER\
0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
VCC_IO_PKG_406}} SMON_MEAS80 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER\
2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME VCC_PMC}}\
SMON_MEAS81 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN\
0} {ENABLE 0} {MODE {2 V unipolar}} {NAME VCC_PSFP}} SMON_MEAS82 {{ALARM_ENABLE\
0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V\
unipolar}} {NAME VCC_PSLP}} SMON_MEAS83 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00}\
{ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME\
VCC_RAM}} SMON_MEAS84 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE {2 V unipolar}} {NAME VCC_SOC}} SMON_MEAS85\
{{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE\
0} {MODE {2 V unipolar}} {NAME VP_VN}} SMON_MEAS86 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS87 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS88 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS89 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS90 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS91 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS92 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS93 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS94 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS95 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS96 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS97 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS98 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS99 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS100 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS101 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS102 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS103 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS104 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS105 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS106 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS107 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS108 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS109 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS110 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS111 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS112 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS113 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS114 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS115 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS116 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS117 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS118 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS119 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS120 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS121 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS122 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS123 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS124 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS125 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS126 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS127 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS128 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS129 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS130 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS131 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS132 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS133 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS134 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS135 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS136 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS137 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS138 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS139 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS140 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS141 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS142 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS143 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS144 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS145 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS146 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS147 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS148 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS149 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS150 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS151 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS152 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS153 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS154 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS155 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS156 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS157 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS158 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS159 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS160 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS161 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS162 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS163 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS164 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS165 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS166 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS167 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS168 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS169 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS170 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS171 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS172 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS173 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_MEAS174 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 0} {MODE None}\
{NAME 0}} SMON_MEAS175 {{ALARM_ENABLE 0} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00}\
{AVERAGE_EN 0} {ENABLE 0} {MODE None} {NAME 0}} SMON_VAUX_CH0 {{ALARM_ENABLE 0}\
{ALARM_LOWER 0} {ALARM_UPPER 0} {AVERAGE_EN 0} {ENABLE 0} {IO_N PMC_MIO1_500}\
{IO_P PMC_MIO0_500} {MODE {1 V unipolar}} {NAME VAUX_CH0}} SMON_VAUX_CH1\
{{ALARM_ENABLE 0} {ALARM_LOWER 0} {ALARM_UPPER 0} {AVERAGE_EN 0} {ENABLE 0}\
{IO_N PMC_MIO1_500} {IO_P PMC_MIO0_500} {MODE {1 V unipolar}} {NAME VAUX_CH1}}\
SMON_VAUX_CH2 {{ALARM_ENABLE 0} {ALARM_LOWER 0} {ALARM_UPPER 0} {AVERAGE_EN 0}\
{ENABLE 0} {IO_N PMC_MIO1_500} {IO_P PMC_MIO0_500} {MODE {1 V unipolar}} {NAME\
VAUX_CH2}} SMON_VAUX_CH3 {{ALARM_ENABLE 0} {ALARM_LOWER 0} {ALARM_UPPER 0}\
{AVERAGE_EN 0} {ENABLE 0} {IO_N PMC_MIO1_500} {IO_P PMC_MIO0_500} {MODE {1 V\
unipolar}} {NAME VAUX_CH3}} SMON_VAUX_CH4 {{ALARM_ENABLE 0} {ALARM_LOWER 0}\
{ALARM_UPPER 0} {AVERAGE_EN 0} {ENABLE 0} {IO_N PMC_MIO1_500} {IO_P\
PMC_MIO0_500} {MODE {1 V unipolar}} {NAME VAUX_CH4}} SMON_VAUX_CH5\
{{ALARM_ENABLE 0} {ALARM_LOWER 0} {ALARM_UPPER 0} {AVERAGE_EN 0} {ENABLE 0}\
{IO_N PMC_MIO1_500} {IO_P PMC_MIO0_500} {MODE {1 V unipolar}} {NAME VAUX_CH5}}\
SMON_VAUX_CH6 {{ALARM_ENABLE 0} {ALARM_LOWER 0} {ALARM_UPPER 0} {AVERAGE_EN 0}\
{ENABLE 0} {IO_N PMC_MIO1_500} {IO_P PMC_MIO0_500} {MODE {1 V unipolar}} {NAME\
VAUX_CH6}} SMON_VAUX_CH7 {{ALARM_ENABLE 0} {ALARM_LOWER 0} {ALARM_UPPER 0}\
{AVERAGE_EN 0} {ENABLE 0} {IO_N PMC_MIO1_500} {IO_P PMC_MIO0_500} {MODE {1 V\
unipolar}} {NAME VAUX_CH7}} SMON_VAUX_CH8 {{ALARM_ENABLE 0} {ALARM_LOWER 0}\
{ALARM_UPPER 0} {AVERAGE_EN 0} {ENABLE 0} {IO_N PMC_MIO1_500} {IO_P\
PMC_MIO0_500} {MODE {1 V unipolar}} {NAME VAUX_CH8}} SMON_VAUX_CH9\
{{ALARM_ENABLE 0} {ALARM_LOWER 0} {ALARM_UPPER 0} {AVERAGE_EN 0} {ENABLE 0}\
{IO_N PMC_MIO1_500} {IO_P PMC_MIO0_500} {MODE {1 V unipolar}} {NAME VAUX_CH9}}\
SMON_VAUX_CH10 {{ALARM_ENABLE 0} {ALARM_LOWER 0} {ALARM_UPPER 0} {AVERAGE_EN 0}\
{ENABLE 0} {IO_N PMC_MIO1_500} {IO_P PMC_MIO0_500} {MODE {1 V unipolar}} {NAME\
VAUX_CH10}} SMON_VAUX_CH11 {{ALARM_ENABLE 0} {ALARM_LOWER 0} {ALARM_UPPER 0}\
{AVERAGE_EN 0} {ENABLE 0} {IO_N PMC_MIO1_500} {IO_P PMC_MIO0_500} {MODE {1 V\
unipolar}} {NAME VAUX_CH11}} SMON_VAUX_CH12 {{ALARM_ENABLE 0} {ALARM_LOWER 0}\
{ALARM_UPPER 0} {AVERAGE_EN 0} {ENABLE 0} {IO_N PMC_MIO1_500} {IO_P\
PMC_MIO0_500} {MODE {1 V unipolar}} {NAME VAUX_CH12}} SMON_VAUX_CH13\
{{ALARM_ENABLE 0} {ALARM_LOWER 0} {ALARM_UPPER 0} {AVERAGE_EN 0} {ENABLE 0}\
{IO_N PMC_MIO1_500} {IO_P PMC_MIO0_500} {MODE {1 V unipolar}} {NAME VAUX_CH13}}\
SMON_VAUX_CH14 {{ALARM_ENABLE 0} {ALARM_LOWER 0} {ALARM_UPPER 0} {AVERAGE_EN 0}\
{ENABLE 0} {IO_N PMC_MIO1_500} {IO_P PMC_MIO0_500} {MODE {1 V unipolar}} {NAME\
VAUX_CH14}} SMON_VAUX_CH15 {{ALARM_ENABLE 0} {ALARM_LOWER 0} {ALARM_UPPER 0}\
{AVERAGE_EN 0} {ENABLE 0} {IO_N PMC_MIO1_500} {IO_P PMC_MIO0_500} {MODE {1 V\
unipolar}} {NAME VAUX_CH15}} PMC_MIO0 {{AUX_IO 0} {DIRECTION out}\
{DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 1} {SLEW\
slow} {USAGE Reserved}} PMC_MIO1 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH\
8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE\
Reserved}} PMC_MIO2 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA}\
{OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
PMC_MIO3 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA\
default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO4\
{{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL\
pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO5 {{AUX_IO 0}\
{DIRECTION out} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup}\
{SCHMITT 1} {SLEW slow} {USAGE Reserved}} PMC_MIO6 {{AUX_IO 0} {DIRECTION out}\
{DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 1} {SLEW\
slow} {USAGE Reserved}} PMC_MIO7 {{AUX_IO 0} {DIRECTION out} {DRIVE_STRENGTH\
8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 1} {SLEW slow} {USAGE\
Reserved}} PMC_MIO8 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA}\
{OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
PMC_MIO9 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA\
default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO10\
{{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL\
pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO11 {{AUX_IO 0}\
{DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup}\
{SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO12 {{AUX_IO 0} {DIRECTION out}\
{DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 1} {SLEW\
slow} {USAGE Reserved}} PMC_MIO13 {{AUX_IO 0} {DIRECTION out} {DRIVE_STRENGTH\
8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 1} {SLEW slow} {USAGE\
Reserved}} PMC_MIO14 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA}\
{OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
PMC_MIO15 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA\
default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO16\
{{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL\
pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO17 {{AUX_IO 0}\
{DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup}\
{SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO18 {{AUX_IO 0} {DIRECTION in}\
{DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW\
slow} {USAGE Reserved}} PMC_MIO19 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH\
8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE\
Reserved}} PMC_MIO20 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA}\
{OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
PMC_MIO21 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA\
default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO22\
{{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL\
pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO23 {{AUX_IO 0}\
{DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup}\
{SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO24 {{AUX_IO 0} {DIRECTION out}\
{DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 1} {SLEW\
slow} {USAGE Reserved}} PMC_MIO25 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH\
8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE\
Reserved}} PMC_MIO26 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA}\
{OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
PMC_MIO27 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA\
default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO28\
{{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL\
pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO29 {{AUX_IO 0}\
{DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup}\
{SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO30 {{AUX_IO 0} {DIRECTION\
inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 0}\
{SLEW slow} {USAGE Reserved}} PMC_MIO31 {{AUX_IO 0} {DIRECTION inout}\
{DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW\
slow} {USAGE Reserved}} PMC_MIO32 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH\
8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE\
Reserved}} PMC_MIO33 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA}\
{OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
PMC_MIO34 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA\
default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO35\
{{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL\
pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO36 {{AUX_IO 0}\
{DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup}\
{SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO37 {{AUX_IO 0} {DIRECTION out}\
{DRIVE_STRENGTH 8mA} {OUTPUT_DATA high} {PULL pulldown} {SCHMITT 0} {SLEW slow}\
{USAGE GPIO}} PMC_MIO38 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA}\
{OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Unassigned}}\
PMC_MIO39 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Unassigned}} PMC_MIO40 {{AUX_IO 0}\
{DIRECTION out} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup}\
{SCHMITT 1} {SLEW slow} {USAGE Reserved}} PMC_MIO41 {{AUX_IO 0} {DIRECTION in}\
{DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW\
slow} {USAGE Reserved}} PMC_MIO42 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH\
8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE\
Reserved}} PMC_MIO43 {{AUX_IO 0} {DIRECTION out} {DRIVE_STRENGTH 8mA}\
{OUTPUT_DATA default} {PULL pullup} {SCHMITT 1} {SLEW slow} {USAGE Reserved}}\
PMC_MIO44 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA\
default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO45\
{{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL\
pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO46 {{AUX_IO 0}\
{DIRECTION inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup}\
{SCHMITT 0} {SLEW slow} {USAGE Reserved}} PMC_MIO47 {{AUX_IO 0} {DIRECTION\
inout} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 0}\
{SLEW slow} {USAGE Reserved}} PMC_MIO48 {{AUX_IO 0} {DIRECTION out}\
{DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW\
slow} {USAGE GPIO}} PMC_MIO49 {{AUX_IO 0} {DIRECTION out} {DRIVE_STRENGTH 8mA}\
{OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE GPIO}}\
PMC_MIO50 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Unassigned}} PMC_MIO51 {{AUX_IO 0}\
{DIRECTION out} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup}\
{SCHMITT 1} {SLEW slow} {USAGE Reserved}} PS_MIO0 {{AUX_IO 0} {DIRECTION out}\
{DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 1} {SLEW\
slow} {USAGE Reserved}} PS_MIO1 {{AUX_IO 0} {DIRECTION out} {DRIVE_STRENGTH\
8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 1} {SLEW slow} {USAGE\
Reserved}} PS_MIO2 {{AUX_IO 0} {DIRECTION out} {DRIVE_STRENGTH 8mA}\
{OUTPUT_DATA default} {PULL pullup} {SCHMITT 1} {SLEW slow} {USAGE Reserved}}\
PS_MIO3 {{AUX_IO 0} {DIRECTION out} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL pullup} {SCHMITT 1} {SLEW slow} {USAGE Reserved}} PS_MIO4 {{AUX_IO 0}\
{DIRECTION out} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup}\
{SCHMITT 1} {SLEW slow} {USAGE Reserved}} PS_MIO5 {{AUX_IO 0} {DIRECTION out}\
{DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 1} {SLEW\
slow} {USAGE Reserved}} PS_MIO6 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA}\
{OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
PS_MIO7 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} PS_MIO8 {{AUX_IO 0}\
{DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup}\
{SCHMITT 0} {SLEW slow} {USAGE Reserved}} PS_MIO9 {{AUX_IO 0} {DIRECTION in}\
{DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW\
slow} {USAGE Reserved}} PS_MIO10 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH\
8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE\
Reserved}} PS_MIO11 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA}\
{OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
PS_MIO12 {{AUX_IO 0} {DIRECTION out} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL pullup} {SCHMITT 1} {SLEW slow} {USAGE Reserved}} PS_MIO13 {{AUX_IO 0}\
{DIRECTION out} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup}\
{SCHMITT 1} {SLEW slow} {USAGE Reserved}} PS_MIO14 {{AUX_IO 0} {DIRECTION out}\
{DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 1} {SLEW\
slow} {USAGE Reserved}} PS_MIO15 {{AUX_IO 0} {DIRECTION out} {DRIVE_STRENGTH\
8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 1} {SLEW slow} {USAGE\
Reserved}} PS_MIO16 {{AUX_IO 0} {DIRECTION out} {DRIVE_STRENGTH 8mA}\
{OUTPUT_DATA default} {PULL pullup} {SCHMITT 1} {SLEW slow} {USAGE Reserved}}\
PS_MIO17 {{AUX_IO 0} {DIRECTION out} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL pullup} {SCHMITT 1} {SLEW slow} {USAGE Reserved}} PS_MIO18 {{AUX_IO 0}\
{DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup}\
{SCHMITT 0} {SLEW slow} {USAGE Reserved}} PS_MIO19 {{AUX_IO 0} {DIRECTION in}\
{DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW\
slow} {USAGE Reserved}} PS_MIO20 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH\
8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE\
Reserved}} PS_MIO21 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA}\
{OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}}\
PS_MIO22 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default}\
{PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} PS_MIO23 {{AUX_IO 0}\
{DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup}\
{SCHMITT 0} {SLEW slow} {USAGE Reserved}} PS_MIO24 {{AUX_IO 0} {DIRECTION out}\
{DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 1} {SLEW\
slow} {USAGE Reserved}} PS_MIO25 {{AUX_IO 0} {DIRECTION inout} {DRIVE_STRENGTH\
8mA} {OUTPUT_DATA default} {PULL pullup} {SCHMITT 0} {SLEW slow} {USAGE\
Reserved}} PMC_CORE_SUBSYSTEM_LOAD 10 PS_R5_LOAD 90 PS_LPD_INTERCONNECT_LOAD 90\
PS_FPD_INTERCONNECT_LOAD 90 PS_A72_LOAD 90 PS_R5_ACTIVE_BLOCKS 2\
PS_TCM_ACTIVE_BLOCKS 2 PS_OCM_ACTIVE_BLOCKS 1 PS_A72_ACTIVE_BLOCKS 2\
PS_PL_PASS_AXPROT_VALUE 0 PS_BOARD_INTERFACE Custom DESIGN_MODE 2\
PCIE_APERTURES_SINGLE_ENABLE 0 PCIE_APERTURES_DUAL_ENABLE 0}\
   CONFIG.PS_PMC_CONFIG_APPLIED {1} \
 ] $CIPS_0

  # Create instance: NOC_0, and set properties
  set NOC_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc NOC_0 ]
  set_property -dict [ list \
   CONFIG.CONTROLLERTYPE {LPDDR4_SDRAM} \
   CONFIG.HBM_DENSITY_PER_CHNL {1GB} \
   CONFIG.LOGO_FILE {data/noc_mc.png} \
   CONFIG.MC0_CONFIG_NUM {config26} \
   CONFIG.MC0_FLIPPED_PINOUT {true} \
   CONFIG.MC1_CONFIG_NUM {config26} \
   CONFIG.MC2_CONFIG_NUM {config26} \
   CONFIG.MC3_CONFIG_NUM {config26} \
   CONFIG.MC_ADDR_BIT2 {CA0} \
   CONFIG.MC_ADDR_BIT3 {CA1} \
   CONFIG.MC_ADDR_BIT4 {CA2} \
   CONFIG.MC_ADDR_BIT5 {CA3} \
   CONFIG.MC_ADDR_BIT6 {CA4} \
   CONFIG.MC_ADDR_BIT7 {CA5} \
   CONFIG.MC_ADDR_BIT8 {CA6} \
   CONFIG.MC_ADDR_BIT9 {CA7} \
   CONFIG.MC_ADDR_BIT10 {CA8} \
   CONFIG.MC_ADDR_BIT11 {CA9} \
   CONFIG.MC_ADDR_BIT12 {BA0} \
   CONFIG.MC_ADDR_BIT13 {BA1} \
   CONFIG.MC_ADDR_BIT14 {BA2} \
   CONFIG.MC_ADDR_BIT15 {RA0} \
   CONFIG.MC_ADDR_BIT16 {RA1} \
   CONFIG.MC_ADDR_BIT17 {RA2} \
   CONFIG.MC_ADDR_BIT18 {RA3} \
   CONFIG.MC_ADDR_BIT19 {RA4} \
   CONFIG.MC_ADDR_BIT20 {RA5} \
   CONFIG.MC_ADDR_BIT21 {RA6} \
   CONFIG.MC_ADDR_BIT22 {RA7} \
   CONFIG.MC_ADDR_BIT23 {RA8} \
   CONFIG.MC_ADDR_BIT24 {RA9} \
   CONFIG.MC_ADDR_BIT25 {RA10} \
   CONFIG.MC_ADDR_BIT26 {RA11} \
   CONFIG.MC_ADDR_BIT27 {RA12} \
   CONFIG.MC_ADDR_BIT28 {RA13} \
   CONFIG.MC_ADDR_BIT29 {RA14} \
   CONFIG.MC_ADDR_BIT30 {RA15} \
   CONFIG.MC_ADDR_BIT31 {CH_SEL} \
   CONFIG.MC_ADDR_BIT32 {NA} \
   CONFIG.MC_ADDR_WIDTH {6} \
   CONFIG.MC_BA_WIDTH {3} \
   CONFIG.MC_BG_WIDTH {0} \
   CONFIG.MC_BURST_LENGTH {16} \
   CONFIG.MC_CASLATENCY {28} \
   CONFIG.MC_CASWRITELATENCY {14} \
   CONFIG.MC_CH0_LP4_CHA_ENABLE {true} \
   CONFIG.MC_CH0_LP4_CHB_ENABLE {true} \
   CONFIG.MC_CH1_LP4_CHA_ENABLE {true} \
   CONFIG.MC_CH1_LP4_CHB_ENABLE {true} \
   CONFIG.MC_CHAN_REGION0 {DDR_LOW0} \
   CONFIG.MC_CHAN_REGION1 {NONE} \
   CONFIG.MC_CKE_WIDTH {0} \
   CONFIG.MC_CK_WIDTH {0} \
   CONFIG.MC_COMPONENT_DENSITY {16Gb} \
   CONFIG.MC_COMPONENT_WIDTH {x32} \
   CONFIG.MC_CONFIG_NUM {config26} \
   CONFIG.MC_DATAWIDTH {32} \
   CONFIG.MC_DDR_INIT_TIMEOUT {0x0000756A} \
   CONFIG.MC_DM_WIDTH {4} \
   CONFIG.MC_DQS_WIDTH {4} \
   CONFIG.MC_DQ_WIDTH {32} \
   CONFIG.MC_ECC_SCRUB_SIZE {1} \
   CONFIG.MC_EN_BACKGROUND_SCRUBBING {true} \
   CONFIG.MC_F1_CASLATENCY {28} \
   CONFIG.MC_F1_CASWRITELATENCY {14} \
   CONFIG.MC_F1_LPDDR4_MR13 {0x00C0} \
   CONFIG.MC_F1_TCCD_L {0} \
   CONFIG.MC_F1_TCCD_L_MIN {0} \
   CONFIG.MC_F1_TFAW {40000} \
   CONFIG.MC_F1_TFAWMIN {40000} \
   CONFIG.MC_F1_TMOD {0} \
   CONFIG.MC_F1_TMOD_MIN {0} \
   CONFIG.MC_F1_TMRD {14000} \
   CONFIG.MC_F1_TMRDMIN {14000} \
   CONFIG.MC_F1_TMRW {10000} \
   CONFIG.MC_F1_TMRWMIN {10000} \
   CONFIG.MC_F1_TRAS {42000} \
   CONFIG.MC_F1_TRASMIN {42000} \
   CONFIG.MC_F1_TRCD {18000} \
   CONFIG.MC_F1_TRCDMIN {18000} \
   CONFIG.MC_F1_TRPAB {21000} \
   CONFIG.MC_F1_TRPABMIN {21000} \
   CONFIG.MC_F1_TRPPB {18000} \
   CONFIG.MC_F1_TRPPBMIN {18000} \
   CONFIG.MC_F1_TRRD {10000} \
   CONFIG.MC_F1_TRRDMIN {10000} \
   CONFIG.MC_F1_TRRD_L {0} \
   CONFIG.MC_F1_TRRD_L_MIN {0} \
   CONFIG.MC_F1_TRRD_S {0} \
   CONFIG.MC_F1_TRRD_S_MIN {0} \
   CONFIG.MC_F1_TWR {18000} \
   CONFIG.MC_F1_TWRMIN {18000} \
   CONFIG.MC_F1_TWTR {10000} \
   CONFIG.MC_F1_TWTRMIN {10000} \
   CONFIG.MC_F1_TWTR_L {0} \
   CONFIG.MC_F1_TWTR_L_MIN {0} \
   CONFIG.MC_F1_TWTR_S {0} \
   CONFIG.MC_F1_TWTR_S_MIN {0} \
   CONFIG.MC_F1_TZQLAT {30000} \
   CONFIG.MC_F1_TZQLATMIN {30000} \
   CONFIG.MC_INPUTCLK0_PERIOD {5000} \
   CONFIG.MC_INPUT_FREQUENCY0 {200.000} \
   CONFIG.MC_INTERLEAVE_SIZE {128} \
   CONFIG.MC_IP_TIMEPERIOD0_FOR_OP {1071} \
   CONFIG.MC_LP4_CA_A_WIDTH {6} \
   CONFIG.MC_LP4_CA_B_WIDTH {6} \
   CONFIG.MC_LP4_CKE_A_WIDTH {1} \
   CONFIG.MC_LP4_CKE_B_WIDTH {1} \
   CONFIG.MC_LP4_CKT_A_WIDTH {1} \
   CONFIG.MC_LP4_CKT_B_WIDTH {1} \
   CONFIG.MC_LP4_CS_A_WIDTH {1} \
   CONFIG.MC_LP4_CS_B_WIDTH {1} \
   CONFIG.MC_LP4_DMI_A_WIDTH {2} \
   CONFIG.MC_LP4_DMI_B_WIDTH {2} \
   CONFIG.MC_LP4_DQS_A_WIDTH {2} \
   CONFIG.MC_LP4_DQS_B_WIDTH {2} \
   CONFIG.MC_LP4_DQ_A_WIDTH {16} \
   CONFIG.MC_LP4_DQ_B_WIDTH {16} \
   CONFIG.MC_LP4_RESETN_WIDTH {1} \
   CONFIG.MC_MEMORY_DENSITY {2GB} \
   CONFIG.MC_MEMORY_DEVICETYPE {Components} \
   CONFIG.MC_MEMORY_DEVICE_DENSITY {16Gb} \
   CONFIG.MC_MEMORY_SPEEDGRADE {LPDDR4-3200} \
   CONFIG.MC_MEMORY_TIMEPERIOD0 {625} \
   CONFIG.MC_MEM_DEVICE_WIDTH {x32} \
   CONFIG.MC_NO_CHANNELS {Dual} \
   CONFIG.MC_ODTLon {6} \
   CONFIG.MC_ODT_WIDTH {0} \
   CONFIG.MC_PER_RD_INTVL {0} \
   CONFIG.MC_PRE_DEF_ADDR_MAP_SEL {ROW_BANK_COLUMN} \
   CONFIG.MC_RANK {1} \
   CONFIG.MC_REFRESH_SPEED {1x} \
   CONFIG.MC_ROWADDRESSWIDTH {16} \
   CONFIG.MC_TCCD {8} \
   CONFIG.MC_TCCD_L {0} \
   CONFIG.MC_TCCD_L_MIN {0} \
   CONFIG.MC_TCKE {12} \
   CONFIG.MC_TCKEMIN {12} \
   CONFIG.MC_TDQS2DQ_MAX {800} \
   CONFIG.MC_TDQS2DQ_MIN {200} \
   CONFIG.MC_TDQSCK_MAX {3500} \
   CONFIG.MC_TFAW {40000} \
   CONFIG.MC_TFAWMIN {40000} \
   CONFIG.MC_TFAW_nCK {0} \
   CONFIG.MC_TMOD {0} \
   CONFIG.MC_TMOD_MIN {0} \
   CONFIG.MC_TMPRR {0} \
   CONFIG.MC_TMRD {14000} \
   CONFIG.MC_TMRDMIN {14000} \
   CONFIG.MC_TMRD_div4 {10} \
   CONFIG.MC_TMRD_nCK {23} \
   CONFIG.MC_TMRW {10000} \
   CONFIG.MC_TMRWMIN {10000} \
   CONFIG.MC_TMRW_div4 {10} \
   CONFIG.MC_TMRW_nCK {16} \
   CONFIG.MC_TODTon_MIN {3} \
   CONFIG.MC_TOSCO {40000} \
   CONFIG.MC_TOSCOMIN {40000} \
   CONFIG.MC_TOSCO_nCK {64} \
   CONFIG.MC_TPAR_ALERT_ON {0} \
   CONFIG.MC_TPAR_ALERT_PW_MAX {0} \
   CONFIG.MC_TPBR2PBR {90000} \
   CONFIG.MC_TPBR2PBRMIN {90000} \
   CONFIG.MC_TRAS {42000} \
   CONFIG.MC_TRASMIN {42000} \
   CONFIG.MC_TRAS_nCK {68} \
   CONFIG.MC_TRC {63000} \
   CONFIG.MC_TRCD {18000} \
   CONFIG.MC_TRCDMIN {18000} \
   CONFIG.MC_TRCD_nCK {29} \
   CONFIG.MC_TRCMIN {0} \
   CONFIG.MC_TREFI {3904000} \
   CONFIG.MC_TREFIPB {488000} \
   CONFIG.MC_TRFC {0} \
   CONFIG.MC_TRFCAB {280000} \
   CONFIG.MC_TRFCABMIN {280000} \
   CONFIG.MC_TRFCMIN {0} \
   CONFIG.MC_TRFCPB {140000} \
   CONFIG.MC_TRFCPBMIN {140000} \
   CONFIG.MC_TRP {0} \
   CONFIG.MC_TRPAB {21000} \
   CONFIG.MC_TRPABMIN {21000} \
   CONFIG.MC_TRPAB_nCK {34} \
   CONFIG.MC_TRPMIN {0} \
   CONFIG.MC_TRPPB {18000} \
   CONFIG.MC_TRPPBMIN {18000} \
   CONFIG.MC_TRPPB_nCK {29} \
   CONFIG.MC_TRPRE {1.8} \
   CONFIG.MC_TRRD {10000} \
   CONFIG.MC_TRRDMIN {10000} \
   CONFIG.MC_TRRD_L {0} \
   CONFIG.MC_TRRD_L_MIN {0} \
   CONFIG.MC_TRRD_S {0} \
   CONFIG.MC_TRRD_S_MIN {0} \
   CONFIG.MC_TRRD_nCK {16} \
   CONFIG.MC_TWPRE {1.8} \
   CONFIG.MC_TWPST {0.4} \
   CONFIG.MC_TWR {18000} \
   CONFIG.MC_TWRMIN {18000} \
   CONFIG.MC_TWR_nCK {29} \
   CONFIG.MC_TWTR {10000} \
   CONFIG.MC_TWTRMIN {10000} \
   CONFIG.MC_TWTR_L {0} \
   CONFIG.MC_TWTR_S {0} \
   CONFIG.MC_TWTR_S_MIN {0} \
   CONFIG.MC_TWTR_nCK {16} \
   CONFIG.MC_TXP {12} \
   CONFIG.MC_TXPMIN {12} \
   CONFIG.MC_TXPR {0} \
   CONFIG.MC_TZQCAL {1000000} \
   CONFIG.MC_TZQCAL_div4 {400} \
   CONFIG.MC_TZQCS_ITVL {0} \
   CONFIG.MC_TZQLAT {30000} \
   CONFIG.MC_TZQLATMIN {30000} \
   CONFIG.MC_TZQLAT_div4 {12} \
   CONFIG.MC_TZQLAT_nCK {48} \
   CONFIG.MC_TZQ_START_ITVL {1000000000} \
   CONFIG.MC_USER_DEFINED_ADDRESS_MAP {16RA-3BA-10CA} \
   CONFIG.MC_XPLL_CLKOUT1_PHASE {238.176} \
   CONFIG.NUM_CLKS {10} \
   CONFIG.NUM_MC {1} \
   CONFIG.NUM_MCP {4} \
   CONFIG.NUM_MI {0} \
   CONFIG.NUM_NMI {0} \
   CONFIG.NUM_NSI {0} \
   CONFIG.NUM_SI {14} \
 ] $NOC_0

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.CONNECTIONS {MC_0 { read_bw {5} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {M00_AXI:0x180} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /NOC_0/S00_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.CONNECTIONS {MC_1 { read_bw {5} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {M00_AXI:0x180} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /NOC_0/S01_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.CONNECTIONS {MC_2 { read_bw {5} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {M00_AXI:0x180} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /NOC_0/S02_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.CONNECTIONS {MC_3 { read_bw {5} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {M00_AXI:0x180} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /NOC_0/S03_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.CONNECTIONS {MC_0 { read_bw {5} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {M00_AXI:0x200} \
   CONFIG.CATEGORY {ps_nci} \
 ] [get_bd_intf_pins /NOC_0/S04_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.CONNECTIONS {MC_1 { read_bw {5} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {M00_AXI:0x200} \
   CONFIG.CATEGORY {ps_nci} \
 ] [get_bd_intf_pins /NOC_0/S05_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.CONNECTIONS {MC_2 { read_bw {5} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {M00_AXI:0x200} \
   CONFIG.CATEGORY {ps_rpu} \
 ] [get_bd_intf_pins /NOC_0/S06_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.CONNECTIONS {MC_3 { read_bw {5} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.DEST_IDS {M00_AXI:0x180} \
   CONFIG.CATEGORY {ps_pmc} \
 ] [get_bd_intf_pins /NOC_0/S07_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {256} \
   CONFIG.R_TRAFFIC_CLASS {LOW_LATENCY} \
   CONFIG.W_TRAFFIC_CLASS {BEST_EFFORT} \
   CONFIG.PHYSICAL_LOC {NOC_NMU512_X0Y0} \
   CONFIG.CONNECTIONS {MC_0 { read_bw {1782} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /NOC_0/S08_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {256} \
   CONFIG.R_TRAFFIC_CLASS {LOW_LATENCY} \
   CONFIG.W_TRAFFIC_CLASS {BEST_EFFORT} \
   CONFIG.PHYSICAL_LOC {NOC_NMU512_X0Y1} \
   CONFIG.CONNECTIONS {MC_1 { read_bw {1782} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /NOC_0/S09_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {256} \
   CONFIG.R_TRAFFIC_CLASS {LOW_LATENCY} \
   CONFIG.PHYSICAL_LOC {NOC_NMU512_X0Y2} \
   CONFIG.CONNECTIONS {MC_2 { read_bw {1782} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /NOC_0/S10_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.R_TRAFFIC_CLASS {BEST_EFFORT} \
   CONFIG.PHYSICAL_LOC {NOC_NMU512_X0Y3} \
   CONFIG.CONNECTIONS {MC_3 { read_bw {1782} write_bw {1782} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /NOC_0/S11_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.CONNECTIONS {MC_0 { read_bw {1782} write_bw {1782} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /NOC_0/S12_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {256} \
   CONFIG.CONNECTIONS {MC_1 { read_bw {5} write_bw {1782} read_avg_burst {4} write_avg_burst {4}} } \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /NOC_0/S13_AXI]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S00_AXI} \
 ] [get_bd_pins /NOC_0/aclk0]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S01_AXI} \
 ] [get_bd_pins /NOC_0/aclk1]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S02_AXI} \
 ] [get_bd_pins /NOC_0/aclk2]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S03_AXI} \
 ] [get_bd_pins /NOC_0/aclk3]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S04_AXI} \
 ] [get_bd_pins /NOC_0/aclk4]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S05_AXI} \
 ] [get_bd_pins /NOC_0/aclk5]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S06_AXI} \
 ] [get_bd_pins /NOC_0/aclk6]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S07_AXI} \
 ] [get_bd_pins /NOC_0/aclk7]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S08_AXI:S09_AXI:S10_AXI:S11_AXI:S12_AXI} \
 ] [get_bd_pins /NOC_0/aclk8]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S13_AXI} \
 ] [get_bd_pins /NOC_0/aclk9]

  # Create instance: axi_perf_mon_0, and set properties
  set axi_perf_mon_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_perf_mon axi_perf_mon_0 ]
  set_property -dict [ list \
   CONFIG.C_ENABLE_ADVANCED {1} \
   CONFIG.C_ENABLE_EVENT_COUNT {1} \
   CONFIG.C_ENABLE_PROFILE {0} \
   CONFIG.C_NUM_MONITOR_SLOTS {6} \
   CONFIG.C_NUM_OF_COUNTERS {10} \
   CONFIG.ENABLE_EXT_TRIGGERS {0} \
 ] $axi_perf_mon_0

  # Create instance: axi_vip_m0, and set properties
  set axi_vip_m0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip axi_vip_m0 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {1} \
   CONFIG.HAS_LOCK {1} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {1} \
   CONFIG.HAS_REGION {1} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {0} \
   CONFIG.INTERFACE_MODE {MASTER} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
 ] $axi_vip_m0

  # Create instance: axi_vip_m1, and set properties
  set axi_vip_m1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip axi_vip_m1 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {1} \
   CONFIG.HAS_LOCK {1} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {1} \
   CONFIG.HAS_REGION {1} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {0} \
   CONFIG.INTERFACE_MODE {MASTER} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
 ] $axi_vip_m1

  # Create instance: axi_vip_s0, and set properties
  set axi_vip_s0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip axi_vip_s0 ]
  set_property -dict [ list \
   CONFIG.INTERFACE_MODE {SLAVE} \
 ] $axi_vip_s0

  # Create instance: clk_wiz, and set properties
  set clk_wiz [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wizard clk_wiz ]
  set_property -dict [ list \
   CONFIG.CLKFBOUT_MULT {126.000000} \
   CONFIG.CLKOUT1_DIVIDE {28.000000} \
   CONFIG.CLKOUT2_DIVIDE {40.000000} \
   CONFIG.CLKOUT3_DIVIDE {21.000000} \
   CONFIG.CLKOUT4_DIVIDE {12} \
   CONFIG.CLKOUT_DRIVES {BUFG,BUFG,BUFG,BUFG,BUFG,BUFG,BUFG} \
   CONFIG.CLKOUT_DYN_PS {None,None,None,None,None,None,None} \
   CONFIG.CLKOUT_MATCHED_ROUTING {false,false,false,false,false,false,false} \
   CONFIG.CLKOUT_MBUFGCE_MODE {PERFORMANCE,PERFORMANCE,PERFORMANCE,PERFORMANCE,PERFORMANCE,PERFORMANCE,PERFORMANCE}\
   CONFIG.CLKOUT_PORT {clk_out1,clk_out2,clk_out3,clk_out4,clk_out5,clk_out6,clk_out7} \
   CONFIG.CLKOUT_REQUESTED_DUTY_CYCLE {50.000,50.000,50.000,50.000,50.000,50.000,50.000} \
   CONFIG.CLKOUT_REQUESTED_OUT_FREQUENCY {150.000,105.000,200.000,150.000,100.000,100.000,100.000} \
   CONFIG.CLKOUT_REQUESTED_PHASE {0.000,0.000,0.000,0.000,0.000,0.000,0.000} \
   CONFIG.CLKOUT_USED {true,true,true,false,false,false,false} \
   CONFIG.DESKEW1_DELAY_PATH {ClkFb_Path} \
   CONFIG.DESKEW2_DELAY_PATH {ClkFb_Path} \
   CONFIG.DIVCLK_DIVIDE {3} \
   CONFIG.JITTER_SEL {Min_O_Jitter} \
   CONFIG.PHASESHIFT_MODE {WAVEFORM} \
   CONFIG.PRIM_SOURCE {Global_buffer} \
   CONFIG.RESET_TYPE {ACTIVE_LOW} \
   CONFIG.SECONDARY_IN_FREQ {100.000} \
   CONFIG.USE_LOCKED {true} \
   CONFIG.USE_PHASE_ALIGNMENT {true} \
   CONFIG.USE_RESET {true} \
 ] $clk_wiz

  # Create instance: display_pipe
  create_hier_cell_display_pipe [current_bd_instance .] display_pipe

  # Create instance: mipi_capture_pipe
  create_hier_cell_mipi_capture_pipe [current_bd_instance .] mipi_capture_pipe

  # Create instance: rst_processor_150MHz, and set properties
  set rst_processor_150MHz [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_processor_150MHz ]
  set_property -dict [ list \
   CONFIG.C_NUM_PERP_ARESETN {1} \
 ] $rst_processor_150MHz

  # Create instance: rst_processor_pl_105Mhz, and set properties
  set rst_processor_pl_105Mhz [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_processor_pl_105Mhz ]

  # Create instance: rst_processor_pl_200Mhz, and set properties
  set rst_processor_pl_200Mhz [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_processor_pl_200Mhz ]

  # Create instance: smartconnect_accel0, and set properties
  set smartconnect_accel0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_accel0 ]
  set_property -dict [ list \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_accel0

  # Create instance: smartconnect_accel1, and set properties
  set smartconnect_accel1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_accel1 ]
  set_property -dict [ list \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_accel1

  # Create instance: smartconnect_gp0, and set properties
  set smartconnect_gp0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_gp0 ]
  set_property -dict [ list \
   CONFIG.NUM_CLKS {3} \
   CONFIG.NUM_MI {12} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_gp0

  # Create instance: smartconnect_gp2, and set properties
  set smartconnect_gp2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_gp2 ]
  set_property -dict [ list \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_gp2

  # Create interface connections
  connect_bd_intf_net -intf_net CIPS_0_IF_PMC_NOC_AXI_0 [get_bd_intf_pins CIPS_0/PMC_NOC_AXI_0] [get_bd_intf_pins NOC_0/S07_AXI]
  connect_bd_intf_net -intf_net CIPS_0_IF_PS_NOC_CCI_0 [get_bd_intf_pins CIPS_0/FPD_CCI_NOC_0] [get_bd_intf_pins NOC_0/S00_AXI]
  connect_bd_intf_net -intf_net CIPS_0_IF_PS_NOC_CCI_1 [get_bd_intf_pins CIPS_0/FPD_CCI_NOC_1] [get_bd_intf_pins NOC_0/S01_AXI]
  connect_bd_intf_net -intf_net CIPS_0_IF_PS_NOC_CCI_2 [get_bd_intf_pins CIPS_0/FPD_CCI_NOC_2] [get_bd_intf_pins NOC_0/S02_AXI]
  connect_bd_intf_net -intf_net CIPS_0_IF_PS_NOC_CCI_3 [get_bd_intf_pins CIPS_0/FPD_CCI_NOC_3] [get_bd_intf_pins NOC_0/S03_AXI]
  connect_bd_intf_net -intf_net CIPS_0_IF_PS_NOC_NCI_0 [get_bd_intf_pins CIPS_0/FPD_AXI_NOC_0] [get_bd_intf_pins NOC_0/S04_AXI]
  connect_bd_intf_net -intf_net CIPS_0_IF_PS_NOC_NCI_1 [get_bd_intf_pins CIPS_0/FPD_AXI_NOC_1] [get_bd_intf_pins NOC_0/S05_AXI]
  connect_bd_intf_net -intf_net CIPS_0_IF_PS_NOC_RPU_0 [get_bd_intf_pins CIPS_0/LPD_AXI_NOC_0] [get_bd_intf_pins NOC_0/S06_AXI]
  connect_bd_intf_net -intf_net CIPS_0_M_AXI_GP2 [get_bd_intf_pins CIPS_0/M_AXI_LPD] [get_bd_intf_pins smartconnect_gp2/S00_AXI]
  connect_bd_intf_net -intf_net NOC_0_CH0_LPDDR4_0 [get_bd_intf_ports CH0_LPDDR4_0_0] [get_bd_intf_pins NOC_0/CH0_LPDDR4_0]
  connect_bd_intf_net -intf_net NOC_0_CH1_LPDDR4_0 [get_bd_intf_ports CH1_LPDDR4_0_0] [get_bd_intf_pins NOC_0/CH1_LPDDR4_0]
  connect_bd_intf_net -intf_net axi_vip_1_M_AXI [get_bd_intf_pins axi_vip_m0/M_AXI] [get_bd_intf_pins smartconnect_accel0/S00_AXI]
  connect_bd_intf_net -intf_net axi_vip_2_M_AXI [get_bd_intf_pins axi_vip_m1/M_AXI] [get_bd_intf_pins smartconnect_accel1/S00_AXI]
  connect_bd_intf_net -intf_net cap_pipe_M00_AXI [get_bd_intf_pins NOC_0/S09_AXI] [get_bd_intf_pins display_pipe/vmix_mm_axi_vid_rd_1]
connect_bd_intf_net -intf_net [get_bd_intf_nets cap_pipe_M00_AXI] [get_bd_intf_pins NOC_0/S09_AXI] [get_bd_intf_pins axi_perf_mon_0/SLOT_1_AXI]
  connect_bd_intf_net -intf_net csi_mipi_phy_if_1 [get_bd_intf_ports csi_mipi_phy_if] [get_bd_intf_pins mipi_capture_pipe/csi_mipi_phy_if]
  connect_bd_intf_net -intf_net csirxss_s_axi_1 [get_bd_intf_pins mipi_capture_pipe/csirxss_s_axi] [get_bd_intf_pins smartconnect_gp0/M05_AXI]
  connect_bd_intf_net -intf_net display_pipe_HDMI_CTL_IIC [get_bd_intf_ports HDMI_CTL_IIC] [get_bd_intf_pins display_pipe/HDMI_CTL_IIC]
  connect_bd_intf_net -intf_net display_pipe_TX_DDC_OUT [get_bd_intf_ports TX_DDC_OUT] [get_bd_intf_pins display_pipe/TX_DDC_OUT]
  connect_bd_intf_net -intf_net display_pipe_m_axi_mm_video9 [get_bd_intf_pins NOC_0/S11_AXI] [get_bd_intf_pins smartconnect_accel0/M00_AXI]
connect_bd_intf_net -intf_net [get_bd_intf_nets display_pipe_m_axi_mm_video9] [get_bd_intf_pins axi_perf_mon_0/SLOT_3_AXI] [get_bd_intf_pins smartconnect_accel0/M00_AXI]
  connect_bd_intf_net -intf_net display_pipe_vmix_mm_axi_vid_rd_0 [get_bd_intf_pins NOC_0/S08_AXI] [get_bd_intf_pins display_pipe/vmix_mm_axi_vid_rd_0]
connect_bd_intf_net -intf_net [get_bd_intf_nets display_pipe_vmix_mm_axi_vid_rd_0] [get_bd_intf_pins NOC_0/S08_AXI] [get_bd_intf_pins axi_perf_mon_0/SLOT_0_AXI]
  connect_bd_intf_net -intf_net display_pipe_vmix_mm_axi_vid_rd_1 [get_bd_intf_pins NOC_0/S10_AXI] [get_bd_intf_pins display_pipe/vmix_mm_axi_vid_rd_2]
connect_bd_intf_net -intf_net [get_bd_intf_nets display_pipe_vmix_mm_axi_vid_rd_1] [get_bd_intf_pins NOC_0/S10_AXI] [get_bd_intf_pins axi_perf_mon_0/SLOT_2_AXI]
  connect_bd_intf_net -intf_net mipi_capture_pipe_M00_AXI [get_bd_intf_pins NOC_0/S13_AXI] [get_bd_intf_pins mipi_capture_pipe/M00_AXI]
connect_bd_intf_net -intf_net [get_bd_intf_nets mipi_capture_pipe_M00_AXI] [get_bd_intf_pins axi_perf_mon_0/SLOT_5_AXI] [get_bd_intf_pins mipi_capture_pipe/M00_AXI]
  connect_bd_intf_net -intf_net mipi_csi_rx_ss_IIC_sensor [get_bd_intf_ports sensor_iic] [get_bd_intf_pins mipi_capture_pipe/sensor_iic]
  connect_bd_intf_net -intf_net s_axi_CTRL1_1 [get_bd_intf_pins mipi_capture_pipe/s_axi_CTRL1] [get_bd_intf_pins smartconnect_gp0/M07_AXI]
  connect_bd_intf_net -intf_net s_axi_CTRL_1 [get_bd_intf_pins mipi_capture_pipe/s_axi_CTRL] [get_bd_intf_pins smartconnect_gp0/M06_AXI]
  connect_bd_intf_net -intf_net s_axi_ctrl_1_1 [get_bd_intf_pins mipi_capture_pipe/s_axi_ctrl_1] [get_bd_intf_pins smartconnect_gp0/M10_AXI]
  connect_bd_intf_net -intf_net s_axi_ctrl_vmix_1 [get_bd_intf_pins display_pipe/s_axi_ctrl_vmix] [get_bd_intf_pins smartconnect_gp0/M03_AXI]
  connect_bd_intf_net -intf_net smartconnect_accel_M00_AXI [get_bd_intf_pins NOC_0/S12_AXI] [get_bd_intf_pins smartconnect_accel1/M00_AXI]
connect_bd_intf_net -intf_net [get_bd_intf_nets smartconnect_accel_M00_AXI] [get_bd_intf_pins axi_perf_mon_0/SLOT_4_AXI] [get_bd_intf_pins smartconnect_accel1/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_gp0_M00_AXI [get_bd_intf_pins display_pipe/S_AXI] [get_bd_intf_pins smartconnect_gp0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_gp0_M01_AXI [get_bd_intf_pins display_pipe/S_AXI_CPU_IN] [get_bd_intf_pins smartconnect_gp0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_gp0_M02_AXI [get_bd_intf_pins display_pipe/axi4lite] [get_bd_intf_pins smartconnect_gp0/M02_AXI]
  connect_bd_intf_net -intf_net smartconnect_gp0_M04_AXI [get_bd_intf_pins mipi_capture_pipe/S_AXI] [get_bd_intf_pins smartconnect_gp0/M04_AXI]
  connect_bd_intf_net -intf_net smartconnect_gp0_M11_AXI [get_bd_intf_pins axi_perf_mon_0/S_AXI] [get_bd_intf_pins smartconnect_gp0/M11_AXI]
  connect_bd_intf_net -intf_net smartconnect_gp2_M00_AXI [get_bd_intf_pins axi_vip_s0/S_AXI] [get_bd_intf_pins smartconnect_gp2/M00_AXI]
  connect_bd_intf_net -intf_net sys_clk0_0_1 [get_bd_intf_ports sys_clk0_0] [get_bd_intf_pins NOC_0/sys_clk0]
  connect_bd_intf_net -intf_net versal_cips_1_M_AXI_GP0 [get_bd_intf_pins CIPS_0/M_AXI_FPD] [get_bd_intf_pins smartconnect_gp0/S00_AXI]

  # Create port connections
  connect_bd_net -net CIPS_0_pl_resetn0 [get_bd_pins CIPS_0/pl0_resetn] [get_bd_pins clk_wiz/resetn] [get_bd_pins rst_processor_150MHz/ext_reset_in] [get_bd_pins rst_processor_pl_105Mhz/ext_reset_in] [get_bd_pins rst_processor_pl_200Mhz/ext_reset_in]
  connect_bd_net -net CIPS_0_ps_pmc_noc_axi0_clk [get_bd_pins CIPS_0/pmc_axi_noc_axi0_clk] [get_bd_pins NOC_0/aclk7]
  connect_bd_net -net CIPS_0_ps_ps_noc_cci_axi0_clk [get_bd_pins CIPS_0/fpd_cci_noc_axi0_clk] [get_bd_pins NOC_0/aclk0]
  connect_bd_net -net CIPS_0_ps_ps_noc_cci_axi1_clk [get_bd_pins CIPS_0/fpd_cci_noc_axi1_clk] [get_bd_pins NOC_0/aclk1]
  connect_bd_net -net CIPS_0_ps_ps_noc_cci_axi2_clk [get_bd_pins CIPS_0/fpd_cci_noc_axi2_clk] [get_bd_pins NOC_0/aclk2]
  connect_bd_net -net CIPS_0_ps_ps_noc_cci_axi3_clk [get_bd_pins CIPS_0/fpd_cci_noc_axi3_clk] [get_bd_pins NOC_0/aclk3]
  connect_bd_net -net CIPS_0_ps_ps_noc_nci_axi0_clk [get_bd_pins CIPS_0/fpd_axi_noc_axi0_clk] [get_bd_pins NOC_0/aclk4]
  connect_bd_net -net CIPS_0_ps_ps_noc_nci_axi1_clk [get_bd_pins CIPS_0/fpd_axi_noc_axi1_clk] [get_bd_pins NOC_0/aclk5]
  connect_bd_net -net CIPS_0_ps_ps_noc_rpu_axi0_clk [get_bd_pins CIPS_0/lpd_axi_noc_clk] [get_bd_pins NOC_0/aclk6]
  connect_bd_net -net Din_1 [get_bd_pins CIPS_0/LPD_GPIO_o] [get_bd_pins display_pipe/Din] [get_bd_pins mipi_capture_pipe/Din]
  connect_bd_net -net IDT_8T49N241_LOL_IN_1 [get_bd_ports IDT_8T49N241_LOL_IN] [get_bd_pins display_pipe/IDT_8T49N241_LOL_IN]
  connect_bd_net -net RX_DATA_IN_rxn_1 [get_bd_ports RX_DATA_IN_rxn] [get_bd_pins display_pipe/RX_DATA_IN_rxn]
  connect_bd_net -net RX_DATA_IN_rxp_1 [get_bd_ports RX_DATA_IN_rxp] [get_bd_pins display_pipe/RX_DATA_IN_rxp]
  connect_bd_net -net TX_HPD_IN_1 [get_bd_ports TX_HPD_IN] [get_bd_pins display_pipe/TX_HPD_IN]
  connect_bd_net -net TX_REFCLK_N_IN_1 [get_bd_ports TX_REFCLK_N_IN] [get_bd_pins display_pipe/TX_REFCLK_N_IN]
  connect_bd_net -net TX_REFCLK_P_IN_1 [get_bd_ports TX_REFCLK_P_IN] [get_bd_pins display_pipe/TX_REFCLK_P_IN]
  connect_bd_net -net axi_perf_mon_0_interrupt [get_bd_pins CIPS_0/pl_ps_irq4] [get_bd_pins axi_perf_mon_0/interrupt]
  connect_bd_net -net cap_pipe_Dout [get_bd_ports sensor_gpio_rst] [get_bd_pins mipi_capture_pipe/sensor_gpio_rst]
  connect_bd_net -net clk_wiz_clk_out2 [get_bd_pins CIPS_0/m_axi_fpd_aclk] [get_bd_pins clk_wiz/clk_out2] [get_bd_pins display_pipe/altclk] [get_bd_pins mipi_capture_pipe/s_axi_aclk] [get_bd_pins rst_processor_pl_105Mhz/slowest_sync_clk] [get_bd_pins smartconnect_gp0/aclk]
  connect_bd_net -net clk_wiz_clk_out3 [get_bd_pins NOC_0/aclk9] [get_bd_pins axi_perf_mon_0/core_aclk] [get_bd_pins axi_perf_mon_0/slot_5_axi_aclk] [get_bd_pins clk_wiz/clk_out3] [get_bd_pins mipi_capture_pipe/video_clk] [get_bd_pins rst_processor_pl_200Mhz/slowest_sync_clk] [get_bd_pins smartconnect_gp0/aclk2]
  connect_bd_net -net display_pipe_TX_EN_OUT [get_bd_ports TX_EN_OUT] [get_bd_pins display_pipe/TX_EN_OUT]
  connect_bd_net -net display_pipe_iic2intc_irpt [get_bd_pins CIPS_0/pl_ps_irq3] [get_bd_pins display_pipe/iic2intc_irpt]
  connect_bd_net -net display_pipe_irq [get_bd_pins CIPS_0/pl_ps_irq0] [get_bd_pins display_pipe/irq]
  connect_bd_net -net display_pipe_irq1 [get_bd_pins CIPS_0/pl_ps_irq1] [get_bd_pins display_pipe/irq1]
  connect_bd_net -net display_pipe_txn_0 [get_bd_ports TX_DATA_OUT_txn] [get_bd_pins display_pipe/TX_DATA_OUT_txn]
  connect_bd_net -net display_pipe_txp_0 [get_bd_ports TX_DATA_OUT_txp] [get_bd_pins display_pipe/TX_DATA_OUT_txp]
  connect_bd_net -net display_pipe_vmix_intr [get_bd_pins CIPS_0/pl_ps_irq2] [get_bd_pins display_pipe/vmix_intr]
  connect_bd_net -net mipi_capture_pipe_csirxss_csi_irq [get_bd_pins CIPS_0/pl_ps_irq5] [get_bd_pins mipi_capture_pipe/csirxss_csi_irq]
  connect_bd_net -net mipi_capture_pipe_iic2intc_irpt [get_bd_pins CIPS_0/pl_ps_irq6] [get_bd_pins mipi_capture_pipe/iic2intc_irpt]
  connect_bd_net -net mipi_capture_pipe_interrupt [get_bd_pins CIPS_0/pl_ps_irq7] [get_bd_pins mipi_capture_pipe/interrupt]
  connect_bd_net -net mipi_csi2_rx_dout1 [get_bd_ports sensor_gpio_flash] [get_bd_ports sensor_gpio_spi_cs_n] [get_bd_pins mipi_capture_pipe/sensor_gpio_spi_cs_n]
  connect_bd_net -net net_clk_wiz_locked [get_bd_pins clk_wiz/locked] [get_bd_pins rst_processor_150MHz/dcm_locked] [get_bd_pins rst_processor_pl_105Mhz/dcm_locked] [get_bd_pins rst_processor_pl_200Mhz/dcm_locked]
  connect_bd_net -net net_mb_ss_0_clk_out2 [get_bd_pins CIPS_0/m_axi_lpd_aclk] [get_bd_pins NOC_0/aclk8] [get_bd_pins axi_perf_mon_0/s_axi_aclk] [get_bd_pins axi_perf_mon_0/slot_0_axi_aclk] [get_bd_pins axi_perf_mon_0/slot_1_axi_aclk] [get_bd_pins axi_perf_mon_0/slot_2_axi_aclk] [get_bd_pins axi_perf_mon_0/slot_3_axi_aclk] [get_bd_pins axi_perf_mon_0/slot_4_axi_aclk] [get_bd_pins axi_vip_m0/aclk] [get_bd_pins axi_vip_m1/aclk] [get_bd_pins axi_vip_s0/aclk] [get_bd_pins clk_wiz/clk_out1] [get_bd_pins display_pipe/s_axis_aclk] [get_bd_pins rst_processor_150MHz/slowest_sync_clk] [get_bd_pins smartconnect_accel0/aclk] [get_bd_pins smartconnect_accel1/aclk] [get_bd_pins smartconnect_gp0/aclk1] [get_bd_pins smartconnect_gp2/aclk]
  connect_bd_net -net net_mb_ss_0_dcm_locked [get_bd_pins display_pipe/aresetn1] [get_bd_pins rst_processor_150MHz/peripheral_aresetn]
  connect_bd_net -net net_mb_ss_0_s_axi_aclk [get_bd_pins CIPS_0/pl0_ref_clk] [get_bd_pins clk_wiz/clk_in1]
  connect_bd_net -net rst_processor_1_100M_peripheral_aresetn [get_bd_pins display_pipe/ARESETN] [get_bd_pins mipi_capture_pipe/s_axi_aresetn] [get_bd_pins rst_processor_pl_105Mhz/peripheral_aresetn]
  connect_bd_net -net rst_processor_1_150M_interconnect_aresetn [get_bd_pins axi_perf_mon_0/s_axi_aresetn] [get_bd_pins axi_perf_mon_0/slot_0_axi_aresetn] [get_bd_pins axi_perf_mon_0/slot_1_axi_aresetn] [get_bd_pins axi_perf_mon_0/slot_2_axi_aresetn] [get_bd_pins axi_perf_mon_0/slot_3_axi_aresetn] [get_bd_pins axi_perf_mon_0/slot_4_axi_aresetn] [get_bd_pins axi_vip_m0/aresetn] [get_bd_pins axi_vip_m1/aresetn] [get_bd_pins axi_vip_s0/aresetn] [get_bd_pins display_pipe/sc_aresetn] [get_bd_pins rst_processor_150MHz/interconnect_aresetn] [get_bd_pins smartconnect_accel0/aresetn] [get_bd_pins smartconnect_accel1/aresetn] [get_bd_pins smartconnect_gp2/aresetn]
  connect_bd_net -net rst_processor_pl_200Mhz_peripheral_aresetn [get_bd_pins axi_perf_mon_0/core_aresetn] [get_bd_pins axi_perf_mon_0/slot_5_axi_aresetn] [get_bd_pins mipi_capture_pipe/video_rst_n] [get_bd_pins rst_processor_pl_200Mhz/peripheral_aresetn]
  connect_bd_net -net versal_cips_ss_interconnect_aresetn [get_bd_pins rst_processor_pl_105Mhz/interconnect_aresetn] [get_bd_pins smartconnect_gp0/aresetn]

  # Create address segments
  assign_bd_address -offset 0xA40C0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs mipi_capture_pipe/cap_pipe/ISPPipeline_accel_0/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_AXI_NOC_0] [get_bd_addr_segs NOC_0/S04_AXI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_CCI_NOC_0] [get_bd_addr_segs NOC_0/S00_AXI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_AXI_NOC_1] [get_bd_addr_segs NOC_0/S05_AXI/C1_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_CCI_NOC_1] [get_bd_addr_segs NOC_0/S01_AXI/C1_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/LPD_AXI_NOC_0] [get_bd_addr_segs NOC_0/S06_AXI/C2_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_CCI_NOC_2] [get_bd_addr_segs NOC_0/S02_AXI/C2_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/PMC_NOC_AXI_0] [get_bd_addr_segs NOC_0/S07_AXI/C3_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_CCI_NOC_3] [get_bd_addr_segs NOC_0/S03_AXI/C3_DDR_LOW0] -force
  assign_bd_address -offset 0xA4070000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs mipi_capture_pipe/mipi_csi_rx_ss/axi_iic_1_sensor/S_AXI/Reg] -force
  assign_bd_address -offset 0xA4050000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs axi_perf_mon_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x90000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_LPD] [get_bd_addr_segs axi_vip_s0/S_AXI/Reg] -force
  assign_bd_address -offset 0xA4010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs display_pipe/hdmi_tx_pipe/fmch_axi_iic/S_AXI/Reg] -force
  assign_bd_address -offset 0xA4000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs display_pipe/hdmi_tx_pipe/hdmi_gt_controller_1/axi4lite/Reg] -force
  assign_bd_address -offset 0xA4060000 -range 0x00001000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs mipi_capture_pipe/mipi_csi_rx_ss/mipi_csi2_rx_subsyst_0/csirxss_s_axi/Reg] -force
  assign_bd_address -offset 0xA40D0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs mipi_capture_pipe/cap_pipe/v_frmbuf_wr_0/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA4020000 -range 0x00020000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs display_pipe/hdmi_tx_pipe/v_hdmi_tx_ss_0/S_AXI_CPU_IN/Reg] -force
  assign_bd_address -offset 0xA4040000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs display_pipe/v_mix_0/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA4080000 -range 0x00040000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs mipi_capture_pipe/cap_pipe/v_proc_ss_0/s_axi_ctrl/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_vip_m0/Master_AXI] [get_bd_addr_segs NOC_0/S11_AXI/C3_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_vip_m1/Master_AXI] [get_bd_addr_segs NOC_0/S12_AXI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces display_pipe/v_mix_0/Data_m_axi_mm_video1] [get_bd_addr_segs NOC_0/S08_AXI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces display_pipe/v_mix_0/Data_m_axi_mm_video2] [get_bd_addr_segs NOC_0/S08_AXI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces display_pipe/v_mix_0/Data_m_axi_mm_video5] [get_bd_addr_segs NOC_0/S08_AXI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces display_pipe/v_mix_0/Data_m_axi_mm_video6] [get_bd_addr_segs NOC_0/S08_AXI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces display_pipe/v_mix_0/Data_m_axi_mm_video3] [get_bd_addr_segs NOC_0/S09_AXI/C1_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces display_pipe/v_mix_0/Data_m_axi_mm_video4] [get_bd_addr_segs NOC_0/S09_AXI/C1_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces display_pipe/v_mix_0/Data_m_axi_mm_video7] [get_bd_addr_segs NOC_0/S09_AXI/C1_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces display_pipe/v_mix_0/Data_m_axi_mm_video8] [get_bd_addr_segs NOC_0/S09_AXI/C1_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces display_pipe/v_mix_0/Data_m_axi_mm_video9] [get_bd_addr_segs NOC_0/S10_AXI/C2_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces mipi_capture_pipe/cap_pipe/v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs NOC_0/S13_AXI/C1_DDR_LOW0] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  # Create PFM attributes
  set_property PFM_NAME {xilinx.com:vmk180_dfx_trd_platform1:vmk180_dfx_trd_platform1:1.0} [get_files [current_bd_design].bd]
  set_property PFM.CLOCK {clk_out1 {id "0" is_default "true" proc_sys_reset "/rst_processor_150MHz" status "fixed"} clk_out2 {id "1" is_default "false" proc_sys_reset "/rst_processor_pl_105Mhz" status "fixed"} clk_out3 {id "2" is_default "false" proc_sys_reset "/rst_processor_pl_200Mhz" status "fixed"}} [get_bd_cells /clk_wiz]
  set_property PFM.AXI_PORT {S01_AXI {memport "MIG" sptag "NOC_pl" memory "NOC_0 C0_DDR_LOW0"} S02_AXI {memport "MIG" sptag "NOC_pl" memory "NOC_0 C0_DDR_LOW0"} S03_AXI {memport "MIG" sptag "NOC_pl" memory "NOC_0 C0_DDR_LOW0"} S04_AXI {memport "MIG" sptag "NOC_pl" memory "NOC_0 C0_DDR_LOW0"} S05_AXI {memport "MIG" sptag "NOC_pl" memory "NOC_0 C0_DDR_LOW0"} S06_AXI {memport "MIG" sptag "NOC_pl" memory "NOC_0 C0_DDR_LOW0"} S07_AXI {memport "MIG" sptag "NOC_pl" memory "NOC_0 C0_DDR_LOW0"} S08_AXI {memport "MIG" sptag "NOC_pl" memory "NOC_0 C0_DDR_LOW0"} S09_AXI {memport "MIG" sptag "NOC_pl" memory "NOC_0 C0_DDR_LOW0"} S10_AXI {memport "MIG" sptag "NOC_pl" memory "NOC_0 C0_DDR_LOW0"} S11_AXI {memport "MIG" sptag "NOC_pl" memory "NOC_0 C0_DDR_LOW0"} S12_AXI {memport "MIG" sptag "NOC_pl" memory "NOC_0 C0_DDR_LOW0"} S13_AXI {memport "MIG" sptag "NOC_pl" memory "NOC_0 C0_DDR_LOW0"} S14_AXI {memport "MIG" sptag "NOC_pl" memory "NOC_0 C0_DDR_LOW0"} S15_AXI {memport "MIG" sptag "NOC_pl" memory "NOC_0 C0_DDR_LOW0"}} [get_bd_cells /smartconnect_accel0]
  set_property PFM.AXI_PORT {M01_AXI {memport "M_AXI_GP" sptag "" memory ""} M02_AXI {memport "M_AXI_GP" sptag "" memory ""} M03_AXI {memport "M_AXI_GP" sptag "" memory ""} M04_AXI {memport "M_AXI_GP" sptag "" memory ""} M05_AXI {memport "M_AXI_GP" sptag "" memory ""} M06_AXI {memport "M_AXI_GP" sptag "" memory ""} M07_AXI {memport "M_AXI_GP" sptag "" memory ""} M08_AXI {memport "M_AXI_GP" sptag "" memory ""} M09_AXI {memport "M_AXI_GP" sptag "" memory ""} M10_AXI {memport "M_AXI_GP" sptag "" memory ""} M11_AXI {memport "M_AXI_GP" sptag "" memory ""} M12_AXI {memport "M_AXI_GP" sptag "" memory ""} M13_AXI {memport "M_AXI_GP" sptag "" memory ""} M14_AXI {memport "M_AXI_GP" sptag "" memory ""} M15_AXI {memport "M_AXI_GP" sptag "" memory ""}} [get_bd_cells /smartconnect_gp2]


  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


