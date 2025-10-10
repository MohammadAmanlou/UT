// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun May 18 17:51:03 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_2_RegisterFile_0_0_stub.v
// Design      : design_2_RegisterFile_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "RegisterFile,Vivado 2018.3" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clk, rst, rn, rm, WB_Dest, WB_Value, WB_WB_EN, Val_Rn, 
  Val_Rm, R0, R1, R2, R3, R4, R5, R6)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,rn[3:0],rm[3:0],WB_Dest[3:0],WB_Value[31:0],WB_WB_EN,Val_Rn[31:0],Val_Rm[31:0],R0[31:0],R1[31:0],R2[31:0],R3[31:0],R4[31:0],R5[31:0],R6[31:0]" */;
  input clk;
  input rst;
  input [3:0]rn;
  input [3:0]rm;
  input [3:0]WB_Dest;
  input [31:0]WB_Value;
  input WB_WB_EN;
  output [31:0]Val_Rn;
  output [31:0]Val_Rm;
  output [31:0]R0;
  output [31:0]R1;
  output [31:0]R2;
  output [31:0]R3;
  output [31:0]R4;
  output [31:0]R5;
  output [31:0]R6;
endmodule
