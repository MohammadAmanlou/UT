// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun May 11 11:31:34 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/ariya/OneDrive/Desktop/project_1/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_ConditionCheck_0_0/design_2_ConditionCheck_0_0_stub.v
// Design      : design_2_ConditionCheck_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ConditionCheck,Vivado 2018.3" *)
module design_2_ConditionCheck_0_0(opcode, status, condOut)
/* synthesis syn_black_box black_box_pad_pin="opcode[3:0],status[3:0],condOut" */;
  input [3:0]opcode;
  input [3:0]status;
  output condOut;
endmodule
