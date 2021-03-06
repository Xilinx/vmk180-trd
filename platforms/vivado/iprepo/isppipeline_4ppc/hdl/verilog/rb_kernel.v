// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.2
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module rb_kernel (
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

wire   [11:0] ret_V_9_fu_628_p2;
reg   [11:0] ret_V_9_reg_998;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
wire    ap_block_state4_pp0_stage0_iter3;
wire    ap_block_pp0_stage0_11001;
wire   [11:0] ret_V_11_fu_794_p2;
reg   [11:0] ret_V_11_reg_1004;
reg   [11:0] ret_V_11_reg_1004_pp0_iter1_reg;
wire   [9:0] tmp_61_fu_800_p12;
reg   [9:0] tmp_61_reg_1009;
reg   [9:0] tmp_61_reg_1009_pp0_iter1_reg;
reg   [13:0] trunc_ln_reg_1015;
wire   [15:0] add_ln80_fu_926_p2;
reg   [15:0] add_ln80_reg_1020;
wire   [0:0] icmp_ln81_fu_932_p2;
reg   [0:0] icmp_ln81_reg_1027;
wire    ap_block_pp0_stage0;
wire   [2:0] zext_ln215_fu_462_p1;
wire   [2:0] add_ln215_fu_466_p2;
wire   [3:0] zext_ln215_27_fu_472_p1;
wire   [9:0] tmp_s_fu_476_p12;
wire   [3:0] tmp_55_fu_506_p11;
wire   [9:0] tmp_55_fu_506_p12;
wire   [10:0] lhs_V_fu_502_p1;
wire   [10:0] rhs_V_fu_532_p1;
wire   [10:0] ret_V_fu_536_p2;
wire   [2:0] or_ln_fu_546_p3;
wire   [3:0] tmp_56_fu_558_p11;
wire   [9:0] tmp_56_fu_558_p12;
wire   [9:0] tmp_57_fu_588_p12;
wire   [10:0] zext_ln1353_fu_614_p1;
wire   [10:0] zext_ln215_32_fu_584_p1;
wire   [10:0] add_ln1353_fu_618_p2;
wire   [11:0] lhs_V_7_fu_542_p1;
wire   [11:0] zext_ln1353_32_fu_624_p1;
wire   [2:0] add_ln215_5_fu_634_p2;
wire   [3:0] zext_ln215_33_fu_640_p1;
wire   [9:0] tmp_fu_644_p12;
wire   [2:0] add_ln215_6_fu_674_p2;
wire   [3:0] zext_ln215_35_fu_680_p1;
wire   [9:0] tmp_58_fu_684_p12;
wire   [10:0] lhs_V_8_fu_670_p1;
wire   [10:0] rhs_V_5_fu_710_p1;
wire   [10:0] ret_V_10_fu_714_p2;
wire   [9:0] tmp_59_fu_724_p12;
wire   [9:0] tmp_60_fu_754_p12;
wire   [10:0] zext_ln1353_33_fu_780_p1;
wire   [10:0] zext_ln215_38_fu_750_p1;
wire   [10:0] add_ln1353_16_fu_784_p2;
wire   [11:0] lhs_V_9_fu_720_p1;
wire   [11:0] zext_ln1353_34_fu_790_p1;
wire   [13:0] shl_ln_fu_829_p3;
wire   [14:0] zext_ln75_fu_836_p1;
wire   [14:0] zext_ln74_fu_826_p1;
wire   [14:0] sub_ln75_fu_840_p2;
wire  signed [30:0] sext_ln75_fu_856_p1;
wire   [12:0] t2_fu_863_p3;
wire   [12:0] shl_ln1_fu_874_p3;
wire   [10:0] shl_ln78_1_fu_885_p3;
wire   [13:0] zext_ln78_fu_881_p1;
wire   [13:0] zext_ln78_1_fu_892_p1;
wire  signed [13:0] t3_fu_896_p2;
wire   [31:0] zext_ln77_fu_870_p1;
wire   [31:0] t1_fu_859_p1;
wire   [31:0] sub_ln79_fu_906_p2;
wire  signed [31:0] sext_ln78_fu_902_p1;
wire  signed [15:0] sext_ln79_fu_916_p1;
wire   [15:0] trunc_ln79_fu_912_p1;
wire   [31:0] res_fu_920_p2;
wire   [15:0] sub_ln80_fu_945_p2;
wire   [12:0] tmp_30_fu_950_p4;
wire   [13:0] zext_ln80_fu_960_p1;
wire   [12:0] tmp_31_fu_970_p4;
wire   [0:0] tmp_137_fu_938_p3;
wire   [13:0] sub_ln80_1_fu_964_p2;
wire   [13:0] zext_ln80_1_fu_979_p1;
wire   [13:0] select_ln80_fu_983_p3;
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
ISPPipeline_accelkbM_U102(
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
    .din10(zext_ln215_27_fu_472_p1),
    .dout(tmp_s_fu_476_p12)
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
ISPPipeline_accelkbM_U103(
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
    .din10(tmp_55_fu_506_p11),
    .dout(tmp_55_fu_506_p12)
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
ISPPipeline_accelkbM_U104(
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
    .din10(tmp_56_fu_558_p11),
    .dout(tmp_56_fu_558_p12)
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
ISPPipeline_accelkbM_U105(
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
    .din10(zext_ln215_27_fu_472_p1),
    .dout(tmp_57_fu_588_p12)
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
ISPPipeline_accelkbM_U106(
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
    .din10(zext_ln215_33_fu_640_p1),
    .dout(tmp_fu_644_p12)
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
ISPPipeline_accelkbM_U107(
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
    .din10(zext_ln215_35_fu_680_p1),
    .dout(tmp_58_fu_684_p12)
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
ISPPipeline_accelkbM_U108(
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
    .din10(zext_ln215_33_fu_640_p1),
    .dout(tmp_59_fu_724_p12)
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
ISPPipeline_accelkbM_U109(
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
    .din10(zext_ln215_35_fu_680_p1),
    .dout(tmp_60_fu_754_p12)
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
ISPPipeline_accelkbM_U110(
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
    .din10(zext_ln215_27_fu_472_p1),
    .dout(tmp_61_fu_800_p12)
);

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_ce))) begin
        add_ln80_reg_1020 <= add_ln80_fu_926_p2;
        icmp_ln81_reg_1027 <= icmp_ln81_fu_932_p2;
        ret_V_11_reg_1004 <= ret_V_11_fu_794_p2;
        ret_V_11_reg_1004_pp0_iter1_reg <= ret_V_11_reg_1004;
        ret_V_9_reg_998 <= ret_V_9_fu_628_p2;
        tmp_61_reg_1009 <= tmp_61_fu_800_p12;
        tmp_61_reg_1009_pp0_iter1_reg <= tmp_61_reg_1009;
        trunc_ln_reg_1015 <= {{sub_ln75_fu_840_p2[14:1]}};
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

assign add_ln1353_16_fu_784_p2 = (zext_ln1353_33_fu_780_p1 + zext_ln215_38_fu_750_p1);

assign add_ln1353_fu_618_p2 = (zext_ln1353_fu_614_p1 + zext_ln215_32_fu_584_p1);

assign add_ln215_5_fu_634_p2 = (3'd1 + zext_ln215_fu_462_p1);

assign add_ln215_6_fu_674_p2 = (3'd3 + zext_ln215_fu_462_p1);

assign add_ln215_fu_466_p2 = (3'd2 + zext_ln215_fu_462_p1);

assign add_ln80_fu_926_p2 = ($signed(sext_ln79_fu_916_p1) + $signed(trunc_ln79_fu_912_p1));

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state4_pp0_stage0_iter3 = ~(1'b1 == 1'b1);

assign ap_return = ((icmp_ln81_reg_1027[0:0] === 1'b1) ? 14'd0 : select_ln80_fu_983_p3);

assign icmp_ln81_fu_932_p2 = (($signed(res_fu_920_p2) < $signed(32'd4294967289)) ? 1'b1 : 1'b0);

assign lhs_V_7_fu_542_p1 = ret_V_fu_536_p2;

assign lhs_V_8_fu_670_p1 = tmp_fu_644_p12;

assign lhs_V_9_fu_720_p1 = ret_V_10_fu_714_p2;

assign lhs_V_fu_502_p1 = tmp_s_fu_476_p12;

assign or_ln_fu_546_p3 = {{1'd1}, {loop_r_int_reg}};

assign res_fu_920_p2 = ($signed(sext_ln78_fu_902_p1) + $signed(sub_ln79_fu_906_p2));

assign ret_V_10_fu_714_p2 = (lhs_V_8_fu_670_p1 + rhs_V_5_fu_710_p1);

assign ret_V_11_fu_794_p2 = (lhs_V_9_fu_720_p1 + zext_ln1353_34_fu_790_p1);

assign ret_V_9_fu_628_p2 = (lhs_V_7_fu_542_p1 + zext_ln1353_32_fu_624_p1);

assign ret_V_fu_536_p2 = (lhs_V_fu_502_p1 + rhs_V_fu_532_p1);

assign rhs_V_5_fu_710_p1 = tmp_58_fu_684_p12;

assign rhs_V_fu_532_p1 = tmp_55_fu_506_p12;

assign select_ln80_fu_983_p3 = ((tmp_137_fu_938_p3[0:0] === 1'b1) ? sub_ln80_1_fu_964_p2 : zext_ln80_1_fu_979_p1);

assign sext_ln75_fu_856_p1 = $signed(trunc_ln_reg_1015);

assign sext_ln78_fu_902_p1 = t3_fu_896_p2;

assign sext_ln79_fu_916_p1 = t3_fu_896_p2;

assign shl_ln1_fu_874_p3 = {{tmp_61_reg_1009_pp0_iter1_reg}, {3'd0}};

assign shl_ln78_1_fu_885_p3 = {{tmp_61_reg_1009_pp0_iter1_reg}, {1'd0}};

assign shl_ln_fu_829_p3 = {{ret_V_9_reg_998}, {2'd0}};

assign sub_ln75_fu_840_p2 = (zext_ln75_fu_836_p1 - zext_ln74_fu_826_p1);

assign sub_ln79_fu_906_p2 = (zext_ln77_fu_870_p1 - t1_fu_859_p1);

assign sub_ln80_1_fu_964_p2 = (14'd0 - zext_ln80_fu_960_p1);

assign sub_ln80_fu_945_p2 = (16'd0 - add_ln80_reg_1020);

assign t1_fu_859_p1 = $unsigned(sext_ln75_fu_856_p1);

assign t2_fu_863_p3 = {{ret_V_11_reg_1004_pp0_iter1_reg}, {1'd0}};

assign t3_fu_896_p2 = (zext_ln78_fu_881_p1 - zext_ln78_1_fu_892_p1);

assign tmp_137_fu_938_p3 = add_ln80_reg_1020[32'd15];

assign tmp_30_fu_950_p4 = {{sub_ln80_fu_945_p2[15:3]}};

assign tmp_31_fu_970_p4 = {{add_ln80_reg_1020[15:3]}};

assign tmp_55_fu_506_p11 = loop_r_int_reg;

assign tmp_56_fu_558_p11 = or_ln_fu_546_p3;

assign trunc_ln79_fu_912_p1 = sub_ln79_fu_906_p2[15:0];

assign zext_ln1353_32_fu_624_p1 = add_ln1353_fu_618_p2;

assign zext_ln1353_33_fu_780_p1 = tmp_60_fu_754_p12;

assign zext_ln1353_34_fu_790_p1 = add_ln1353_16_fu_784_p2;

assign zext_ln1353_fu_614_p1 = tmp_57_fu_588_p12;

assign zext_ln215_27_fu_472_p1 = add_ln215_fu_466_p2;

assign zext_ln215_32_fu_584_p1 = tmp_56_fu_558_p12;

assign zext_ln215_33_fu_640_p1 = add_ln215_5_fu_634_p2;

assign zext_ln215_35_fu_680_p1 = add_ln215_6_fu_674_p2;

assign zext_ln215_38_fu_750_p1 = tmp_59_fu_724_p12;

assign zext_ln215_fu_462_p1 = loop_r_int_reg;

assign zext_ln74_fu_826_p1 = ret_V_9_reg_998;

assign zext_ln75_fu_836_p1 = shl_ln_fu_829_p3;

assign zext_ln77_fu_870_p1 = t2_fu_863_p3;

assign zext_ln78_1_fu_892_p1 = shl_ln78_1_fu_885_p3;

assign zext_ln78_fu_881_p1 = shl_ln1_fu_874_p3;

assign zext_ln80_1_fu_979_p1 = tmp_31_fu_970_p4;

assign zext_ln80_fu_960_p1 = tmp_30_fu_950_p4;

endmodule //rb_kernel
