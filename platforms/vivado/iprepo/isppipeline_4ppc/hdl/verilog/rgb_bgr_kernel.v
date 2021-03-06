// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.2
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module rgb_bgr_kernel (
        ap_clk,
        ap_rst,
        imgblock_0_0_V_read,
        imgblock_0_1_V_read,
        imgblock_0_2_V_read,
        imgblock_0_3_V_read,
        imgblock_0_4_V_read,
        imgblock_0_5_V_read,
        imgblock_0_6_V_read,
        imgblock_0_7_V_read,
        imgblock_0_8_V_read,
        imgblock_0_9_V_read,
        imgblock_1_0_V_read,
        imgblock_1_1_V_read,
        imgblock_1_2_V_read,
        imgblock_1_3_V_read,
        imgblock_1_4_V_read,
        imgblock_1_5_V_read,
        imgblock_1_6_V_read,
        imgblock_1_7_V_read,
        imgblock_1_8_V_read,
        imgblock_1_9_V_read,
        imgblock_2_0_V_read,
        imgblock_2_1_V_read,
        imgblock_2_2_V_read,
        imgblock_2_3_V_read,
        imgblock_2_4_V_read,
        imgblock_2_5_V_read,
        imgblock_2_6_V_read,
        imgblock_2_7_V_read,
        imgblock_2_8_V_read,
        imgblock_2_9_V_read,
        imgblock_3_0_V_read,
        imgblock_3_1_V_read,
        imgblock_3_2_V_read,
        imgblock_3_3_V_read,
        imgblock_3_4_V_read,
        imgblock_3_5_V_read,
        imgblock_3_6_V_read,
        imgblock_3_7_V_read,
        imgblock_3_8_V_read,
        imgblock_3_9_V_read,
        imgblock_4_0_V_read,
        imgblock_4_1_V_read,
        imgblock_4_2_V_read,
        imgblock_4_3_V_read,
        imgblock_4_4_V_read,
        imgblock_4_5_V_read,
        imgblock_4_6_V_read,
        imgblock_4_7_V_read,
        imgblock_4_8_V_read,
        imgblock_4_9_V_read,
        loop_r,
        ap_return,
        ap_ce
);


input   ap_clk;
input   ap_rst;
input  [9:0] imgblock_0_0_V_read;
input  [9:0] imgblock_0_1_V_read;
input  [9:0] imgblock_0_2_V_read;
input  [9:0] imgblock_0_3_V_read;
input  [9:0] imgblock_0_4_V_read;
input  [9:0] imgblock_0_5_V_read;
input  [9:0] imgblock_0_6_V_read;
input  [9:0] imgblock_0_7_V_read;
input  [9:0] imgblock_0_8_V_read;
input  [9:0] imgblock_0_9_V_read;
input  [9:0] imgblock_1_0_V_read;
input  [9:0] imgblock_1_1_V_read;
input  [9:0] imgblock_1_2_V_read;
input  [9:0] imgblock_1_3_V_read;
input  [9:0] imgblock_1_4_V_read;
input  [9:0] imgblock_1_5_V_read;
input  [9:0] imgblock_1_6_V_read;
input  [9:0] imgblock_1_7_V_read;
input  [9:0] imgblock_1_8_V_read;
input  [9:0] imgblock_1_9_V_read;
input  [9:0] imgblock_2_0_V_read;
input  [9:0] imgblock_2_1_V_read;
input  [9:0] imgblock_2_2_V_read;
input  [9:0] imgblock_2_3_V_read;
input  [9:0] imgblock_2_4_V_read;
input  [9:0] imgblock_2_5_V_read;
input  [9:0] imgblock_2_6_V_read;
input  [9:0] imgblock_2_7_V_read;
input  [9:0] imgblock_2_8_V_read;
input  [9:0] imgblock_2_9_V_read;
input  [9:0] imgblock_3_0_V_read;
input  [9:0] imgblock_3_1_V_read;
input  [9:0] imgblock_3_2_V_read;
input  [9:0] imgblock_3_3_V_read;
input  [9:0] imgblock_3_4_V_read;
input  [9:0] imgblock_3_5_V_read;
input  [9:0] imgblock_3_6_V_read;
input  [9:0] imgblock_3_7_V_read;
input  [9:0] imgblock_3_8_V_read;
input  [9:0] imgblock_3_9_V_read;
input  [9:0] imgblock_4_0_V_read;
input  [9:0] imgblock_4_1_V_read;
input  [9:0] imgblock_4_2_V_read;
input  [9:0] imgblock_4_3_V_read;
input  [9:0] imgblock_4_4_V_read;
input  [9:0] imgblock_4_5_V_read;
input  [9:0] imgblock_4_6_V_read;
input  [9:0] imgblock_4_7_V_read;
input  [9:0] imgblock_4_8_V_read;
input  [9:0] imgblock_4_9_V_read;
input  [1:0] loop_r;
output  [13:0] ap_return;
input   ap_ce;

