// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Mar  9 10:58:46 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/ariya/ARM/ARM.srcs/sources_1/bd/design_2/ip/design_2_Mux_0/design_2_Mux_0_stub.v
// Design      : design_2_Mux_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "Mux2to1,Vivado 2018.3" *)
module design_2_Mux_0(select, a, b, out0)
/* synthesis syn_black_box black_box_pad_pin="select,a[31:0],b[31:0],out0[31:0]" */;
  input select;
  input [31:0]a;
  input [31:0]b;
  output [31:0]out0;
endmodule
