`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2025 11:21:48 AM
// Design Name: 
// Module Name: RedAdder
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


module RedAdder(
    input  [23:0] a,
    input  [31:0] b,
    output [31:0] out
);
    assign out = {{8{a[23]}}, a} + b;  // Sign-extend a to 32 bits
    //    assign out = {8'b0, a} + b;  // Unsigned-extend a to 32 bits
endmodule