reg   [9:0] t1_reg_1036;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
wire    ap_block_pp0_stage0_11001;
wire   [11:0] ret_V_6_fu_716_p2;
reg   [11:0] ret_V_6_reg_1041;
wire   [10:0] add_ln1353_10_fu_782_p2;
reg   [10:0] add_ln1353_10_reg_1046;
wire   [13:0] add_ln114_fu_918_p2;
reg   [13:0] add_ln114_reg_1051;
wire   [14:0] res_fu_956_p2;
reg   [14:0] res_reg_1056;
wire    ap_block_pp0_stage0;
wire   [3:0] tmp_s_fu_454_p11;
wire   [9:0] tmp_s_fu_454_p12;
wire   [2:0] or_ln_fu_488_p3;
wire   [3:0] tmp_46_fu_500_p11;
wire   [9:0] tmp_46_fu_500_p12;
wire   [10:0] lhs_V_fu_480_p1;
wire   [10:0] rhs_V_fu_526_p1;
wire   [10:0] ret_V_fu_530_p2;
wire   [2:0] zext_ln215_fu_484_p1;
wire   [2:0] add_ln215_fu_546_p2;
wire   [3:0] zext_ln215_17_fu_552_p1;
wire   [9:0] tmp_47_fu_556_p12;
wire   [2:0] add_ln215_3_fu_586_p2;
wire   [3:0] zext_ln215_19_fu_592_p1;
wire   [9:0] tmp_48_fu_596_p12;
wire   [10:0] lhs_V_4_fu_582_p1;
wire   [10:0] rhs_V_3_fu_622_p1;
wire   [10:0] ret_V_5_fu_626_p2;
wire   [2:0] add_ln215_4_fu_636_p2;
wire   [3:0] zext_ln215_22_fu_642_p1;
wire   [9:0] tmp_49_fu_646_p12;
wire   [9:0] tmp_50_fu_676_p12;
wire   [10:0] zext_ln1353_28_fu_702_p1;
wire   [10:0] zext_ln215_23_fu_672_p1;
wire   [10:0] add_ln1353_fu_706_p2;
wire   [11:0] lhs_V_5_fu_632_p1;
wire   [11:0] zext_ln1353_29_fu_712_p1;
wire   [9:0] tmp_fu_722_p12;
wire   [9:0] tmp_51_fu_752_p12;
wire   [10:0] zext_ln1353_30_fu_778_p1;
wire   [10:0] zext_ln215_24_fu_748_p1;
wire   [9:0] tmp_52_fu_788_p12;
wire   [9:0] tmp_53_fu_818_p12;
wire   [10:0] lhs_V_6_fu_814_p1;
wire   [10:0] rhs_V_4_fu_844_p1;
wire   [10:0] ret_V_8_fu_848_p2;
wire   [12:0] t3_fu_854_p3;
wire   [9:0] tmp_54_fu_866_p12;
wire   [11:0] shl_ln_fu_896_p3;
wire   [12:0] zext_ln113_fu_892_p1;
wire   [12:0] zext_ln113_1_fu_904_p1;
wire   [12:0] t4_fu_908_p2;
wire   [13:0] zext_ln113_2_fu_914_p1;
wire   [13:0] zext_ln112_fu_862_p1;
wire   [12:0] zext_ln1353_fu_927_p1;
wire   [12:0] zext_ln1353_31_fu_930_p1;
wire   [12:0] ret_V_7_fu_933_p2;
wire   [13:0] zext_ln108_fu_924_p1;
wire   [13:0] zext_ln109_fu_939_p1;
wire   [13:0] sub_ln114_fu_943_p2;
wire  signed [14:0] sext_ln114_fu_949_p1;
wire   [14:0] zext_ln114_fu_953_p1;
wire   [14:0] sub_ln115_fu_969_p2;
wire   [11:0] trunc_ln115_3_fu_974_p4;
wire  signed [12:0] sext_ln115_fu_984_p1;
wire   [13:0] zext_ln115_fu_988_p1;
wire   [11:0] trunc_ln115_4_fu_998_p4;
wire  signed [12:0] sext_ln115_1_fu_1007_p1;
wire   [0:0] tmp_136_fu_962_p3;
wire   [13:0] sub_ln115_1_fu_992_p2;
wire   [13:0] zext_ln115_1_fu_1011_p1;
wire   [0:0] icmp_ln116_fu_1023_p2;
wire   [13:0] select_ln115_fu_1015_p3;
reg   [9:0] imgblock_0_0_V_read_int_reg;
reg   [9:0] imgblock_0_1_V_read_int_reg;
reg   [9:0] imgblock_0_2_V_read_int_reg;
reg   [9:0] imgblock_0_3_V_read_int_reg;
reg   [9:0] imgblock_0_4_V_read_int_reg;
reg   [9:0] imgblock_0_5_V_read_int_reg;
reg   [9:0] imgblock_0_6_V_read_int_reg;
reg   [9:0] imgblock_0_7_V_read_int_reg;
reg   [9:0] imgblock_0_8_V_read_int_reg;
reg   [9:0] imgblock_0_9_V_read_int_reg;
reg   [9:0] imgblock_1_0_V_read_int_reg;
reg   [9:0] imgblock_1_1_V_read_int_reg;
reg   [9:0] imgblock_1_2_V_read_int_reg;
reg   [9:0] imgblock_1_3_V_read_int_reg;
reg   [9:0] imgblock_1_4_V_read_int_reg;
reg   [9:0] imgblock_1_5_V_read_int_reg;
reg   [9:0] imgblock_1_6_V_read_int_reg;
reg   [9:0] imgblock_1_7_V_read_int_reg;
reg   [9:0] imgblock_1_8_V_read_int_reg;
reg   [9:0] imgblock_1_9_V_read_int_reg;
reg   [9:0] imgblock_2_0_V_read_int_reg;
reg   [9:0] imgblock_2_1_V_read_int_reg;
reg   [9:0] imgblock_2_2_V_read_int_reg;
reg   [9:0] imgblock_2_3_V_read_int_reg;
reg   [9:0] imgblock_2_4_V_read_int_reg;
reg   [9:0] imgblock_2_5_V_read_int_reg;
reg   [9:0] imgblock_2_6_V_read_int_reg;
reg   [9:0] imgblock_2_7_V_read_int_reg;
reg   [9:0] imgblock_2_8_V_read_int_reg;
reg   [9:0] imgblock_2_9_V_read_int_reg;
reg   [9:0] imgblock_3_0_V_read_int_reg;
reg   [9:0] imgblock_3_1_V_read_int_reg;
reg   [9:0] imgblock_3_2_V_read_int_reg;
reg   [9:0] imgblock_3_3_V_read_int_reg;
reg   [9:0] imgblock_3_4_V_read_int_reg;
reg   [9:0] imgblock_3_5_V_read_int_reg;
reg   [9:0] imgblock_3_6_V_read_int_reg;
reg   [9:0] imgblock_3_7_V_read_int_reg;
reg   [9:0] imgblock_3_8_V_read_int_reg;
reg   [9:0] imgblock_3_9_V_read_int_reg;
reg   [9:0] imgblock_4_0_V_read_int_reg;
reg   [9:0] imgblock_4_1_V_read_int_reg;
reg   [9:0] imgblock_4_2_V_read_int_reg;
reg   [9:0] imgblock_4_3_V_read_int_reg;
reg   [9:0] imgblock_4_4_V_read_int_reg;
reg   [9:0] imgblock_4_5_V_read_int_reg;
reg   [9:0] imgblock_4_6_V_read_int_reg;
reg   [9:0] imgblock_4_7_V_read_int_reg;
reg   [9:0] imgblock_4_8_V_read_int_reg;
reg   [9:0] imgblock_4_9_V_read_int_reg;
reg   [1:0] loop_r_int_reg;

