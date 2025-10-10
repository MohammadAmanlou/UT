//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Sun May 25 18:04:44 2025
//Host        : Ariyan running 64-bit major release  (build 9200)
//Command     : generate_target design_2_wrapper.bd
//Design      : design_2_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_2_wrapper
   (clk_0,
    rst_0);
  input clk_0;
  input rst_0;

  wire clk_0;
  wire rst_0;

  design_2 design_2_i
       (.clk_0(clk_0),
        .rst_0(rst_0));
endmodule
