// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.2
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module AWBhistogram (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        src1_rows_dout,
        src1_rows_empty_n,
        src1_rows_read,
        src1_cols_dout,
        src1_cols_empty_n,
        src1_cols_read,
        src1_data_V_V_dout,
        src1_data_V_V_empty_n,
        src1_data_V_V_read,
        src2_data_V_V_din,
        src2_data_V_V_full_n,
        src2_data_V_V_write,
        histogram_0_address0,
        histogram_0_ce0,
        histogram_0_we0,
        histogram_0_d0,
        histogram_1_address0,
        histogram_1_ce0,
        histogram_1_we0,
        histogram_1_d0,
        histogram_2_address0,
        histogram_2_ce0,
        histogram_2_we0,
        histogram_2_d0
);

parameter    ap_ST_fsm_state1 = 2'd1;
parameter    ap_ST_fsm_state2 = 2'd2;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [15:0] src1_rows_dout;
input   src1_rows_empty_n;
output   src1_rows_read;
input  [15:0] src1_cols_dout;
input   src1_cols_empty_n;
output   src1_cols_read;
input  [119:0] src1_data_V_V_dout;
input   src1_data_V_V_empty_n;
output   src1_data_V_V_read;
output  [119:0] src2_data_V_V_din;
input   src2_data_V_V_full_n;
output   src2_data_V_V_write;
output  [9:0] histogram_0_address0;
output   histogram_0_ce0;
output   histogram_0_we0;
output  [31:0] histogram_0_d0;
output  [9:0] histogram_1_address0;
output   histogram_1_ce0;
output   histogram_1_we0;
output  [31:0] histogram_1_d0;
output  [9:0] histogram_2_address0;
output   histogram_2_ce0;
output   histogram_2_we0;
output  [31:0] histogram_2_d0;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg src1_rows_read;
reg src1_cols_read;
reg src1_data_V_V_read;
reg src2_data_V_V_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [1:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    src1_rows_blk_n;
reg    src1_cols_blk_n;
reg   [15:0] src1_rows_read_reg_62;
reg    ap_block_state1;
reg   [15:0] src1_cols_read_reg_67;
wire    grp_AWBhistogramkernel_fu_44_ap_start;
wire    grp_AWBhistogramkernel_fu_44_ap_done;
wire    grp_AWBhistogramkernel_fu_44_ap_idle;
wire    grp_AWBhistogramkernel_fu_44_ap_ready;
wire    grp_AWBhistogramkernel_fu_44_src1_data_V_V_read;
wire   [119:0] grp_AWBhistogramkernel_fu_44_src2_data_V_V_din;
wire    grp_AWBhistogramkernel_fu_44_src2_data_V_V_write;
wire   [9:0] grp_AWBhistogramkernel_fu_44_hist_0_address0;
wire    grp_AWBhistogramkernel_fu_44_hist_0_ce0;
wire    grp_AWBhistogramkernel_fu_44_hist_0_we0;
wire   [31:0] grp_AWBhistogramkernel_fu_44_hist_0_d0;
wire   [9:0] grp_AWBhistogramkernel_fu_44_hist_1_address0;
wire    grp_AWBhistogramkernel_fu_44_hist_1_ce0;
wire    grp_AWBhistogramkernel_fu_44_hist_1_we0;
wire   [31:0] grp_AWBhistogramkernel_fu_44_hist_1_d0;
wire   [9:0] grp_AWBhistogramkernel_fu_44_hist_2_address0;
wire    grp_AWBhistogramkernel_fu_44_hist_2_ce0;
wire    grp_AWBhistogramkernel_fu_44_hist_2_we0;
wire   [31:0] grp_AWBhistogramkernel_fu_44_hist_2_d0;
reg    grp_AWBhistogramkernel_fu_44_ap_start_reg;
reg    ap_block_state1_ignore_call6;
wire    ap_CS_fsm_state2;
reg   [1:0] ap_NS_fsm;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 2'd1;
#0 grp_AWBhistogramkernel_fu_44_ap_start_reg = 1'b0;
end

AWBhistogramkernel grp_AWBhistogramkernel_fu_44(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_AWBhistogramkernel_fu_44_ap_start),
    .ap_done(grp_AWBhistogramkernel_fu_44_ap_done),
    .ap_idle(grp_AWBhistogramkernel_fu_44_ap_idle),
    .ap_ready(grp_AWBhistogramkernel_fu_44_ap_ready),
    .src1_rows_read(src1_rows_read_reg_62),
    .src1_cols_read(src1_cols_read_reg_67),
    .src1_data_V_V_dout(src1_data_V_V_dout),
    .src1_data_V_V_empty_n(src1_data_V_V_empty_n),
    .src1_data_V_V_read(grp_AWBhistogramkernel_fu_44_src1_data_V_V_read),
    .src2_data_V_V_din(grp_AWBhistogramkernel_fu_44_src2_data_V_V_din),
    .src2_data_V_V_full_n(src2_data_V_V_full_n),
    .src2_data_V_V_write(grp_AWBhistogramkernel_fu_44_src2_data_V_V_write),
    .hist_0_address0(grp_AWBhistogramkernel_fu_44_hist_0_address0),
    .hist_0_ce0(grp_AWBhistogramkernel_fu_44_hist_0_ce0),
    .hist_0_we0(grp_AWBhistogramkernel_fu_44_hist_0_we0),
    .hist_0_d0(grp_AWBhistogramkernel_fu_44_hist_0_d0),
    .hist_1_address0(grp_AWBhistogramkernel_fu_44_hist_1_address0),
    .hist_1_ce0(grp_AWBhistogramkernel_fu_44_hist_1_ce0),
    .hist_1_we0(grp_AWBhistogramkernel_fu_44_hist_1_we0),
    .hist_1_d0(grp_AWBhistogramkernel_fu_44_hist_1_d0),
    .hist_2_address0(grp_AWBhistogramkernel_fu_44_hist_2_address0),
    .hist_2_ce0(grp_AWBhistogramkernel_fu_44_hist_2_ce0),
    .hist_2_we0(grp_AWBhistogramkernel_fu_44_hist_2_we0),
    .hist_2_d0(grp_AWBhistogramkernel_fu_44_hist_2_d0)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((grp_AWBhistogramkernel_fu_44_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_AWBhistogramkernel_fu_44_ap_start_reg <= 1'b0;
    end else begin
        if ((~((ap_start == 1'b0) | (src1_cols_empty_n == 1'b0) | (src1_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
            grp_AWBhistogramkernel_fu_44_ap_start_reg <= 1'b1;
        end else if ((grp_AWBhistogramkernel_fu_44_ap_ready == 1'b1)) begin
            grp_AWBhistogramkernel_fu_44_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((~((ap_start == 1'b0) | (src1_cols_empty_n == 1'b0) | (src1_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        src1_cols_read_reg_67 <= src1_cols_dout;
        src1_rows_read_reg_62 <= src1_rows_dout;
    end
end

always @ (*) begin
    if (((grp_AWBhistogramkernel_fu_44_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((grp_AWBhistogramkernel_fu_44_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        src1_cols_blk_n = src1_cols_empty_n;
    end else begin
        src1_cols_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (src1_cols_empty_n == 1'b0) | (src1_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        src1_cols_read = 1'b1;
    end else begin
        src1_cols_read = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        src1_data_V_V_read = grp_AWBhistogramkernel_fu_44_src1_data_V_V_read;
    end else begin
        src1_data_V_V_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        src1_rows_blk_n = src1_rows_empty_n;
    end else begin
        src1_rows_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (src1_cols_empty_n == 1'b0) | (src1_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        src1_rows_read = 1'b1;
    end else begin
        src1_rows_read = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        src2_data_V_V_write = grp_AWBhistogramkernel_fu_44_src2_data_V_V_write;
    end else begin
        src2_data_V_V_write = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((ap_start == 1'b0) | (src1_cols_empty_n == 1'b0) | (src1_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if (((grp_AWBhistogramkernel_fu_44_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

always @ (*) begin
    ap_block_state1 = ((ap_start == 1'b0) | (src1_cols_empty_n == 1'b0) | (src1_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1));
end

always @ (*) begin
    ap_block_state1_ignore_call6 = ((ap_start == 1'b0) | (src1_cols_empty_n == 1'b0) | (src1_rows_empty_n == 1'b0) | (ap_done_reg == 1'b1));
end

assign grp_AWBhistogramkernel_fu_44_ap_start = grp_AWBhistogramkernel_fu_44_ap_start_reg;

assign histogram_0_address0 = grp_AWBhistogramkernel_fu_44_hist_0_address0;

assign histogram_0_ce0 = grp_AWBhistogramkernel_fu_44_hist_0_ce0;

assign histogram_0_d0 = grp_AWBhistogramkernel_fu_44_hist_0_d0;

assign histogram_0_we0 = grp_AWBhistogramkernel_fu_44_hist_0_we0;

assign histogram_1_address0 = grp_AWBhistogramkernel_fu_44_hist_1_address0;

assign histogram_1_ce0 = grp_AWBhistogramkernel_fu_44_hist_1_ce0;

assign histogram_1_d0 = grp_AWBhistogramkernel_fu_44_hist_1_d0;

assign histogram_1_we0 = grp_AWBhistogramkernel_fu_44_hist_1_we0;

assign histogram_2_address0 = grp_AWBhistogramkernel_fu_44_hist_2_address0;

assign histogram_2_ce0 = grp_AWBhistogramkernel_fu_44_hist_2_ce0;

assign histogram_2_d0 = grp_AWBhistogramkernel_fu_44_hist_2_d0;

assign histogram_2_we0 = grp_AWBhistogramkernel_fu_44_hist_2_we0;

assign src2_data_V_V_din = grp_AWBhistogramkernel_fu_44_src2_data_V_V_din;

endmodule //AWBhistogram