ISPPipeline_accelkbM #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 10 ),
    .din1_WIDTH( 10 ),
    .din2_WIDTH( 10 ),
    .din3_WIDTH( 10 ),
    .din4_WIDTH( 10 ),
    .din5_WIDTH( 10 ),
    .din6_WIDTH( 10 ),
    .din7_WIDTH( 10 ),
    .din8_WIDTH( 10 ),
    .din9_WIDTH( 10 ),
    .din10_WIDTH( 4 ),
    .dout_WIDTH( 10 ))
ISPPipeline_accelkbM_U223(
    .din0(imgblock_2_0_V_read_int_reg),
    .din1(imgblock_2_1_V_read_int_reg),
    .din2(imgblock_2_2_V_read_int_reg),
    .din3(imgblock_2_3_V_read_int_reg),
    .din4(imgblock_2_4_V_read_int_reg),
    .din5(imgblock_2_5_V_read_int_reg),
    .din6(imgblock_2_6_V_read_int_reg),
    .din7(imgblock_2_7_V_read_int_reg),
    .din8(imgblock_2_8_V_read_int_reg),
    .din9(imgblock_2_9_V_read_int_reg),
    .din10(tmp_s_fu_454_p11),
    .dout(tmp_s_fu_454_p12)
);

ISPPipeline_accelkbM #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 10 ),
    .din1_WIDTH( 10 ),
    .din2_WIDTH( 10 ),
    .din3_WIDTH( 10 ),
    .din4_WIDTH( 10 ),
    .din5_WIDTH( 10 ),
    .din6_WIDTH( 10 ),
    .din7_WIDTH( 10 ),
    .din8_WIDTH( 10 ),
    .din9_WIDTH( 10 ),
    .din10_WIDTH( 4 ),
    .dout_WIDTH( 10 ))
