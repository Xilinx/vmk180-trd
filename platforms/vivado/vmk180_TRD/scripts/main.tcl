# (C) Copyright 2020 - 2021 Xilinx, Inc.
# SPDX-License-Identifier: Apache-2.0
			  

xhub::refresh_catalog [xhub::get_xstores xilinx_board_store]
xhub::install [xhub::get_xitems xilinx.com:xilinx_board_store:vmk180:*] -quiet

set proj_name vmk180_TRD
set proj_dir project
set bd_tcl_dir ./scripts
set xdc_list {./xdc}
set ip_repo_path  {../iprepo}
set part xcvm1802-vsva2197-2MP-e-S

create_project -name $proj_name -force -dir $proj_dir -part $part

set board_lat [ get_board_parts -latest_file_version  {*vmk180:*} ]
set_property board_part $board_lat [current_project]


import_files -fileset constrs_1 $xdc_list
        
set_property ip_repo_paths $ip_repo_path [current_project] 
update_ip_catalog

# Create block diagram design and set as current design
set design_name $proj_name
create_bd_design $proj_name
current_bd_design $proj_name

# Set current bd instance as root of current design
set parentCell [get_bd_cells /]
set parentObj [get_bd_cells $parentCell]
current_bd_instance $parentObj

 
source $bd_tcl_dir/config_bd.tcl
save_bd_design
    

make_wrapper -files [get_files ${proj_dir}/${proj_name}.srcs/sources_1/bd/$proj_name/${proj_name}.bd] -top
import_files -force -norecurse ${proj_dir}/${proj_name}.srcs/sources_1/bd/$proj_name/hdl/${proj_name}_wrapper.v
update_compile_order
set_property top ${proj_name}_wrapper [current_fileset]
set_msg_config -id "Vivado 12-4739" -suppress
set_msg_config -id "Common 17-69" -suppress 
set_msg_config -suppress -id {Ipconfig 75-169}
update_compile_order -fileset sources_1
        

save_bd_design
validate_bd_design

file mkdir ${proj_dir}/${proj_name}.sdk             

# set properties for XSA Export
set_property platform.vendor  "xilinx.com" [current_project]
set_property platform.board_id $proj_name [current_project]
set_property platform.name  $proj_name [current_project]
set_property platform.version "1.0" [current_project]                            
set_property platform.default_output_type "xclbin" [current_project]
set_property platform.design_intent.server_managed false [current_project]
set_property platform.design_intent.external_host false [current_project]
set_property platform.design_intent.datacenter false [current_project]
set_property platform.design_intent.embedded true [current_project]
set_property platform.platform_state "pre_synth" [current_project]  

source ../runs.tcl
