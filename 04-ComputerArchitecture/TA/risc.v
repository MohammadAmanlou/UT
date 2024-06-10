`timescale 1ns/1ns
module risc_v(clk ,rst);
    input clk,rst;

    wire RegWrite, MemWrite;
    wire[1:0] ResultSrc, PCSrc, ALUSrc2;
    wire[2:0] ALUControl, ImmSrc;
    wire [6:0] opcode;
    wire lt, bge, zero;
    wire[2:0] func3;
    wire[6:0] func7;

    datapath dp(clk, rst, RegWrite, MemWrite, ResultSrc, PCSrc, ALUSrc2, ALUControl,ImmSrc, lt ,bge, zero, opcode, func3, func7);
    controller cntr(opcode, func3, func7, zero, bge, lt, PCSrc, ResultSrc, MemWrite, ALUControl, ALUSrc2, ImmSrc, RegWrite);
    


endmodule