ISPPipeline_accelkbM_U224(
    .din0(imgblock_2_0_V_read_int_reg),
    .din1(imgblock_2_1_V_read_int_reg),
    .din2(imgblock_2_2_V_read_int_reg),
    .din3(imgblock_2_3_V_read_int_reg),
    .din4(imgblock_2_4_V_read_int_reg),
    .din5(imgblock_2_5_V_read_int_reg),
    .din6(imgblock_2_6_V_read_int_reg),
    .din7(imgblock_2_7_V_read_int_reg),
    .din8(imgblock_2_8_V_read_int_reg),
    .din9(imgblock_2_9_V_read_int_reg),
    .din10(tmp_46_fu_500_p11),
    .dout(tmp_46_fu_500_p12)
);

ISPPipeline_accelkbM #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 10 ),
    .din1_WIDTH( 10 ),
    .din2_WIDTH( 10 ),
    .din3_WIDTH( 10 ),
    .din4_WIDTH( 10 ),
    .din5_WIDTH( 10 ),
    .din6_WIDTH( 10 ),
    .din7_WIDTH( 10 ),
    .din8_WIDTH( 10 ),
    .din9_WIDTH( 10 ),
    .din10_WIDTH( 4 ),
    .dout_WIDTH( 10 ))
ISPPipeline_accelkbM_U225(
    .din0(imgblock_0_0_V_read_int_reg),
    .din1(imgblock_0_1_V_read_int_reg),
    .din2(imgblock_0_2_V_read_int_reg),
    .din3(imgblock_0_3_V_read_int_reg),
    .din4(imgblock_0_4_V_read_int_reg),
    .din5(imgblock_0_5_V_read_int_reg),
    .din6(imgblock_0_6_V_read_int_reg),
    .din7(imgblock_0_7_V_read_int_reg),
    .din8(imgblock_0_8_V_read_int_reg),
    .din9(imgblock_0_9_V_read_int_reg),
    .din10(zext_ln215_17_fu_552_p1),
    .dout(tmp_47_fu_556_p12)
);

ISPPipeline_accelkbM #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 10 ),
    .din1_WIDTH( 10 ),
    .din2_WIDTH( 10 ),
    .din3_WIDTH( 10 ),
    .din4_WIDTH( 10 ),
    .din5_WIDTH( 10 ),
    .din6_WIDTH( 10 ),
    .din7_WIDTH( 10 ),
    .din8_WIDTH( 10 ),
    .din9_WIDTH( 10 ),
    .din10_WIDTH( 4 ),
    .dout_WIDTH( 10 ))
ISPPipeline_accelkbM_U226(
    .din0(imgblock_1_0_V_read_int_reg),
    .din1(imgblock_1_1_V_read_int_reg),
    .din2(imgblock_1_2_V_read_int_reg),
    .din3(imgblock_1_3_V_read_int_reg),
    .din4(imgblock_1_4_V_read_int_reg),
    .din5(imgblock_1_5_V_read_int_reg),
    .din6(imgblock_1_6_V_read_int_reg),
    .din7(imgblock_1_7_V_read_int_reg),
    .din8(imgblock_1_8_V_read_int_reg),
    .din9(imgblock_1_9_V_read_int_reg),
    .din10(zext_ln215_19_fu_592_p1),
    .dout(tmp_48_fu_596_p12)
);

ISPPipeline_accelkbM #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 10 ),
    .din1_WIDTH( 10 ),
    .din2_WIDTH( 10 ),
    .din3_WIDTH( 10 ),
    .din4_WIDTH( 10 ),
    .din5_WIDTH( 10 ),
    .din6_WIDTH( 10 ),
    .din7_WIDTH( 10 ),
    .din8_WIDTH( 10 ),
    .din9_WIDTH( 10 ),
    .din10_WIDTH( 4 ),
    .dout_WIDTH( 10 ))
