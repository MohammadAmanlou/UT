// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun May 18 17:04:00 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/ariya/OneDrive/Desktop/project_1/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_IDreg_0_0/design_2_IDreg_0_0_sim_netlist.v
// Design      : design_2_IDreg_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_2_IDreg_0_0,IDreg,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "IDreg,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module design_2_IDreg_0_0
   (clk,
    rst,
    flush,
    pc,
    WB_EN,
    MEM_R_EN,
    MEM_W_EN,
    EXE_CMD,
    B,
    S,
    Val_Rn,
    Val_Rm,
    imm,
    Shift_operand,
    Signed_imm_24,
    dest,
    status,
    src_1,
    src_2,
    pcOut,
    WB_EN_out,
    MEM_R_EN_out,
    MEM_W_EN_out,
    EXE_CMD_out,
    B_out,
    S_out,
    Val_Rn_out,
    Val_Rm_out,
    imm_out,
    Shift_operand_out,
    Signed_imm_24_out,
    dest_out,
    status_out,
    src_1_out,
    src_2_out);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_2_clk_0, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rst;
  input flush;
  input [31:0]pc;
  input WB_EN;
  input MEM_R_EN;
  input MEM_W_EN;
  input [3:0]EXE_CMD;
  input B;
  input S;
  input [31:0]Val_Rn;
  input [31:0]Val_Rm;
  input imm;
  input [11:0]Shift_operand;
  input [23:0]Signed_imm_24;
  input [3:0]dest;
  input [3:0]status;
  input [3:0]src_1;
  input [3:0]src_2;
  output [31:0]pcOut;
  output WB_EN_out;
  output MEM_R_EN_out;
  output MEM_W_EN_out;
  output [3:0]EXE_CMD_out;
  output B_out;
  output S_out;
  output [31:0]Val_Rn_out;
  output [31:0]Val_Rm_out;
  output imm_out;
  output [11:0]Shift_operand_out;
  output [23:0]Signed_imm_24_out;
  output [3:0]dest_out;
  output [3:0]status_out;
  output [3:0]src_1_out;
  output [3:0]src_2_out;

  wire B;
  wire B_out;
  wire [3:0]EXE_CMD;
  wire [3:0]EXE_CMD_out;
  wire MEM_R_EN;
  wire MEM_R_EN_out;
  wire MEM_W_EN;
  wire MEM_W_EN_out;
  wire S;
  wire S_out;
  wire [11:0]Shift_operand;
  wire [11:0]Shift_operand_out;
  wire [23:0]Signed_imm_24;
  wire [23:0]Signed_imm_24_out;
  wire [31:0]Val_Rm;
  wire [31:0]Val_Rm_out;
  wire [31:0]Val_Rn;
  wire [31:0]Val_Rn_out;
  wire WB_EN;
  wire WB_EN_out;
  wire clk;
  wire [3:0]dest;
  wire [3:0]dest_out;
  wire flush;
  wire imm;
  wire imm_out;
  wire [31:0]pc;
  wire [31:0]pcOut;
  wire rst;
  wire [3:0]src_1;
  wire [3:0]src_1_out;
  wire [3:0]src_2;
  wire [3:0]src_2_out;
  wire [3:0]status;
  wire [3:0]status_out;

  design_2_IDreg_0_0_IDreg inst
       (.B(B),
        .B_out(B_out),
        .EXE_CMD(EXE_CMD),
        .EXE_CMD_out(EXE_CMD_out),
        .MEM_R_EN(MEM_R_EN),
        .MEM_R_EN_out(MEM_R_EN_out),
        .MEM_W_EN(MEM_W_EN),
        .MEM_W_EN_out(MEM_W_EN_out),
        .S(S),
        .S_out(S_out),
        .Shift_operand(Shift_operand),
        .Shift_operand_out(Shift_operand_out),
        .Signed_imm_24(Signed_imm_24),
        .Signed_imm_24_out(Signed_imm_24_out),
        .Val_Rm(Val_Rm),
        .Val_Rm_out(Val_Rm_out),
        .Val_Rn(Val_Rn),
        .Val_Rn_out(Val_Rn_out),
        .WB_EN(WB_EN),
        .WB_EN_out(WB_EN_out),
        .clk(clk),
        .dest(dest),
        .dest_out(dest_out),
        .flush(flush),
        .imm(imm),
        .imm_out(imm_out),
        .pc(pc),
        .pcOut(pcOut),
        .rst(rst),
        .src_1(src_1),
        .src_1_out(src_1_out),
        .src_2(src_2),
        .src_2_out(src_2_out),
        .status(status),
        .status_out(status_out));
endmodule

