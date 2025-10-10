// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Mar  9 10:59:20 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/ariya/ARM/ARM.srcs/sources_1/bd/design_2/ip/design_2_PC_0/design_2_PC_0_stub.v
// Design      : design_2_PC_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "Register,Vivado 2018.3" *)
module design_2_PC_0(clk, rst, freeze, in, outReg)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,freeze,in[31:0],outReg[31:0]" */;
  input clk;
  input rst;
  input freeze;
  input [31:0]in;
  output [31:0]outReg;
endmodule