ISPPipeline_accelkbM_U227(
    .din0(imgblock_1_0_V_read_int_reg),
    .din1(imgblock_1_1_V_read_int_reg),
    .din2(imgblock_1_2_V_read_int_reg),
    .din3(imgblock_1_3_V_read_int_reg),
    .din4(imgblock_1_4_V_read_int_reg),
    .din5(imgblock_1_5_V_read_int_reg),
    .din6(imgblock_1_6_V_read_int_reg),
    .din7(imgblock_1_7_V_read_int_reg),
    .din8(imgblock_1_8_V_read_int_reg),
    .din9(imgblock_1_9_V_read_int_reg),
    .din10(zext_ln215_22_fu_642_p1),
    .dout(tmp_49_fu_646_p12)
);

ISPPipeline_accelkbM #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 10 ),
    .din1_WIDTH( 10 ),
    .din2_WIDTH( 10 ),
    .din3_WIDTH( 10 ),
    .din4_WIDTH( 10 ),
    .din5_WIDTH( 10 ),
    .din6_WIDTH( 10 ),
    .din7_WIDTH( 10 ),
    .din8_WIDTH( 10 ),
    .din9_WIDTH( 10 ),
    .din10_WIDTH( 4 ),
    .dout_WIDTH( 10 ))
ISPPipeline_accelkbM_U228(
    .din0(imgblock_3_0_V_read_int_reg),
    .din1(imgblock_3_1_V_read_int_reg),
    .din2(imgblock_3_2_V_read_int_reg),
    .din3(imgblock_3_3_V_read_int_reg),
    .din4(imgblock_3_4_V_read_int_reg),
    .din5(imgblock_3_5_V_read_int_reg),
    .din6(imgblock_3_6_V_read_int_reg),
    .din7(imgblock_3_7_V_read_int_reg),
    .din8(imgblock_3_8_V_read_int_reg),
    .din9(imgblock_3_9_V_read_int_reg),
    .din10(zext_ln215_19_fu_592_p1),
    .dout(tmp_50_fu_676_p12)
);

ISPPipeline_accelkbM #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 10 ),
    .din1_WIDTH( 10 ),
    .din2_WIDTH( 10 ),
    .din3_WIDTH( 10 ),
    .din4_WIDTH( 10 ),
    .din5_WIDTH( 10 ),
    .din6_WIDTH( 10 ),
    .din7_WIDTH( 10 ),
    .din8_WIDTH( 10 ),
    .din9_WIDTH( 10 ),
    .din10_WIDTH( 4 ),
    .dout_WIDTH( 10 ))
ISPPipeline_accelkbM_U229(
    .din0(imgblock_3_0_V_read_int_reg),
    .din1(imgblock_3_1_V_read_int_reg),
    .din2(imgblock_3_2_V_read_int_reg),
    .din3(imgblock_3_3_V_read_int_reg),
    .din4(imgblock_3_4_V_read_int_reg),
    .din5(imgblock_3_5_V_read_int_reg),
    .din6(imgblock_3_6_V_read_int_reg),
    .din7(imgblock_3_7_V_read_int_reg),
    .din8(imgblock_3_8_V_read_int_reg),
    .din9(imgblock_3_9_V_read_int_reg),
    .din10(zext_ln215_22_fu_642_p1),
    .dout(tmp_fu_722_p12)
);

ISPPipeline_accelkbM #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 10 ),
    .din1_WIDTH( 10 ),
    .din2_WIDTH( 10 ),
    .din3_WIDTH( 10 ),
    .din4_WIDTH( 10 ),
    .din5_WIDTH( 10 ),
    .din6_WIDTH( 10 ),
    .din7_WIDTH( 10 ),
    .din8_WIDTH( 10 ),
    .din9_WIDTH( 10 ),
    .din10_WIDTH( 4 ),
    .dout_WIDTH( 10 ))
ISPPipeline_accelkbM_U230(
    .din0(imgblock_4_0_V_read_int_reg),
    .din1(imgblock_4_1_V_read_int_reg),
    .din2(imgblock_4_2_V_read_int_reg),
    .din3(imgblock_4_3_V_read_int_reg),
    .din4(imgblock_4_4_V_read_int_reg),
    .din5(imgblock_4_5_V_read_int_reg),
    .din6(imgblock_4_6_V_read_int_reg),
    .din7(imgblock_4_7_V_read_int_reg),
    .din8(imgblock_4_8_V_read_int_reg),
    .din9(imgblock_4_9_V_read_int_reg),
    .din10(zext_ln215_17_fu_552_p1),
    .dout(tmp_51_fu_752_p12)
);

ISPPipeline_accelkbM #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 10 ),
    .din1_WIDTH( 10 ),
    .din2_WIDTH( 10 ),
    .din3_WIDTH( 10 ),
    .din4_WIDTH( 10 ),
    .din5_WIDTH( 10 ),
    .din6_WIDTH( 10 ),
    .din7_WIDTH( 10 ),
    .din8_WIDTH( 10 ),
    .din9_WIDTH( 10 ),
    .din10_WIDTH( 4 ),
    .dout_WIDTH( 10 ))