(* ORIG_REF_NAME = "IDreg" *) 
module design_2_IDreg_0_0_IDreg
   (pcOut,
    WB_EN_out,
    MEM_R_EN_out,
    MEM_W_EN_out,
    EXE_CMD_out,
    B_out,
    S_out,
    Val_Rn_out,
    Val_Rm_out,
    imm_out,
    Shift_operand_out,
    Signed_imm_24_out,
    dest_out,
    status_out,
    src_1_out,
    src_2_out,
    src_2,
    flush,
    status,
    EXE_CMD,
    dest,
    src_1,
    imm,
    S,
    B,
    MEM_W_EN,
    MEM_R_EN,
    WB_EN,
    clk,
    rst,
    pc,
    Val_Rn,
    Val_Rm,
    Shift_operand,
    Signed_imm_24);
  output [31:0]pcOut;
  output WB_EN_out;
  output MEM_R_EN_out;
  output MEM_W_EN_out;
  output [3:0]EXE_CMD_out;
  output B_out;
  output S_out;
  output [31:0]Val_Rn_out;
  output [31:0]Val_Rm_out;
  output imm_out;
  output [11:0]Shift_operand_out;
  output [23:0]Signed_imm_24_out;
  output [3:0]dest_out;
  output [3:0]status_out;
  output [3:0]src_1_out;
  output [3:0]src_2_out;
  input [3:0]src_2;
  input flush;
  input [3:0]status;
  input [3:0]EXE_CMD;
  input [3:0]dest;
  input [3:0]src_1;
  input imm;
  input S;
  input B;
  input MEM_W_EN;
  input MEM_R_EN;
  input WB_EN;
  input clk;
  input rst;
  input [31:0]pc;
  input [31:0]Val_Rn;
  input [31:0]Val_Rm;
  input [11:0]Shift_operand;
  input [23:0]Signed_imm_24;

  wire B;
  wire B_out;
  wire B_out_i_1_n_0;
  wire [3:0]EXE_CMD;
  wire [3:0]EXE_CMD_out;
  wire \EXE_CMD_out[0]_i_1_n_0 ;
  wire \EXE_CMD_out[1]_i_1_n_0 ;
  wire \EXE_CMD_out[2]_i_1_n_0 ;
  wire \EXE_CMD_out[3]_i_1_n_0 ;
  wire MEM_R_EN;
  wire MEM_R_EN_out;
  wire MEM_R_EN_out_i_1_n_0;
  wire MEM_W_EN;
  wire MEM_W_EN_out;
  wire MEM_W_EN_out_i_1_n_0;
  wire S;
  wire S_out;
  wire S_out_i_1_n_0;
  wire [11:0]Shift_operand;
  wire [11:0]Shift_operand_out;
  wire \Shift_operand_out[0]_i_1_n_0 ;
  wire \Shift_operand_out[10]_i_1_n_0 ;
  wire \Shift_operand_out[11]_i_1_n_0 ;
  wire \Shift_operand_out[1]_i_1_n_0 ;
  wire \Shift_operand_out[2]_i_1_n_0 ;
  wire \Shift_operand_out[3]_i_1_n_0 ;
  wire \Shift_operand_out[4]_i_1_n_0 ;
  wire \Shift_operand_out[5]_i_1_n_0 ;
  wire \Shift_operand_out[6]_i_1_n_0 ;
  wire \Shift_operand_out[7]_i_1_n_0 ;
  wire \Shift_operand_out[8]_i_1_n_0 ;
  wire \Shift_operand_out[9]_i_1_n_0 ;
  wire [23:0]Signed_imm_24;
  wire [23:0]Signed_imm_24_out;
  wire \Signed_imm_24_out[0]_i_1_n_0 ;
  wire \Signed_imm_24_out[10]_i_1_n_0 ;
  wire \Signed_imm_24_out[11]_i_1_n_0 ;
  wire \Signed_imm_24_out[12]_i_1_n_0 ;
  wire \Signed_imm_24_out[13]_i_1_n_0 ;
  wire \Signed_imm_24_out[14]_i_1_n_0 ;
  wire \Signed_imm_24_out[15]_i_1_n_0 ;
  wire \Signed_imm_24_out[16]_i_1_n_0 ;
  wire \Signed_imm_24_out[17]_i_1_n_0 ;
  wire \Signed_imm_24_out[18]_i_1_n_0 ;
  wire \Signed_imm_24_out[19]_i_1_n_0 ;
  wire \Signed_imm_24_out[1]_i_1_n_0 ;
  wire \Signed_imm_24_out[20]_i_1_n_0 ;
  wire \Signed_imm_24_out[21]_i_1_n_0 ;
  wire \Signed_imm_24_out[22]_i_1_n_0 ;
  wire \Signed_imm_24_out[23]_i_1_n_0 ;
  wire \Signed_imm_24_out[2]_i_1_n_0 ;
  wire \Signed_imm_24_out[3]_i_1_n_0 ;
  wire \Signed_imm_24_out[4]_i_1_n_0 ;
  wire \Signed_imm_24_out[5]_i_1_n_0 ;
  wire \Signed_imm_24_out[6]_i_1_n_0 ;
  wire \Signed_imm_24_out[7]_i_1_n_0 ;
  wire \Signed_imm_24_out[8]_i_1_n_0 ;
  wire \Signed_imm_24_out[9]_i_1_n_0 ;
  wire [31:0]Val_Rm;
  wire [31:0]Val_Rm_out;
  wire \Val_Rm_out[0]_i_1_n_0 ;
  wire \Val_Rm_out[10]_i_1_n_0 ;
  wire \Val_Rm_out[11]_i_1_n_0 ;
  wire \Val_Rm_out[12]_i_1_n_0 ;
  wire \Val_Rm_out[13]_i_1_n_0 ;
  wire \Val_Rm_out[14]_i_1_n_0 ;
  wire \Val_Rm_out[15]_i_1_n_0 ;
  wire \Val_Rm_out[16]_i_1_n_0 ;
  wire \Val_Rm_out[17]_i_1_n_0 ;
  wire \Val_Rm_out[18]_i_1_n_0 ;
  wire \Val_Rm_out[19]_i_1_n_0 ;
  wire \Val_Rm_out[1]_i_1_n_0 ;
  wire \Val_Rm_out[20]_i_1_n_0 ;
  wire \Val_Rm_out[21]_i_1_n_0 ;
  wire \Val_Rm_out[22]_i_1_n_0 ;
  wire \Val_Rm_out[23]_i_1_n_0 ;
  wire \Val_Rm_out[24]_i_1_n_0 ;
  wire \Val_Rm_out[25]_i_1_n_0 ;
  wire \Val_Rm_out[26]_i_1_n_0 ;
  wire \Val_Rm_out[27]_i_1_n_0 ;
  wire \Val_Rm_out[28]_i_1_n_0 ;
  wire \Val_Rm_out[29]_i_1_n_0 ;
  wire \Val_Rm_out[2]_i_1_n_0 ;
  wire \Val_Rm_out[30]_i_1_n_0 ;
  wire \Val_Rm_out[31]_i_1_n_0 ;
  wire \Val_Rm_out[3]_i_1_n_0 ;
  wire \Val_Rm_out[4]_i_1_n_0 ;
  wire \Val_Rm_out[5]_i_1_n_0 ;
  wire \Val_Rm_out[6]_i_1_n_0 ;
  wire \Val_Rm_out[7]_i_1_n_0 ;
  wire \Val_Rm_out[8]_i_1_n_0 ;
  wire \Val_Rm_out[9]_i_1_n_0 ;
  wire [31:0]Val_Rn;
  wire [31:0]Val_Rn_out;
  wire \Val_Rn_out[0]_i_1_n_0 ;
  wire \Val_Rn_out[10]_i_1_n_0 ;
  wire \Val_Rn_out[11]_i_1_n_0 ;
  wire \Val_Rn_out[12]_i_1_n_0 ;
  wire \Val_Rn_out[13]_i_1_n_0 ;
  wire \Val_Rn_out[14]_i_1_n_0 ;
  wire \Val_Rn_out[15]_i_1_n_0 ;
  wire \Val_Rn_out[16]_i_1_n_0 ;
  wire \Val_Rn_out[17]_i_1_n_0 ;
  wire \Val_Rn_out[18]_i_1_n_0 ;
  wire \Val_Rn_out[19]_i_1_n_0 ;
  wire \Val_Rn_out[1]_i_1_n_0 ;
  wire \Val_Rn_out[20]_i_1_n_0 ;
  wire \Val_Rn_out[21]_i_1_n_0 ;
  wire \Val_Rn_out[22]_i_1_n_0 ;
  wire \Val_Rn_out[23]_i_1_n_0 ;
  wire \Val_Rn_out[24]_i_1_n_0 ;
  wire \Val_Rn_out[25]_i_1_n_0 ;
  wire \Val_Rn_out[26]_i_1_n_0 ;
  wire \Val_Rn_out[27]_i_1_n_0 ;
  wire \Val_Rn_out[28]_i_1_n_0 ;
  wire \Val_Rn_out[29]_i_1_n_0 ;
  wire \Val_Rn_out[2]_i_1_n_0 ;
  wire \Val_Rn_out[30]_i_1_n_0 ;
  wire \Val_Rn_out[31]_i_1_n_0 ;
  wire \Val_Rn_out[3]_i_1_n_0 ;
  wire \Val_Rn_out[4]_i_1_n_0 ;
  wire \Val_Rn_out[5]_i_1_n_0 ;
  wire \Val_Rn_out[6]_i_1_n_0 ;
  wire \Val_Rn_out[7]_i_1_n_0 ;
  wire \Val_Rn_out[8]_i_1_n_0 ;
  wire \Val_Rn_out[9]_i_1_n_0 ;
  wire WB_EN;
  wire WB_EN_out;
  wire WB_EN_out_i_1_n_0;
  wire clk;
  wire [3:0]dest;
  wire [3:0]dest_out;
  wire \dest_out[0]_i_1_n_0 ;
  wire \dest_out[1]_i_1_n_0 ;
  wire \dest_out[2]_i_1_n_0 ;
  wire \dest_out[3]_i_1_n_0 ;
  wire flush;
  wire imm;
  wire imm_out;
  wire imm_out_i_1_n_0;
  wire [31:0]p_0_in;
  wire [31:0]pc;
  wire [31:0]pcOut;
  wire rst;
  wire [3:0]src_1;
  wire [3:0]src_1_out;
  wire \src_1_out[0]_i_1_n_0 ;
  wire \src_1_out[1]_i_1_n_0 ;
  wire \src_1_out[2]_i_1_n_0 ;
  wire \src_1_out[3]_i_1_n_0 ;
  wire [3:0]src_2;
  wire [3:0]src_2_out;
  wire \src_2_out[0]_i_1_n_0 ;
  wire \src_2_out[1]_i_1_n_0 ;
  wire \src_2_out[2]_i_1_n_0 ;
  wire \src_2_out[3]_i_1_n_0 ;
  wire [3:0]status;
  wire [3:0]status_out;
  wire \status_out[0]_i_1_n_0 ;
  wire \status_out[1]_i_1_n_0 ;
  wire \status_out[2]_i_1_n_0 ;
  wire \status_out[3]_i_1_n_0 ;

  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h2)) 
    B_out_i_1
       (.I0(B),
        .I1(flush),
        .O(B_out_i_1_n_0));
  FDCE B_out_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(B_out_i_1_n_0),
        .Q(B_out));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \EXE_CMD_out[0]_i_1 
       (.I0(EXE_CMD[0]),
        .I1(flush),
        .O(\EXE_CMD_out[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \EXE_CMD_out[1]_i_1 
       (.I0(EXE_CMD[1]),
        .I1(flush),
        .O(\EXE_CMD_out[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \EXE_CMD_out[2]_i_1 
       (.I0(EXE_CMD[2]),
        .I1(flush),
        .O(\EXE_CMD_out[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \EXE_CMD_out[3]_i_1 
       (.I0(EXE_CMD[3]),
        .I1(flush),
        .O(\EXE_CMD_out[3]_i_1_n_0 ));
  FDCE \EXE_CMD_out_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\EXE_CMD_out[0]_i_1_n_0 ),
        .Q(EXE_CMD_out[0]));
  FDCE \EXE_CMD_out_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\EXE_CMD_out[1]_i_1_n_0 ),
        .Q(EXE_CMD_out[1]));
  FDCE \EXE_CMD_out_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\EXE_CMD_out[2]_i_1_n_0 ),
        .Q(EXE_CMD_out[2]));
  FDCE \EXE_CMD_out_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\EXE_CMD_out[3]_i_1_n_0 ),
        .Q(EXE_CMD_out[3]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h2)) 
    MEM_R_EN_out_i_1
       (.I0(MEM_R_EN),
        .I1(flush),
        .O(MEM_R_EN_out_i_1_n_0));
  FDCE MEM_R_EN_out_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(MEM_R_EN_out_i_1_n_0),
        .Q(MEM_R_EN_out));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h2)) 
    MEM_W_EN_out_i_1
       (.I0(MEM_W_EN),
        .I1(flush),
        .O(MEM_W_EN_out_i_1_n_0));
  FDCE MEM_W_EN_out_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(MEM_W_EN_out_i_1_n_0),
        .Q(MEM_W_EN_out));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h2)) 
    S_out_i_1
       (.I0(S),
        .I1(flush),
        .O(S_out_i_1_n_0));
  FDCE S_out_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(S_out_i_1_n_0),
        .Q(S_out));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Shift_operand_out[0]_i_1 
       (.I0(Shift_operand[0]),
        .I1(flush),
        .O(\Shift_operand_out[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Shift_operand_out[10]_i_1 
       (.I0(Shift_operand[10]),
        .I1(flush),
        .O(\Shift_operand_out[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Shift_operand_out[11]_i_1 
       (.I0(Shift_operand[11]),
        .I1(flush),
        .O(\Shift_operand_out[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Shift_operand_out[1]_i_1 
       (.I0(Shift_operand[1]),
        .I1(flush),
        .O(\Shift_operand_out[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Shift_operand_out[2]_i_1 
       (.I0(Shift_operand[2]),
        .I1(flush),
        .O(\Shift_operand_out[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Shift_operand_out[3]_i_1 
       (.I0(Shift_operand[3]),
        .I1(flush),
        .O(\Shift_operand_out[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Shift_operand_out[4]_i_1 
       (.I0(Shift_operand[4]),
        .I1(flush),
        .O(\Shift_operand_out[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Shift_operand_out[5]_i_1 
       (.I0(Shift_operand[5]),
        .I1(flush),
        .O(\Shift_operand_out[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Shift_operand_out[6]_i_1 
       (.I0(Shift_operand[6]),
        .I1(flush),
        .O(\Shift_operand_out[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Shift_operand_out[7]_i_1 
       (.I0(Shift_operand[7]),
        .I1(flush),
        .O(\Shift_operand_out[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Shift_operand_out[8]_i_1 
       (.I0(Shift_operand[8]),
        .I1(flush),
        .O(\Shift_operand_out[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Shift_operand_out[9]_i_1 
       (.I0(Shift_operand[9]),
        .I1(flush),
        .O(\Shift_operand_out[9]_i_1_n_0 ));
  FDCE \Shift_operand_out_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Shift_operand_out[0]_i_1_n_0 ),
        .Q(Shift_operand_out[0]));
  FDCE \Shift_operand_out_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Shift_operand_out[10]_i_1_n_0 ),
        .Q(Shift_operand_out[10]));
  FDCE \Shift_operand_out_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Shift_operand_out[11]_i_1_n_0 ),
        .Q(Shift_operand_out[11]));
  FDCE \Shift_operand_out_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Shift_operand_out[1]_i_1_n_0 ),
        .Q(Shift_operand_out[1]));
  FDCE \Shift_operand_out_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Shift_operand_out[2]_i_1_n_0 ),
        .Q(Shift_operand_out[2]));
  FDCE \Shift_operand_out_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Shift_operand_out[3]_i_1_n_0 ),
        .Q(Shift_operand_out[3]));
  FDCE \Shift_operand_out_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Shift_operand_out[4]_i_1_n_0 ),
        .Q(Shift_operand_out[4]));
  FDCE \Shift_operand_out_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Shift_operand_out[5]_i_1_n_0 ),
        .Q(Shift_operand_out[5]));
  FDCE \Shift_operand_out_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Shift_operand_out[6]_i_1_n_0 ),
        .Q(Shift_operand_out[6]));
  FDCE \Shift_operand_out_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Shift_operand_out[7]_i_1_n_0 ),
        .Q(Shift_operand_out[7]));
  FDCE \Shift_operand_out_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Shift_operand_out[8]_i_1_n_0 ),
        .Q(Shift_operand_out[8]));
  FDCE \Shift_operand_out_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Shift_operand_out[9]_i_1_n_0 ),
        .Q(Shift_operand_out[9]));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[0]_i_1 
       (.I0(Signed_imm_24[0]),
        .I1(flush),
        .O(\Signed_imm_24_out[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[10]_i_1 
       (.I0(Signed_imm_24[10]),
        .I1(flush),
        .O(\Signed_imm_24_out[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[11]_i_1 
       (.I0(Signed_imm_24[11]),
        .I1(flush),
        .O(\Signed_imm_24_out[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[12]_i_1 
       (.I0(Signed_imm_24[12]),
        .I1(flush),
        .O(\Signed_imm_24_out[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[13]_i_1 
       (.I0(Signed_imm_24[13]),
        .I1(flush),
        .O(\Signed_imm_24_out[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[14]_i_1 
       (.I0(Signed_imm_24[14]),
        .I1(flush),
        .O(\Signed_imm_24_out[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[15]_i_1 
       (.I0(Signed_imm_24[15]),
        .I1(flush),
        .O(\Signed_imm_24_out[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[16]_i_1 
       (.I0(Signed_imm_24[16]),
        .I1(flush),
        .O(\Signed_imm_24_out[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[17]_i_1 
       (.I0(Signed_imm_24[17]),
        .I1(flush),
        .O(\Signed_imm_24_out[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[18]_i_1 
       (.I0(Signed_imm_24[18]),
        .I1(flush),
        .O(\Signed_imm_24_out[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[19]_i_1 
       (.I0(Signed_imm_24[19]),
        .I1(flush),
        .O(\Signed_imm_24_out[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[1]_i_1 
       (.I0(Signed_imm_24[1]),
        .I1(flush),
        .O(\Signed_imm_24_out[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[20]_i_1 
       (.I0(Signed_imm_24[20]),
        .I1(flush),
        .O(\Signed_imm_24_out[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[21]_i_1 
       (.I0(Signed_imm_24[21]),
        .I1(flush),
        .O(\Signed_imm_24_out[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[22]_i_1 
       (.I0(Signed_imm_24[22]),
        .I1(flush),
        .O(\Signed_imm_24_out[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[23]_i_1 
       (.I0(Signed_imm_24[23]),
        .I1(flush),
        .O(\Signed_imm_24_out[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[2]_i_1 
       (.I0(Signed_imm_24[2]),
        .I1(flush),
        .O(\Signed_imm_24_out[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[3]_i_1 
       (.I0(Signed_imm_24[3]),
        .I1(flush),
        .O(\Signed_imm_24_out[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[4]_i_1 
       (.I0(Signed_imm_24[4]),
        .I1(flush),
        .O(\Signed_imm_24_out[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[5]_i_1 
       (.I0(Signed_imm_24[5]),
        .I1(flush),
        .O(\Signed_imm_24_out[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[6]_i_1 
       (.I0(Signed_imm_24[6]),
        .I1(flush),
        .O(\Signed_imm_24_out[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[7]_i_1 
       (.I0(Signed_imm_24[7]),
        .I1(flush),
        .O(\Signed_imm_24_out[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[8]_i_1 
       (.I0(Signed_imm_24[8]),
        .I1(flush),
        .O(\Signed_imm_24_out[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Signed_imm_24_out[9]_i_1 
       (.I0(Signed_imm_24[9]),
        .I1(flush),
        .O(\Signed_imm_24_out[9]_i_1_n_0 ));
  FDCE \Signed_imm_24_out_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[0]_i_1_n_0 ),
        .Q(Signed_imm_24_out[0]));
  FDCE \Signed_imm_24_out_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[10]_i_1_n_0 ),
        .Q(Signed_imm_24_out[10]));
  FDCE \Signed_imm_24_out_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[11]_i_1_n_0 ),
        .Q(Signed_imm_24_out[11]));
  FDCE \Signed_imm_24_out_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[12]_i_1_n_0 ),
        .Q(Signed_imm_24_out[12]));
  FDCE \Signed_imm_24_out_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[13]_i_1_n_0 ),
        .Q(Signed_imm_24_out[13]));
  FDCE \Signed_imm_24_out_reg[14] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[14]_i_1_n_0 ),
        .Q(Signed_imm_24_out[14]));
  FDCE \Signed_imm_24_out_reg[15] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[15]_i_1_n_0 ),
        .Q(Signed_imm_24_out[15]));
  FDCE \Signed_imm_24_out_reg[16] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[16]_i_1_n_0 ),
        .Q(Signed_imm_24_out[16]));
  FDCE \Signed_imm_24_out_reg[17] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[17]_i_1_n_0 ),
        .Q(Signed_imm_24_out[17]));
  FDCE \Signed_imm_24_out_reg[18] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[18]_i_1_n_0 ),
        .Q(Signed_imm_24_out[18]));
  FDCE \Signed_imm_24_out_reg[19] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[19]_i_1_n_0 ),
        .Q(Signed_imm_24_out[19]));
  FDCE \Signed_imm_24_out_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[1]_i_1_n_0 ),
        .Q(Signed_imm_24_out[1]));
  FDCE \Signed_imm_24_out_reg[20] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[20]_i_1_n_0 ),
        .Q(Signed_imm_24_out[20]));
  FDCE \Signed_imm_24_out_reg[21] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[21]_i_1_n_0 ),
        .Q(Signed_imm_24_out[21]));
  FDCE \Signed_imm_24_out_reg[22] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[22]_i_1_n_0 ),
        .Q(Signed_imm_24_out[22]));
  FDCE \Signed_imm_24_out_reg[23] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[23]_i_1_n_0 ),
        .Q(Signed_imm_24_out[23]));
  FDCE \Signed_imm_24_out_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[2]_i_1_n_0 ),
        .Q(Signed_imm_24_out[2]));
  FDCE \Signed_imm_24_out_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[3]_i_1_n_0 ),
        .Q(Signed_imm_24_out[3]));
  FDCE \Signed_imm_24_out_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[4]_i_1_n_0 ),
        .Q(Signed_imm_24_out[4]));
  FDCE \Signed_imm_24_out_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[5]_i_1_n_0 ),
        .Q(Signed_imm_24_out[5]));
  FDCE \Signed_imm_24_out_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[6]_i_1_n_0 ),
        .Q(Signed_imm_24_out[6]));
  FDCE \Signed_imm_24_out_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[7]_i_1_n_0 ),
        .Q(Signed_imm_24_out[7]));
  FDCE \Signed_imm_24_out_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[8]_i_1_n_0 ),
        .Q(Signed_imm_24_out[8]));
  FDCE \Signed_imm_24_out_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Signed_imm_24_out[9]_i_1_n_0 ),
        .Q(Signed_imm_24_out[9]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[0]_i_1 
       (.I0(Val_Rm[0]),
        .I1(flush),
        .O(\Val_Rm_out[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[10]_i_1 
       (.I0(Val_Rm[10]),
        .I1(flush),
        .O(\Val_Rm_out[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[11]_i_1 
       (.I0(Val_Rm[11]),
        .I1(flush),
        .O(\Val_Rm_out[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[12]_i_1 
       (.I0(Val_Rm[12]),
        .I1(flush),
        .O(\Val_Rm_out[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[13]_i_1 
       (.I0(Val_Rm[13]),
        .I1(flush),
        .O(\Val_Rm_out[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[14]_i_1 
       (.I0(Val_Rm[14]),
        .I1(flush),
        .O(\Val_Rm_out[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[15]_i_1 
       (.I0(Val_Rm[15]),
        .I1(flush),
        .O(\Val_Rm_out[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[16]_i_1 
       (.I0(Val_Rm[16]),
        .I1(flush),
        .O(\Val_Rm_out[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[17]_i_1 
       (.I0(Val_Rm[17]),
        .I1(flush),
        .O(\Val_Rm_out[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[18]_i_1 
       (.I0(Val_Rm[18]),
        .I1(flush),
        .O(\Val_Rm_out[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[19]_i_1 
       (.I0(Val_Rm[19]),
        .I1(flush),
        .O(\Val_Rm_out[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[1]_i_1 
       (.I0(Val_Rm[1]),
        .I1(flush),
        .O(\Val_Rm_out[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[20]_i_1 
       (.I0(Val_Rm[20]),
        .I1(flush),
        .O(\Val_Rm_out[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[21]_i_1 
       (.I0(Val_Rm[21]),
        .I1(flush),
        .O(\Val_Rm_out[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[22]_i_1 
       (.I0(Val_Rm[22]),
        .I1(flush),
        .O(\Val_Rm_out[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[23]_i_1 
       (.I0(Val_Rm[23]),
        .I1(flush),
        .O(\Val_Rm_out[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[24]_i_1 
       (.I0(Val_Rm[24]),
        .I1(flush),
        .O(\Val_Rm_out[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[25]_i_1 
       (.I0(Val_Rm[25]),
        .I1(flush),
        .O(\Val_Rm_out[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[26]_i_1 
       (.I0(Val_Rm[26]),
        .I1(flush),
        .O(\Val_Rm_out[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[27]_i_1 
       (.I0(Val_Rm[27]),
        .I1(flush),
        .O(\Val_Rm_out[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[28]_i_1 
       (.I0(Val_Rm[28]),
        .I1(flush),
        .O(\Val_Rm_out[28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[29]_i_1 
       (.I0(Val_Rm[29]),
        .I1(flush),
        .O(\Val_Rm_out[29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[2]_i_1 
       (.I0(Val_Rm[2]),
        .I1(flush),
        .O(\Val_Rm_out[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[30]_i_1 
       (.I0(Val_Rm[30]),
        .I1(flush),
        .O(\Val_Rm_out[30]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[31]_i_1 
       (.I0(Val_Rm[31]),
        .I1(flush),
        .O(\Val_Rm_out[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[3]_i_1 
       (.I0(Val_Rm[3]),
        .I1(flush),
        .O(\Val_Rm_out[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[4]_i_1 
       (.I0(Val_Rm[4]),
        .I1(flush),
        .O(\Val_Rm_out[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[5]_i_1 
       (.I0(Val_Rm[5]),
        .I1(flush),
        .O(\Val_Rm_out[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[6]_i_1 
       (.I0(Val_Rm[6]),
        .I1(flush),
        .O(\Val_Rm_out[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[7]_i_1 
       (.I0(Val_Rm[7]),
        .I1(flush),
        .O(\Val_Rm_out[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[8]_i_1 
       (.I0(Val_Rm[8]),
        .I1(flush),
        .O(\Val_Rm_out[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rm_out[9]_i_1 
       (.I0(Val_Rm[9]),
        .I1(flush),
        .O(\Val_Rm_out[9]_i_1_n_0 ));
  FDCE \Val_Rm_out_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[0]_i_1_n_0 ),
        .Q(Val_Rm_out[0]));
  FDCE \Val_Rm_out_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[10]_i_1_n_0 ),
        .Q(Val_Rm_out[10]));
  FDCE \Val_Rm_out_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[11]_i_1_n_0 ),
        .Q(Val_Rm_out[11]));
  FDCE \Val_Rm_out_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[12]_i_1_n_0 ),
        .Q(Val_Rm_out[12]));
  FDCE \Val_Rm_out_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[13]_i_1_n_0 ),
        .Q(Val_Rm_out[13]));
  FDCE \Val_Rm_out_reg[14] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[14]_i_1_n_0 ),
        .Q(Val_Rm_out[14]));
  FDCE \Val_Rm_out_reg[15] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[15]_i_1_n_0 ),
        .Q(Val_Rm_out[15]));
  FDCE \Val_Rm_out_reg[16] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[16]_i_1_n_0 ),
        .Q(Val_Rm_out[16]));
  FDCE \Val_Rm_out_reg[17] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[17]_i_1_n_0 ),
        .Q(Val_Rm_out[17]));
  FDCE \Val_Rm_out_reg[18] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[18]_i_1_n_0 ),
        .Q(Val_Rm_out[18]));
  FDCE \Val_Rm_out_reg[19] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[19]_i_1_n_0 ),
        .Q(Val_Rm_out[19]));
  FDCE \Val_Rm_out_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[1]_i_1_n_0 ),
        .Q(Val_Rm_out[1]));
  FDCE \Val_Rm_out_reg[20] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[20]_i_1_n_0 ),
        .Q(Val_Rm_out[20]));
  FDCE \Val_Rm_out_reg[21] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[21]_i_1_n_0 ),
        .Q(Val_Rm_out[21]));
  FDCE \Val_Rm_out_reg[22] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[22]_i_1_n_0 ),
        .Q(Val_Rm_out[22]));
  FDCE \Val_Rm_out_reg[23] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[23]_i_1_n_0 ),
        .Q(Val_Rm_out[23]));
  FDCE \Val_Rm_out_reg[24] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[24]_i_1_n_0 ),
        .Q(Val_Rm_out[24]));
  FDCE \Val_Rm_out_reg[25] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[25]_i_1_n_0 ),
        .Q(Val_Rm_out[25]));
  FDCE \Val_Rm_out_reg[26] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[26]_i_1_n_0 ),
        .Q(Val_Rm_out[26]));
  FDCE \Val_Rm_out_reg[27] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[27]_i_1_n_0 ),
        .Q(Val_Rm_out[27]));
  FDCE \Val_Rm_out_reg[28] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[28]_i_1_n_0 ),
        .Q(Val_Rm_out[28]));
  FDCE \Val_Rm_out_reg[29] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[29]_i_1_n_0 ),
        .Q(Val_Rm_out[29]));
  FDCE \Val_Rm_out_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[2]_i_1_n_0 ),
        .Q(Val_Rm_out[2]));
  FDCE \Val_Rm_out_reg[30] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[30]_i_1_n_0 ),
        .Q(Val_Rm_out[30]));
  FDCE \Val_Rm_out_reg[31] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[31]_i_1_n_0 ),
        .Q(Val_Rm_out[31]));
  FDCE \Val_Rm_out_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[3]_i_1_n_0 ),
        .Q(Val_Rm_out[3]));
  FDCE \Val_Rm_out_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[4]_i_1_n_0 ),
        .Q(Val_Rm_out[4]));
  FDCE \Val_Rm_out_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[5]_i_1_n_0 ),
        .Q(Val_Rm_out[5]));
  FDCE \Val_Rm_out_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[6]_i_1_n_0 ),
        .Q(Val_Rm_out[6]));
  FDCE \Val_Rm_out_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[7]_i_1_n_0 ),
        .Q(Val_Rm_out[7]));
  FDCE \Val_Rm_out_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[8]_i_1_n_0 ),
        .Q(Val_Rm_out[8]));
  FDCE \Val_Rm_out_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rm_out[9]_i_1_n_0 ),
        .Q(Val_Rm_out[9]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[0]_i_1 
       (.I0(Val_Rn[0]),
        .I1(flush),
        .O(\Val_Rn_out[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[10]_i_1 
       (.I0(Val_Rn[10]),
        .I1(flush),
        .O(\Val_Rn_out[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[11]_i_1 
       (.I0(Val_Rn[11]),
        .I1(flush),
        .O(\Val_Rn_out[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[12]_i_1 
       (.I0(Val_Rn[12]),
        .I1(flush),
        .O(\Val_Rn_out[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[13]_i_1 
       (.I0(Val_Rn[13]),
        .I1(flush),
        .O(\Val_Rn_out[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[14]_i_1 
       (.I0(Val_Rn[14]),
        .I1(flush),
        .O(\Val_Rn_out[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[15]_i_1 
       (.I0(Val_Rn[15]),
        .I1(flush),
        .O(\Val_Rn_out[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[16]_i_1 
       (.I0(Val_Rn[16]),
        .I1(flush),
        .O(\Val_Rn_out[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[17]_i_1 
       (.I0(Val_Rn[17]),
        .I1(flush),
        .O(\Val_Rn_out[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[18]_i_1 
       (.I0(Val_Rn[18]),
        .I1(flush),
        .O(\Val_Rn_out[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[19]_i_1 
       (.I0(Val_Rn[19]),
        .I1(flush),
        .O(\Val_Rn_out[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[1]_i_1 
       (.I0(Val_Rn[1]),
        .I1(flush),
        .O(\Val_Rn_out[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[20]_i_1 
       (.I0(Val_Rn[20]),
        .I1(flush),
        .O(\Val_Rn_out[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[21]_i_1 
       (.I0(Val_Rn[21]),
        .I1(flush),
        .O(\Val_Rn_out[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[22]_i_1 
       (.I0(Val_Rn[22]),
        .I1(flush),
        .O(\Val_Rn_out[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[23]_i_1 
       (.I0(Val_Rn[23]),
        .I1(flush),
        .O(\Val_Rn_out[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[24]_i_1 
       (.I0(Val_Rn[24]),
        .I1(flush),
        .O(\Val_Rn_out[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[25]_i_1 
       (.I0(Val_Rn[25]),
        .I1(flush),
        .O(\Val_Rn_out[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[26]_i_1 
       (.I0(Val_Rn[26]),
        .I1(flush),
        .O(\Val_Rn_out[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[27]_i_1 
       (.I0(Val_Rn[27]),
        .I1(flush),
        .O(\Val_Rn_out[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[28]_i_1 
       (.I0(Val_Rn[28]),
        .I1(flush),
        .O(\Val_Rn_out[28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[29]_i_1 
       (.I0(Val_Rn[29]),
        .I1(flush),
        .O(\Val_Rn_out[29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[2]_i_1 
       (.I0(Val_Rn[2]),
        .I1(flush),
        .O(\Val_Rn_out[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[30]_i_1 
       (.I0(Val_Rn[30]),
        .I1(flush),
        .O(\Val_Rn_out[30]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[31]_i_1 
       (.I0(Val_Rn[31]),
        .I1(flush),
        .O(\Val_Rn_out[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[3]_i_1 
       (.I0(Val_Rn[3]),
        .I1(flush),
        .O(\Val_Rn_out[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[4]_i_1 
       (.I0(Val_Rn[4]),
        .I1(flush),
        .O(\Val_Rn_out[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[5]_i_1 
       (.I0(Val_Rn[5]),
        .I1(flush),
        .O(\Val_Rn_out[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[6]_i_1 
       (.I0(Val_Rn[6]),
        .I1(flush),
        .O(\Val_Rn_out[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[7]_i_1 
       (.I0(Val_Rn[7]),
        .I1(flush),
        .O(\Val_Rn_out[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[8]_i_1 
       (.I0(Val_Rn[8]),
        .I1(flush),
        .O(\Val_Rn_out[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Val_Rn_out[9]_i_1 
       (.I0(Val_Rn[9]),
        .I1(flush),
        .O(\Val_Rn_out[9]_i_1_n_0 ));
  FDCE \Val_Rn_out_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[0]_i_1_n_0 ),
        .Q(Val_Rn_out[0]));
  FDCE \Val_Rn_out_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[10]_i_1_n_0 ),
        .Q(Val_Rn_out[10]));
  FDCE \Val_Rn_out_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[11]_i_1_n_0 ),
        .Q(Val_Rn_out[11]));
  FDCE \Val_Rn_out_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[12]_i_1_n_0 ),
        .Q(Val_Rn_out[12]));
  FDCE \Val_Rn_out_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[13]_i_1_n_0 ),
        .Q(Val_Rn_out[13]));
  FDCE \Val_Rn_out_reg[14] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[14]_i_1_n_0 ),
        .Q(Val_Rn_out[14]));
  FDCE \Val_Rn_out_reg[15] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[15]_i_1_n_0 ),
        .Q(Val_Rn_out[15]));
  FDCE \Val_Rn_out_reg[16] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[16]_i_1_n_0 ),
        .Q(Val_Rn_out[16]));
  FDCE \Val_Rn_out_reg[17] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[17]_i_1_n_0 ),
        .Q(Val_Rn_out[17]));
  FDCE \Val_Rn_out_reg[18] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[18]_i_1_n_0 ),
        .Q(Val_Rn_out[18]));
  FDCE \Val_Rn_out_reg[19] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[19]_i_1_n_0 ),
        .Q(Val_Rn_out[19]));
  FDCE \Val_Rn_out_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[1]_i_1_n_0 ),
        .Q(Val_Rn_out[1]));
  FDCE \Val_Rn_out_reg[20] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[20]_i_1_n_0 ),
        .Q(Val_Rn_out[20]));
  FDCE \Val_Rn_out_reg[21] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[21]_i_1_n_0 ),
        .Q(Val_Rn_out[21]));
  FDCE \Val_Rn_out_reg[22] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[22]_i_1_n_0 ),
        .Q(Val_Rn_out[22]));
  FDCE \Val_Rn_out_reg[23] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[23]_i_1_n_0 ),
        .Q(Val_Rn_out[23]));
  FDCE \Val_Rn_out_reg[24] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[24]_i_1_n_0 ),
        .Q(Val_Rn_out[24]));
  FDCE \Val_Rn_out_reg[25] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[25]_i_1_n_0 ),
        .Q(Val_Rn_out[25]));
  FDCE \Val_Rn_out_reg[26] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[26]_i_1_n_0 ),
        .Q(Val_Rn_out[26]));
  FDCE \Val_Rn_out_reg[27] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[27]_i_1_n_0 ),
        .Q(Val_Rn_out[27]));
  FDCE \Val_Rn_out_reg[28] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[28]_i_1_n_0 ),
        .Q(Val_Rn_out[28]));
  FDCE \Val_Rn_out_reg[29] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[29]_i_1_n_0 ),
        .Q(Val_Rn_out[29]));
  FDCE \Val_Rn_out_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[2]_i_1_n_0 ),
        .Q(Val_Rn_out[2]));
  FDCE \Val_Rn_out_reg[30] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[30]_i_1_n_0 ),
        .Q(Val_Rn_out[30]));
  FDCE \Val_Rn_out_reg[31] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[31]_i_1_n_0 ),
        .Q(Val_Rn_out[31]));
  FDCE \Val_Rn_out_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[3]_i_1_n_0 ),
        .Q(Val_Rn_out[3]));
  FDCE \Val_Rn_out_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[4]_i_1_n_0 ),
        .Q(Val_Rn_out[4]));
  FDCE \Val_Rn_out_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[5]_i_1_n_0 ),
        .Q(Val_Rn_out[5]));
  FDCE \Val_Rn_out_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[6]_i_1_n_0 ),
        .Q(Val_Rn_out[6]));
  FDCE \Val_Rn_out_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[7]_i_1_n_0 ),
        .Q(Val_Rn_out[7]));
  FDCE \Val_Rn_out_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[8]_i_1_n_0 ),
        .Q(Val_Rn_out[8]));
  FDCE \Val_Rn_out_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\Val_Rn_out[9]_i_1_n_0 ),
        .Q(Val_Rn_out[9]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h2)) 
    WB_EN_out_i_1
       (.I0(WB_EN),
        .I1(flush),
        .O(WB_EN_out_i_1_n_0));
  FDCE WB_EN_out_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(WB_EN_out_i_1_n_0),
        .Q(WB_EN_out));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \dest_out[0]_i_1 
       (.I0(dest[0]),
        .I1(flush),
        .O(\dest_out[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \dest_out[1]_i_1 
       (.I0(dest[1]),
        .I1(flush),
        .O(\dest_out[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \dest_out[2]_i_1 
       (.I0(dest[2]),
        .I1(flush),
        .O(\dest_out[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \dest_out[3]_i_1 
       (.I0(dest[3]),
        .I1(flush),
        .O(\dest_out[3]_i_1_n_0 ));
  FDCE \dest_out_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\dest_out[0]_i_1_n_0 ),
        .Q(dest_out[0]));
  FDCE \dest_out_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\dest_out[1]_i_1_n_0 ),
        .Q(dest_out[1]));
  FDCE \dest_out_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\dest_out[2]_i_1_n_0 ),
        .Q(dest_out[2]));
  FDCE \dest_out_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\dest_out[3]_i_1_n_0 ),
        .Q(dest_out[3]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h2)) 
    imm_out_i_1
       (.I0(imm),
        .I1(flush),
        .O(imm_out_i_1_n_0));
  FDCE imm_out_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(imm_out_i_1_n_0),
        .Q(imm_out));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[0]_i_1 
       (.I0(pc[0]),
        .I1(flush),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[10]_i_1 
       (.I0(pc[10]),
        .I1(flush),
        .O(p_0_in[10]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[11]_i_1 
       (.I0(pc[11]),
        .I1(flush),
        .O(p_0_in[11]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[12]_i_1 
       (.I0(pc[12]),
        .I1(flush),
        .O(p_0_in[12]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[13]_i_1 
       (.I0(pc[13]),
        .I1(flush),
        .O(p_0_in[13]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[14]_i_1 
       (.I0(pc[14]),
        .I1(flush),
        .O(p_0_in[14]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[15]_i_1 
       (.I0(pc[15]),
        .I1(flush),
        .O(p_0_in[15]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[16]_i_1 
       (.I0(pc[16]),
        .I1(flush),
        .O(p_0_in[16]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[17]_i_1 
       (.I0(pc[17]),
        .I1(flush),
        .O(p_0_in[17]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[18]_i_1 
       (.I0(pc[18]),
        .I1(flush),
        .O(p_0_in[18]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[19]_i_1 
       (.I0(pc[19]),
        .I1(flush),
        .O(p_0_in[19]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[1]_i_1 
       (.I0(pc[1]),
        .I1(flush),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[20]_i_1 
       (.I0(pc[20]),
        .I1(flush),
        .O(p_0_in[20]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[21]_i_1 
       (.I0(pc[21]),
        .I1(flush),
        .O(p_0_in[21]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[22]_i_1 
       (.I0(pc[22]),
        .I1(flush),
        .O(p_0_in[22]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[23]_i_1 
       (.I0(pc[23]),
        .I1(flush),
        .O(p_0_in[23]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[24]_i_1 
       (.I0(pc[24]),
        .I1(flush),
        .O(p_0_in[24]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[25]_i_1 
       (.I0(pc[25]),
        .I1(flush),
        .O(p_0_in[25]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[26]_i_1 
       (.I0(pc[26]),
        .I1(flush),
        .O(p_0_in[26]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[27]_i_1 
       (.I0(pc[27]),
        .I1(flush),
        .O(p_0_in[27]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[28]_i_1 
       (.I0(pc[28]),
        .I1(flush),
        .O(p_0_in[28]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[29]_i_1 
       (.I0(pc[29]),
        .I1(flush),
        .O(p_0_in[29]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[2]_i_1 
       (.I0(pc[2]),
        .I1(flush),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[30]_i_1 
       (.I0(pc[30]),
        .I1(flush),
        .O(p_0_in[30]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[31]_i_1 
       (.I0(pc[31]),
        .I1(flush),
        .O(p_0_in[31]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[3]_i_1 
       (.I0(pc[3]),
        .I1(flush),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[4]_i_1 
       (.I0(pc[4]),
        .I1(flush),
        .O(p_0_in[4]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[5]_i_1 
       (.I0(pc[5]),
        .I1(flush),
        .O(p_0_in[5]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[6]_i_1 
       (.I0(pc[6]),
        .I1(flush),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[7]_i_1 
       (.I0(pc[7]),
        .I1(flush),
        .O(p_0_in[7]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[8]_i_1 
       (.I0(pc[8]),
        .I1(flush),
        .O(p_0_in[8]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[9]_i_1 
       (.I0(pc[9]),
        .I1(flush),
        .O(p_0_in[9]));
  FDCE \pcOut_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[0]),
        .Q(pcOut[0]));
  FDCE \pcOut_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[10]),
        .Q(pcOut[10]));
  FDCE \pcOut_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[11]),
        .Q(pcOut[11]));
  FDCE \pcOut_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[12]),
        .Q(pcOut[12]));
  FDCE \pcOut_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[13]),
        .Q(pcOut[13]));
  FDCE \pcOut_reg[14] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[14]),
        .Q(pcOut[14]));
  FDCE \pcOut_reg[15] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[15]),
        .Q(pcOut[15]));
  FDCE \pcOut_reg[16] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[16]),
        .Q(pcOut[16]));
  FDCE \pcOut_reg[17] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[17]),
        .Q(pcOut[17]));
  FDCE \pcOut_reg[18] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[18]),
        .Q(pcOut[18]));
  FDCE \pcOut_reg[19] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[19]),
        .Q(pcOut[19]));
  FDCE \pcOut_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[1]),
        .Q(pcOut[1]));
  FDCE \pcOut_reg[20] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[20]),
        .Q(pcOut[20]));
  FDCE \pcOut_reg[21] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[21]),
        .Q(pcOut[21]));
  FDCE \pcOut_reg[22] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[22]),
        .Q(pcOut[22]));
  FDCE \pcOut_reg[23] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[23]),
        .Q(pcOut[23]));
  FDCE \pcOut_reg[24] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[24]),
        .Q(pcOut[24]));
  FDCE \pcOut_reg[25] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[25]),
        .Q(pcOut[25]));
  FDCE \pcOut_reg[26] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[26]),
        .Q(pcOut[26]));
  FDCE \pcOut_reg[27] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[27]),
        .Q(pcOut[27]));
  FDCE \pcOut_reg[28] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[28]),
        .Q(pcOut[28]));
  FDCE \pcOut_reg[29] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[29]),
        .Q(pcOut[29]));
  FDCE \pcOut_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[2]),
        .Q(pcOut[2]));
  FDCE \pcOut_reg[30] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[30]),
        .Q(pcOut[30]));
  FDCE \pcOut_reg[31] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[31]),
        .Q(pcOut[31]));
  FDCE \pcOut_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[3]),
        .Q(pcOut[3]));
  FDCE \pcOut_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[4]),
        .Q(pcOut[4]));
  FDCE \pcOut_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[5]),
        .Q(pcOut[5]));
  FDCE \pcOut_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[6]),
        .Q(pcOut[6]));
  FDCE \pcOut_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[7]),
        .Q(pcOut[7]));
  FDCE \pcOut_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[8]),
        .Q(pcOut[8]));
  FDCE \pcOut_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(p_0_in[9]),
        .Q(pcOut[9]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \src_1_out[0]_i_1 
       (.I0(src_1[0]),
        .I1(flush),
        .O(\src_1_out[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \src_1_out[1]_i_1 
       (.I0(src_1[1]),
        .I1(flush),
        .O(\src_1_out[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \src_1_out[2]_i_1 
       (.I0(src_1[2]),
        .I1(flush),
        .O(\src_1_out[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \src_1_out[3]_i_1 
       (.I0(src_1[3]),
        .I1(flush),
        .O(\src_1_out[3]_i_1_n_0 ));
  FDCE \src_1_out_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\src_1_out[0]_i_1_n_0 ),
        .Q(src_1_out[0]));
  FDCE \src_1_out_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\src_1_out[1]_i_1_n_0 ),
        .Q(src_1_out[1]));
  FDCE \src_1_out_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\src_1_out[2]_i_1_n_0 ),
        .Q(src_1_out[2]));
  FDCE \src_1_out_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\src_1_out[3]_i_1_n_0 ),
        .Q(src_1_out[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \src_2_out[0]_i_1 
       (.I0(src_2[0]),
        .I1(flush),
        .O(\src_2_out[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \src_2_out[1]_i_1 
       (.I0(src_2[1]),
        .I1(flush),
        .O(\src_2_out[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \src_2_out[2]_i_1 
       (.I0(src_2[2]),
        .I1(flush),
        .O(\src_2_out[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \src_2_out[3]_i_1 
       (.I0(src_2[3]),
        .I1(flush),
        .O(\src_2_out[3]_i_1_n_0 ));
  FDCE \src_2_out_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\src_2_out[0]_i_1_n_0 ),
        .Q(src_2_out[0]));
  FDCE \src_2_out_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\src_2_out[1]_i_1_n_0 ),
        .Q(src_2_out[1]));
  FDCE \src_2_out_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\src_2_out[2]_i_1_n_0 ),
        .Q(src_2_out[2]));
  FDCE \src_2_out_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\src_2_out[3]_i_1_n_0 ),
        .Q(src_2_out[3]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \status_out[0]_i_1 
       (.I0(status[0]),
        .I1(flush),
        .O(\status_out[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \status_out[1]_i_1 
       (.I0(status[1]),
        .I1(flush),
        .O(\status_out[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \status_out[2]_i_1 
       (.I0(status[2]),
        .I1(flush),
        .O(\status_out[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \status_out[3]_i_1 
       (.I0(status[3]),
        .I1(flush),
        .O(\status_out[3]_i_1_n_0 ));
  FDCE \status_out_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\status_out[0]_i_1_n_0 ),
        .Q(status_out[0]));
  FDCE \status_out_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\status_out[1]_i_1_n_0 ),
        .Q(status_out[1]));
  FDCE \status_out_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\status_out[2]_i_1_n_0 ),
        .Q(status_out[2]));
  FDCE \status_out_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(\status_out[3]_i_1_n_0 ),
        .Q(status_out[3]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
