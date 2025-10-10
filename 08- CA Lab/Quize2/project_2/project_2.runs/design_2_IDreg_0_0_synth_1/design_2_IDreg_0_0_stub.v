// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun May 18 17:03:59 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_2_IDreg_0_0_stub.v
// Design      : design_2_IDreg_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "IDreg,Vivado 2018.3" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clk, rst, flush, pc, WB_EN, MEM_R_EN, MEM_W_EN, 
  EXE_CMD, B, S, Val_Rn, Val_Rm, imm, Shift_operand, Signed_imm_24, dest, status, src_1, src_2, pcOut, 
  WB_EN_out, MEM_R_EN_out, MEM_W_EN_out, EXE_CMD_out, B_out, S_out, Val_Rn_out, Val_Rm_out, 
  imm_out, Shift_operand_out, Signed_imm_24_out, dest_out, status_out, src_1_out, src_2_out)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,flush,pc[31:0],WB_EN,MEM_R_EN,MEM_W_EN,EXE_CMD[3:0],B,S,Val_Rn[31:0],Val_Rm[31:0],imm,Shift_operand[11:0],Signed_imm_24[23:0],dest[3:0],status[3:0],src_1[3:0],src_2[3:0],pcOut[31:0],WB_EN_out,MEM_R_EN_out,MEM_W_EN_out,EXE_CMD_out[3:0],B_out,S_out,Val_Rn_out[31:0],Val_Rm_out[31:0],imm_out,Shift_operand_out[11:0],Signed_imm_24_out[23:0],dest_out[3:0],status_out[3:0],src_1_out[3:0],src_2_out[3:0]" */;
  input clk;
  input rst;
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
endmodule