ISPPipeline_accelkbM_U231(
    .din0(imgblock_1_0_V_read_int_reg),
    .din1(imgblock_1_1_V_read_int_reg),
    .din2(imgblock_1_2_V_read_int_reg),
    .din3(imgblock_1_3_V_read_int_reg),
    .din4(imgblock_1_4_V_read_int_reg),
    .din5(imgblock_1_5_V_read_int_reg),
    .din6(imgblock_1_6_V_read_int_reg),
    .din7(imgblock_1_7_V_read_int_reg),
    .din8(imgblock_1_8_V_read_int_reg),
    .din9(imgblock_1_9_V_read_int_reg),
    .din10(zext_ln215_17_fu_552_p1),
    .dout(tmp_52_fu_788_p12)
);

ISPPipeline_accelkbM #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 10 ),
    .din1_WIDTH( 10 ),
    .din2_WIDTH( 10 ),
    .din3_WIDTH( 10 ),
    .din4_WIDTH( 10 ),
    .din5_WIDTH( 10 ),
    .din6_WIDTH( 10 ),
    .din7_WIDTH( 10 ),
    .din8_WIDTH( 10 ),
    .din9_WIDTH( 10 ),
    .din10_WIDTH( 4 ),
    .dout_WIDTH( 10 ))
ISPPipeline_accelkbM_U232(
    .din0(imgblock_3_0_V_read_int_reg),
    .din1(imgblock_3_1_V_read_int_reg),
    .din2(imgblock_3_2_V_read_int_reg),
    .din3(imgblock_3_3_V_read_int_reg),
    .din4(imgblock_3_4_V_read_int_reg),
    .din5(imgblock_3_5_V_read_int_reg),
    .din6(imgblock_3_6_V_read_int_reg),
    .din7(imgblock_3_7_V_read_int_reg),
    .din8(imgblock_3_8_V_read_int_reg),
    .din9(imgblock_3_9_V_read_int_reg),
    .din10(zext_ln215_17_fu_552_p1),
    .dout(tmp_53_fu_818_p12)
);

ISPPipeline_accelkbM #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 10 ),
    .din1_WIDTH( 10 ),
    .din2_WIDTH( 10 ),
    .din3_WIDTH( 10 ),
    .din4_WIDTH( 10 ),
    .din5_WIDTH( 10 ),
    .din6_WIDTH( 10 ),
    .din7_WIDTH( 10 ),
    .din8_WIDTH( 10 ),
    .din9_WIDTH( 10 ),
    .din10_WIDTH( 4 ),
    .dout_WIDTH( 10 ))
