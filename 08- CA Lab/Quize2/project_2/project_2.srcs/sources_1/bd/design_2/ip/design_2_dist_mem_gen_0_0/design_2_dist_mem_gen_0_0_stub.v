// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun May  4 16:14:57 2025
// Host        : DESKTOP-JOGDHNR running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/a/Desktop/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_dist_mem_gen_0_0/design_2_dist_mem_gen_0_0_stub.v
// Design      : design_2_dist_mem_gen_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_12,Vivado 2018.3" *)
module design_2_dist_mem_gen_0_0(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[12:0],spo[31:0]" */;
  input [12:0]a;
  output [31:0]spo;
endmodule
