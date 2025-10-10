// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Apr  6 08:13:56 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/ariya/ARM/ARM.srcs/sources_1/bd/design_2/ip/design_2_IFreg_0/design_2_IFreg_0_sim_netlist.v
// Design      : design_2_IFreg_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_2_IFreg_0,IFreg,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "IFreg,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module design_2_IFreg_0
   (clk,
    rst,
    flush,
    freeze,
    pc,
    instruction,
    pcOut,
    instructionOut);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_2_clk_0, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rst;
  input flush;
  input freeze;
  input [31:0]pc;
  input [31:0]instruction;
  output [31:0]pcOut;
  output [31:0]instructionOut;

  wire clk;
  wire flush;
  wire freeze;
  wire [31:0]instruction;
  wire [31:0]instructionOut;
  wire [31:0]pc;
  wire [31:0]pcOut;
  wire rst;

  design_2_IFreg_0_IFreg inst
       (.clk(clk),
        .flush(flush),
        .freeze(freeze),
        .instruction(instruction),
        .instructionOut(instructionOut),
        .pc(pc),
        .pcOut(pcOut),
        .rst(rst));
endmodule

(* ORIG_REF_NAME = "IFreg" *) 
module design_2_IFreg_0_IFreg
   (pcOut,
    instructionOut,
    flush,
    freeze,
    clk,
    rst,
    pc,
    instruction);
  output [31:0]pcOut;
  output [31:0]instructionOut;
  input flush;
  input freeze;
  input clk;
  input rst;
  input [31:0]pc;
  input [31:0]instruction;

  wire clk;
  wire flush;
  wire freeze;
  wire [31:0]instruction;
  wire [31:0]instructionOut;
  wire \instructionOut[0]_i_1_n_0 ;
  wire \instructionOut[10]_i_1_n_0 ;
  wire \instructionOut[11]_i_1_n_0 ;
  wire \instructionOut[12]_i_1_n_0 ;
  wire \instructionOut[13]_i_1_n_0 ;
  wire \instructionOut[14]_i_1_n_0 ;
  wire \instructionOut[15]_i_1_n_0 ;
  wire \instructionOut[16]_i_1_n_0 ;
  wire \instructionOut[17]_i_1_n_0 ;
  wire \instructionOut[18]_i_1_n_0 ;
  wire \instructionOut[19]_i_1_n_0 ;
  wire \instructionOut[1]_i_1_n_0 ;
  wire \instructionOut[20]_i_1_n_0 ;
  wire \instructionOut[21]_i_1_n_0 ;
  wire \instructionOut[22]_i_1_n_0 ;
  wire \instructionOut[23]_i_1_n_0 ;
  wire \instructionOut[24]_i_1_n_0 ;
  wire \instructionOut[25]_i_1_n_0 ;
  wire \instructionOut[26]_i_1_n_0 ;
  wire \instructionOut[27]_i_1_n_0 ;
  wire \instructionOut[28]_i_1_n_0 ;
  wire \instructionOut[29]_i_1_n_0 ;
  wire \instructionOut[2]_i_1_n_0 ;
  wire \instructionOut[30]_i_1_n_0 ;
  wire \instructionOut[31]_i_1_n_0 ;
  wire \instructionOut[3]_i_1_n_0 ;
  wire \instructionOut[4]_i_1_n_0 ;
  wire \instructionOut[5]_i_1_n_0 ;
  wire \instructionOut[6]_i_1_n_0 ;
  wire \instructionOut[7]_i_1_n_0 ;
  wire \instructionOut[8]_i_1_n_0 ;
  wire \instructionOut[9]_i_1_n_0 ;
  wire [31:0]p_0_in;
  wire [31:0]pc;
  wire [31:0]pcOut;
  wire \pcOut[31]_i_1_n_0 ;
  wire rst;

  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[0]_i_1 
       (.I0(instruction[0]),
        .I1(flush),
        .O(\instructionOut[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[10]_i_1 
       (.I0(instruction[10]),
        .I1(flush),
        .O(\instructionOut[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[11]_i_1 
       (.I0(instruction[11]),
        .I1(flush),
        .O(\instructionOut[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[12]_i_1 
       (.I0(instruction[12]),
        .I1(flush),
        .O(\instructionOut[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[13]_i_1 
       (.I0(instruction[13]),
        .I1(flush),
        .O(\instructionOut[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[14]_i_1 
       (.I0(instruction[14]),
        .I1(flush),
        .O(\instructionOut[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[15]_i_1 
       (.I0(instruction[15]),
        .I1(flush),
        .O(\instructionOut[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[16]_i_1 
       (.I0(instruction[16]),
        .I1(flush),
        .O(\instructionOut[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[17]_i_1 
       (.I0(instruction[17]),
        .I1(flush),
        .O(\instructionOut[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[18]_i_1 
       (.I0(instruction[18]),
        .I1(flush),
        .O(\instructionOut[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[19]_i_1 
       (.I0(instruction[19]),
        .I1(flush),
        .O(\instructionOut[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[1]_i_1 
       (.I0(instruction[1]),
        .I1(flush),
        .O(\instructionOut[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[20]_i_1 
       (.I0(instruction[20]),
        .I1(flush),
        .O(\instructionOut[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[21]_i_1 
       (.I0(instruction[21]),
        .I1(flush),
        .O(\instructionOut[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[22]_i_1 
       (.I0(instruction[22]),
        .I1(flush),
        .O(\instructionOut[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[23]_i_1 
       (.I0(instruction[23]),
        .I1(flush),
        .O(\instructionOut[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[24]_i_1 
       (.I0(instruction[24]),
        .I1(flush),
        .O(\instructionOut[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[25]_i_1 
       (.I0(instruction[25]),
        .I1(flush),
        .O(\instructionOut[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[26]_i_1 
       (.I0(instruction[26]),
        .I1(flush),
        .O(\instructionOut[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[27]_i_1 
       (.I0(instruction[27]),
        .I1(flush),
        .O(\instructionOut[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[28]_i_1 
       (.I0(instruction[28]),
        .I1(flush),
        .O(\instructionOut[28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[29]_i_1 
       (.I0(instruction[29]),
        .I1(flush),
        .O(\instructionOut[29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[2]_i_1 
       (.I0(instruction[2]),
        .I1(flush),
        .O(\instructionOut[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[30]_i_1 
       (.I0(instruction[30]),
        .I1(flush),
        .O(\instructionOut[30]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[31]_i_1 
       (.I0(instruction[31]),
        .I1(flush),
        .O(\instructionOut[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[3]_i_1 
       (.I0(instruction[3]),
        .I1(flush),
        .O(\instructionOut[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[4]_i_1 
       (.I0(instruction[4]),
        .I1(flush),
        .O(\instructionOut[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[5]_i_1 
       (.I0(instruction[5]),
        .I1(flush),
        .O(\instructionOut[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[6]_i_1 
       (.I0(instruction[6]),
        .I1(flush),
        .O(\instructionOut[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[7]_i_1 
       (.I0(instruction[7]),
        .I1(flush),
        .O(\instructionOut[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[8]_i_1 
       (.I0(instruction[8]),
        .I1(flush),
        .O(\instructionOut[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \instructionOut[9]_i_1 
       (.I0(instruction[9]),
        .I1(flush),
        .O(\instructionOut[9]_i_1_n_0 ));
  FDCE \instructionOut_reg[0] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[0]_i_1_n_0 ),
        .Q(instructionOut[0]));
  FDCE \instructionOut_reg[10] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[10]_i_1_n_0 ),
        .Q(instructionOut[10]));
  FDCE \instructionOut_reg[11] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[11]_i_1_n_0 ),
        .Q(instructionOut[11]));
  FDCE \instructionOut_reg[12] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[12]_i_1_n_0 ),
        .Q(instructionOut[12]));
  FDCE \instructionOut_reg[13] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[13]_i_1_n_0 ),
        .Q(instructionOut[13]));
  FDCE \instructionOut_reg[14] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[14]_i_1_n_0 ),
        .Q(instructionOut[14]));
  FDCE \instructionOut_reg[15] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[15]_i_1_n_0 ),
        .Q(instructionOut[15]));
  FDCE \instructionOut_reg[16] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[16]_i_1_n_0 ),
        .Q(instructionOut[16]));
  FDCE \instructionOut_reg[17] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[17]_i_1_n_0 ),
        .Q(instructionOut[17]));
  FDCE \instructionOut_reg[18] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[18]_i_1_n_0 ),
        .Q(instructionOut[18]));
  FDCE \instructionOut_reg[19] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[19]_i_1_n_0 ),
        .Q(instructionOut[19]));
  FDCE \instructionOut_reg[1] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[1]_i_1_n_0 ),
        .Q(instructionOut[1]));
  FDCE \instructionOut_reg[20] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[20]_i_1_n_0 ),
        .Q(instructionOut[20]));
  FDCE \instructionOut_reg[21] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[21]_i_1_n_0 ),
        .Q(instructionOut[21]));
  FDCE \instructionOut_reg[22] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[22]_i_1_n_0 ),
        .Q(instructionOut[22]));
  FDCE \instructionOut_reg[23] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[23]_i_1_n_0 ),
        .Q(instructionOut[23]));
  FDCE \instructionOut_reg[24] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[24]_i_1_n_0 ),
        .Q(instructionOut[24]));
  FDCE \instructionOut_reg[25] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[25]_i_1_n_0 ),
        .Q(instructionOut[25]));
  FDCE \instructionOut_reg[26] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[26]_i_1_n_0 ),
        .Q(instructionOut[26]));
  FDCE \instructionOut_reg[27] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[27]_i_1_n_0 ),
        .Q(instructionOut[27]));
  FDCE \instructionOut_reg[28] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[28]_i_1_n_0 ),
        .Q(instructionOut[28]));
  FDCE \instructionOut_reg[29] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[29]_i_1_n_0 ),
        .Q(instructionOut[29]));
  FDCE \instructionOut_reg[2] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[2]_i_1_n_0 ),
        .Q(instructionOut[2]));
  FDCE \instructionOut_reg[30] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[30]_i_1_n_0 ),
        .Q(instructionOut[30]));
  FDCE \instructionOut_reg[31] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[31]_i_1_n_0 ),
        .Q(instructionOut[31]));
  FDCE \instructionOut_reg[3] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[3]_i_1_n_0 ),
        .Q(instructionOut[3]));
  FDCE \instructionOut_reg[4] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[4]_i_1_n_0 ),
        .Q(instructionOut[4]));
  FDCE \instructionOut_reg[5] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[5]_i_1_n_0 ),
        .Q(instructionOut[5]));
  FDCE \instructionOut_reg[6] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[6]_i_1_n_0 ),
        .Q(instructionOut[6]));
  FDCE \instructionOut_reg[7] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[7]_i_1_n_0 ),
        .Q(instructionOut[7]));
  FDCE \instructionOut_reg[8] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[8]_i_1_n_0 ),
        .Q(instructionOut[8]));
  FDCE \instructionOut_reg[9] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(\instructionOut[9]_i_1_n_0 ),
        .Q(instructionOut[9]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[0]_i_1 
       (.I0(pc[0]),
        .I1(flush),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[10]_i_1 
       (.I0(pc[10]),
        .I1(flush),
        .O(p_0_in[10]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[11]_i_1 
       (.I0(pc[11]),
        .I1(flush),
        .O(p_0_in[11]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[12]_i_1 
       (.I0(pc[12]),
        .I1(flush),
        .O(p_0_in[12]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[13]_i_1 
       (.I0(pc[13]),
        .I1(flush),
        .O(p_0_in[13]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[14]_i_1 
       (.I0(pc[14]),
        .I1(flush),
        .O(p_0_in[14]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[15]_i_1 
       (.I0(pc[15]),
        .I1(flush),
        .O(p_0_in[15]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[16]_i_1 
       (.I0(pc[16]),
        .I1(flush),
        .O(p_0_in[16]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[17]_i_1 
       (.I0(pc[17]),
        .I1(flush),
        .O(p_0_in[17]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[18]_i_1 
       (.I0(pc[18]),
        .I1(flush),
        .O(p_0_in[18]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[19]_i_1 
       (.I0(pc[19]),
        .I1(flush),
        .O(p_0_in[19]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[1]_i_1 
       (.I0(pc[1]),
        .I1(flush),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[20]_i_1 
       (.I0(pc[20]),
        .I1(flush),
        .O(p_0_in[20]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[21]_i_1 
       (.I0(pc[21]),
        .I1(flush),
        .O(p_0_in[21]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[22]_i_1 
       (.I0(pc[22]),
        .I1(flush),
        .O(p_0_in[22]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[23]_i_1 
       (.I0(pc[23]),
        .I1(flush),
        .O(p_0_in[23]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[24]_i_1 
       (.I0(pc[24]),
        .I1(flush),
        .O(p_0_in[24]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[25]_i_1 
       (.I0(pc[25]),
        .I1(flush),
        .O(p_0_in[25]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[26]_i_1 
       (.I0(pc[26]),
        .I1(flush),
        .O(p_0_in[26]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[27]_i_1 
       (.I0(pc[27]),
        .I1(flush),
        .O(p_0_in[27]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[28]_i_1 
       (.I0(pc[28]),
        .I1(flush),
        .O(p_0_in[28]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[29]_i_1 
       (.I0(pc[29]),
        .I1(flush),
        .O(p_0_in[29]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[2]_i_1 
       (.I0(pc[2]),
        .I1(flush),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[30]_i_1 
       (.I0(pc[30]),
        .I1(flush),
        .O(p_0_in[30]));
  LUT2 #(
    .INIT(4'hB)) 
    \pcOut[31]_i_1 
       (.I0(flush),
        .I1(freeze),
        .O(\pcOut[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[31]_i_2 
       (.I0(pc[31]),
        .I1(flush),
        .O(p_0_in[31]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[3]_i_1 
       (.I0(pc[3]),
        .I1(flush),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[4]_i_1 
       (.I0(pc[4]),
        .I1(flush),
        .O(p_0_in[4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[5]_i_1 
       (.I0(pc[5]),
        .I1(flush),
        .O(p_0_in[5]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[6]_i_1 
       (.I0(pc[6]),
        .I1(flush),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[7]_i_1 
       (.I0(pc[7]),
        .I1(flush),
        .O(p_0_in[7]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[8]_i_1 
       (.I0(pc[8]),
        .I1(flush),
        .O(p_0_in[8]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pcOut[9]_i_1 
       (.I0(pc[9]),
        .I1(flush),
        .O(p_0_in[9]));
  FDCE \pcOut_reg[0] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[0]),
        .Q(pcOut[0]));
  FDCE \pcOut_reg[10] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[10]),
        .Q(pcOut[10]));
  FDCE \pcOut_reg[11] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[11]),
        .Q(pcOut[11]));
  FDCE \pcOut_reg[12] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[12]),
        .Q(pcOut[12]));
  FDCE \pcOut_reg[13] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[13]),
        .Q(pcOut[13]));
  FDCE \pcOut_reg[14] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[14]),
        .Q(pcOut[14]));
  FDCE \pcOut_reg[15] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[15]),
        .Q(pcOut[15]));
  FDCE \pcOut_reg[16] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[16]),
        .Q(pcOut[16]));
  FDCE \pcOut_reg[17] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[17]),
        .Q(pcOut[17]));
  FDCE \pcOut_reg[18] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[18]),
        .Q(pcOut[18]));
  FDCE \pcOut_reg[19] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[19]),
        .Q(pcOut[19]));
  FDCE \pcOut_reg[1] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[1]),
        .Q(pcOut[1]));
  FDCE \pcOut_reg[20] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[20]),
        .Q(pcOut[20]));
  FDCE \pcOut_reg[21] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[21]),
        .Q(pcOut[21]));
  FDCE \pcOut_reg[22] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[22]),
        .Q(pcOut[22]));
  FDCE \pcOut_reg[23] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[23]),
        .Q(pcOut[23]));
  FDCE \pcOut_reg[24] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[24]),
        .Q(pcOut[24]));
  FDCE \pcOut_reg[25] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[25]),
        .Q(pcOut[25]));
  FDCE \pcOut_reg[26] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[26]),
        .Q(pcOut[26]));
  FDCE \pcOut_reg[27] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[27]),
        .Q(pcOut[27]));
  FDCE \pcOut_reg[28] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[28]),
        .Q(pcOut[28]));
  FDCE \pcOut_reg[29] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[29]),
        .Q(pcOut[29]));
  FDCE \pcOut_reg[2] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[2]),
        .Q(pcOut[2]));
  FDCE \pcOut_reg[30] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[30]),
        .Q(pcOut[30]));
  FDCE \pcOut_reg[31] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[31]),
        .Q(pcOut[31]));
  FDCE \pcOut_reg[3] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[3]),
        .Q(pcOut[3]));
  FDCE \pcOut_reg[4] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[4]),
        .Q(pcOut[4]));
  FDCE \pcOut_reg[5] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[5]),
        .Q(pcOut[5]));
  FDCE \pcOut_reg[6] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[6]),
        .Q(pcOut[6]));
  FDCE \pcOut_reg[7] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[7]),
        .Q(pcOut[7]));
  FDCE \pcOut_reg[8] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[8]),
        .Q(pcOut[8]));
  FDCE \pcOut_reg[9] 
       (.C(clk),
        .CE(\pcOut[31]_i_1_n_0 ),
        .CLR(rst),
        .D(p_0_in[9]),
        .Q(pcOut[9]));
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