ISPPipeline_accelkbM_U233(
    .din0(imgblock_2_0_V_read_int_reg),
    .din1(imgblock_2_1_V_read_int_reg),
    .din2(imgblock_2_2_V_read_int_reg),
    .din3(imgblock_2_3_V_read_int_reg),
    .din4(imgblock_2_4_V_read_int_reg),
    .din5(imgblock_2_5_V_read_int_reg),
    .din6(imgblock_2_6_V_read_int_reg),
    .din7(imgblock_2_7_V_read_int_reg),
    .din8(imgblock_2_8_V_read_int_reg),
    .din9(imgblock_2_9_V_read_int_reg),
    .din10(zext_ln215_17_fu_552_p1),
    .dout(tmp_54_fu_866_p12)
);

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_ce))) begin
        add_ln114_reg_1051 <= add_ln114_fu_918_p2;
        add_ln1353_10_reg_1046 <= add_ln1353_10_fu_782_p2;
        res_reg_1056 <= res_fu_956_p2;
        ret_V_6_reg_1041 <= ret_V_6_fu_716_p2;
        t1_reg_1036 <= {{ret_V_fu_530_p2[10:1]}};
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_ce)) begin
        imgblock_0_0_V_read_int_reg <= imgblock_0_0_V_read;
        imgblock_0_1_V_read_int_reg <= imgblock_0_1_V_read;
        imgblock_0_2_V_read_int_reg <= imgblock_0_2_V_read;
        imgblock_0_3_V_read_int_reg <= imgblock_0_3_V_read;
        imgblock_0_4_V_read_int_reg <= imgblock_0_4_V_read;
        imgblock_0_5_V_read_int_reg <= imgblock_0_5_V_read;
        imgblock_0_6_V_read_int_reg <= imgblock_0_6_V_read;
        imgblock_0_7_V_read_int_reg <= imgblock_0_7_V_read;
        imgblock_0_8_V_read_int_reg <= imgblock_0_8_V_read;
        imgblock_0_9_V_read_int_reg <= imgblock_0_9_V_read;
        imgblock_1_0_V_read_int_reg <= imgblock_1_0_V_read;
        imgblock_1_1_V_read_int_reg <= imgblock_1_1_V_read;
        imgblock_1_2_V_read_int_reg <= imgblock_1_2_V_read;
        imgblock_1_3_V_read_int_reg <= imgblock_1_3_V_read;
        imgblock_1_4_V_read_int_reg <= imgblock_1_4_V_read;
        imgblock_1_5_V_read_int_reg <= imgblock_1_5_V_read;
        imgblock_1_6_V_read_int_reg <= imgblock_1_6_V_read;
        imgblock_1_7_V_read_int_reg <= imgblock_1_7_V_read;
        imgblock_1_8_V_read_int_reg <= imgblock_1_8_V_read;
        imgblock_1_9_V_read_int_reg <= imgblock_1_9_V_read;
        imgblock_2_0_V_read_int_reg <= imgblock_2_0_V_read;
        imgblock_2_1_V_read_int_reg <= imgblock_2_1_V_read;
        imgblock_2_2_V_read_int_reg <= imgblock_2_2_V_read;
        imgblock_2_3_V_read_int_reg <= imgblock_2_3_V_read;
        imgblock_2_4_V_read_int_reg <= imgblock_2_4_V_read;
        imgblock_2_5_V_read_int_reg <= imgblock_2_5_V_read;
        imgblock_2_6_V_read_int_reg <= imgblock_2_6_V_read;
        imgblock_2_7_V_read_int_reg <= imgblock_2_7_V_read;
        imgblock_2_8_V_read_int_reg <= imgblock_2_8_V_read;
        imgblock_2_9_V_read_int_reg <= imgblock_2_9_V_read;
        imgblock_3_0_V_read_int_reg <= imgblock_3_0_V_read;
        imgblock_3_1_V_read_int_reg <= imgblock_3_1_V_read;
        imgblock_3_2_V_read_int_reg <= imgblock_3_2_V_read;
        imgblock_3_3_V_read_int_reg <= imgblock_3_3_V_read;
        imgblock_3_4_V_read_int_reg <= imgblock_3_4_V_read;
        imgblock_3_5_V_read_int_reg <= imgblock_3_5_V_read;
        imgblock_3_6_V_read_int_reg <= imgblock_3_6_V_read;
        imgblock_3_7_V_read_int_reg <= imgblock_3_7_V_read;
        imgblock_3_8_V_read_int_reg <= imgblock_3_8_V_read;
        imgblock_3_9_V_read_int_reg <= imgblock_3_9_V_read;
        imgblock_4_0_V_read_int_reg <= imgblock_4_0_V_read;
        imgblock_4_1_V_read_int_reg <= imgblock_4_1_V_read;
        imgblock_4_2_V_read_int_reg <= imgblock_4_2_V_read;
        imgblock_4_3_V_read_int_reg <= imgblock_4_3_V_read;
        imgblock_4_4_V_read_int_reg <= imgblock_4_4_V_read;
        imgblock_4_5_V_read_int_reg <= imgblock_4_5_V_read;
        imgblock_4_6_V_read_int_reg <= imgblock_4_6_V_read;
        imgblock_4_7_V_read_int_reg <= imgblock_4_7_V_read;
        imgblock_4_8_V_read_int_reg <= imgblock_4_8_V_read;
        imgblock_4_9_V_read_int_reg <= imgblock_4_9_V_read;
        loop_r_int_reg <= loop_r;
    end
end

assign add_ln114_fu_918_p2 = (zext_ln113_2_fu_914_p1 + zext_ln112_fu_862_p1);

assign add_ln1353_10_fu_782_p2 = (zext_ln1353_30_fu_778_p1 + zext_ln215_24_fu_748_p1);

assign add_ln1353_fu_706_p2 = (zext_ln1353_28_fu_702_p1 + zext_ln215_23_fu_672_p1);

