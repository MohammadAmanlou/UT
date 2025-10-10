// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Apr 20 17:59:04 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_2_MEM_Stage_Reg_0_0_stub.v
// Design      : design_2_MEM_Stage_Reg_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "MEM_Stage_Reg,Vivado 2018.3" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clk, rst, WB_EN, MEM_R_EN, ALU_Res, data_mem, dest, 
  WB_EN_out, MEM_R_EN_out, ALU_Res_out, data_mem_out, dest_out)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,WB_EN,MEM_R_EN,ALU_Res[31:0],data_mem[31:0],dest[3:0],WB_EN_out,MEM_R_EN_out,ALU_Res_out[31:0],data_mem_out[31:0],dest_out[3:0]" */;
  input clk;
  input rst;
  input WB_EN;
  input MEM_R_EN;
  input [31:0]ALU_Res;
  input [31:0]data_mem;
  input [3:0]dest;
  output WB_EN_out;
  output MEM_R_EN_out;
  output [31:0]ALU_Res_out;
  output [31:0]data_mem_out;
  output [3:0]dest_out;
endmodule
