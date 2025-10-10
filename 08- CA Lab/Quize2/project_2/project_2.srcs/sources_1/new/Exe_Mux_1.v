`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 04:38:53 PM
// Design Name: 
// Module Name: Exe_Mux_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Exe_Mux(
input [1:0] sel,
input [31:0] val,
input [31:0] ALU_res,
input [31:0] WB_value,
output [31:0] out
    );
    assign out = sel == 2'b00 ? val : sel == 2'b01 ? ALU_res : WB_value;
endmodule