assign add_ln215_3_fu_586_p2 = (zext_ln215_fu_484_p1 + 3'd1);

assign add_ln215_4_fu_636_p2 = (zext_ln215_fu_484_p1 + 3'd3);

assign add_ln215_fu_546_p2 = (zext_ln215_fu_484_p1 + 3'd2);

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_return = ((icmp_ln116_fu_1023_p2[0:0] === 1'b1) ? 14'd0 : select_ln115_fu_1015_p3);

assign icmp_ln116_fu_1023_p2 = (($signed(res_reg_1056) < $signed(15'd32761)) ? 1'b1 : 1'b0);

assign lhs_V_4_fu_582_p1 = tmp_47_fu_556_p12;

assign lhs_V_5_fu_632_p1 = ret_V_5_fu_626_p2;

assign lhs_V_6_fu_814_p1 = tmp_52_fu_788_p12;

assign lhs_V_fu_480_p1 = tmp_s_fu_454_p12;

assign or_ln_fu_488_p3 = {{1'd1}, {loop_r_int_reg}};

assign res_fu_956_p2 = ($signed(sext_ln114_fu_949_p1) + $signed(zext_ln114_fu_953_p1));

assign ret_V_5_fu_626_p2 = (lhs_V_4_fu_582_p1 + rhs_V_3_fu_622_p1);

assign ret_V_6_fu_716_p2 = (lhs_V_5_fu_632_p1 + zext_ln1353_29_fu_712_p1);

assign ret_V_7_fu_933_p2 = (zext_ln1353_fu_927_p1 + zext_ln1353_31_fu_930_p1);

assign ret_V_8_fu_848_p2 = (lhs_V_6_fu_814_p1 + rhs_V_4_fu_844_p1);

assign ret_V_fu_530_p2 = (lhs_V_fu_480_p1 + rhs_V_fu_526_p1);

assign rhs_V_3_fu_622_p1 = tmp_48_fu_596_p12;

assign rhs_V_4_fu_844_p1 = tmp_53_fu_818_p12;

assign rhs_V_fu_526_p1 = tmp_46_fu_500_p12;

assign select_ln115_fu_1015_p3 = ((tmp_136_fu_962_p3[0:0] === 1'b1) ? sub_ln115_1_fu_992_p2 : zext_ln115_1_fu_1011_p1);

assign sext_ln114_fu_949_p1 = $signed(sub_ln114_fu_943_p2);

assign sext_ln115_1_fu_1007_p1 = $signed(trunc_ln115_4_fu_998_p4);

assign sext_ln115_fu_984_p1 = $signed(trunc_ln115_3_fu_974_p4);

assign shl_ln_fu_896_p3 = {{tmp_54_fu_866_p12}, {2'd0}};

assign sub_ln114_fu_943_p2 = (zext_ln108_fu_924_p1 - zext_ln109_fu_939_p1);

assign sub_ln115_1_fu_992_p2 = (14'd0 - zext_ln115_fu_988_p1);

assign sub_ln115_fu_969_p2 = (15'd0 - res_reg_1056);

assign t3_fu_854_p3 = {{ret_V_8_fu_848_p2}, {2'd0}};

assign t4_fu_908_p2 = (zext_ln113_fu_892_p1 + zext_ln113_1_fu_904_p1);

assign tmp_136_fu_962_p3 = res_reg_1056[32'd14];

assign tmp_46_fu_500_p11 = or_ln_fu_488_p3;

assign tmp_s_fu_454_p11 = loop_r_int_reg;

assign trunc_ln115_3_fu_974_p4 = {{sub_ln115_fu_969_p2[14:3]}};

assign trunc_ln115_4_fu_998_p4 = {{res_reg_1056[14:3]}};

assign zext_ln108_fu_924_p1 = t1_reg_1036;

assign zext_ln109_fu_939_p1 = ret_V_7_fu_933_p2;

assign zext_ln112_fu_862_p1 = t3_fu_854_p3;

assign zext_ln113_1_fu_904_p1 = shl_ln_fu_896_p3;

assign zext_ln113_2_fu_914_p1 = t4_fu_908_p2;

assign zext_ln113_fu_892_p1 = tmp_54_fu_866_p12;

assign zext_ln114_fu_953_p1 = add_ln114_reg_1051;

assign zext_ln115_1_fu_1011_p1 = $unsigned(sext_ln115_1_fu_1007_p1);

assign zext_ln115_fu_988_p1 = $unsigned(sext_ln115_fu_984_p1);

assign zext_ln1353_28_fu_702_p1 = tmp_50_fu_676_p12;

assign zext_ln1353_29_fu_712_p1 = add_ln1353_fu_706_p2;

assign zext_ln1353_30_fu_778_p1 = tmp_51_fu_752_p12;

assign zext_ln1353_31_fu_930_p1 = add_ln1353_10_reg_1046;

assign zext_ln1353_fu_927_p1 = ret_V_6_reg_1041;

assign zext_ln215_17_fu_552_p1 = add_ln215_fu_546_p2;

assign zext_ln215_19_fu_592_p1 = add_ln215_3_fu_586_p2;

assign zext_ln215_22_fu_642_p1 = add_ln215_4_fu_636_p2;

assign zext_ln215_23_fu_672_p1 = tmp_49_fu_646_p12;

assign zext_ln215_24_fu_748_p1 = tmp_fu_722_p12;

assign zext_ln215_fu_484_p1 = loop_r_int_reg;

endmodule //rgb_bgr_kernel
