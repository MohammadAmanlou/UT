`include "Register.v"
`include "DFF.v"

module RegIF_ID (PcIn, InstIn, Flush, Load, clk, rst, PcOut, InstOut);
    input [31:0] PcIn, InstIn;
    input Flush, Load, clk, rst;
    output [31:0] PcOut, InstOut;

    Register #(32) PcReg(.in(PcIn), .ld(Load), .sclr(Flush), .clk(clk), .rst(rst), .out(PcOut));
    Register #(32) InstReg(.in(InstIn), .ld(Load), .sclr(Flush), .clk(clk), .rst(rst), .out(InstOut));
endmodule

module RegID_Ex (ALUOpcIn, ALUSrcIn, RegDstIn, MemReadIn, MemWriteIn, RegDataIn, RegWriteIn,
                 ReadData1In, ReadData2In, SExtendedIn, RsIn, RtIn, RdIn, PcIn, Flush, clk, rst,
                 ALUOpcOut, ALUSrcOut, RegDstOut, MemReadOut, MemWriteOut, RegDataOut, RegWriteOut,
                 ReadData1Out, ReadData2Out, SExtendedOut, RsOut, RtOut, RdOut, PcOut);
    input ALUSrcIn, MemReadIn, MemWriteIn, RegWriteIn;
    input [1:0] RegDstIn, RegDataIn;
    input [2:0] ALUOpcIn;
    input [31:0] ReadData1In, ReadData2In, SExtendedIn, PcIn;
    input [4:0] RsIn, RtIn, RdIn;
    input Flush, clk, rst;
    output ALUSrcOut, MemReadOut, MemWriteOut, RegWriteOut;
    output [1:0] RegDstOut, RegDataOut;
    output [2:0] ALUOpcOut;
    output [31:0] ReadData1Out, ReadData2Out, SExtendedOut, PcOut;
    output [4:0] RsOut, RtOut, RdOut;

    DFF ALUSrcDff(.in(ALUSrcIn), .ld(1'b1), .sclr(Flush), .clk(clk), .rst(rst), .out(ALUSrcOut));
    DFF MemReadDff(.in(MemReadIn), .ld(1'b1), .sclr(Flush), .clk(clk), .rst(rst), .out(MemReadOut));
    DFF MemWriteDff(.in(MemWriteIn), .ld(1'b1), .sclr(Flush), .clk(clk), .rst(rst), .out(MemWriteOut));
    DFF RegWriteDff(.in(RegWriteIn), .ld(1'b1), .sclr(Flush), .clk(clk), .rst(rst), .out(RegWriteOut));

    Register #(2) RegDstReg(.in(RegDstIn), .ld(1'b1), .sclr(Flush), .clk(clk), .rst(rst), .out(RegDstOut));
    Register #(2) RegDataReg(.in(RegDataIn), .ld(1'b1), .sclr(Flush), .clk(clk), .rst(rst), .out(RegDataOut));

    Register #(3) ALUOpcReg(.in(ALUOpcIn), .ld(1'b1), .sclr(Flush), .clk(clk), .rst(rst), .out(ALUOpcOut));

    Register #(32) ReadData1Reg(.in(ReadData1In), .ld(1'b1), .sclr(Flush), .clk(clk), .rst(rst), .out(ReadData1Out));
    Register #(32) ReadData2Reg(.in(ReadData2In), .ld(1'b1), .sclr(Flush), .clk(clk), .rst(rst), .out(ReadData2Out));
    Register #(32) SExtendedReg(.in(SExtendedIn), .ld(1'b1), .sclr(Flush), .clk(clk), .rst(rst), .out(SExtendedOut));
    Register #(32) PcReg(.in(PcIn), .sclr(Flush), .ld(1'b1), .clk(clk), .rst(rst), .out(PcOut));

    Register #(5) RsReg(.in(RsIn), .ld(1'b1), .sclr(Flush), .clk(clk), .rst(rst), .out(RsOut));
    Register #(5) RtReg(.in(RtIn), .ld(1'b1), .sclr(Flush), .clk(clk), .rst(rst), .out(RtOut));
    Register #(5) RdReg(.in(RdIn), .ld(1'b1), .sclr(Flush), .clk(clk), .rst(rst), .out(RdOut));
endmodule

module RegEx_Mem (MemReadIn, MemWriteIn, RegDataIn, RegWriteIn, ALUResIn, ReadData2In, RdIn, PcIn, clk, rst,
                  MemReadOut, MemWriteOut, RegDataOut, RegWriteOut, ALUResOut, ReadData2Out, RdOut, PcOut);
    input MemReadIn, MemWriteIn, RegWriteIn;
    input [1:0] RegDataIn;
    input [31:0] ALUResIn, ReadData2In, PcIn;
    input [4:0] RdIn;
    input clk, rst;
    output MemReadOut, MemWriteOut, RegWriteOut;
    output [1:0] RegDataOut;
    output [31:0] ALUResOut, ReadData2Out, PcOut;
    output [4:0] RdOut;

    DFF MemReadDff(.in(MemReadIn), .ld(1'b1), .sclr(1'b0), .clk(clk), .rst(rst), .out(MemReadOut));
    DFF MemWriteDff(.in(MemWriteIn), .ld(1'b1), .sclr(1'b0), .clk(clk), .rst(rst), .out(MemWriteOut));
    DFF RegWriteDff(.in(RegWriteIn), .ld(1'b1), .sclr(1'b0), .clk(clk), .rst(rst), .out(RegWriteOut));

    Register #(2) RegDataReg(.in(RegDataIn), .ld(1'b1), .sclr(1'b0), .clk(clk), .rst(rst), .out(RegDataOut));

    Register #(32) ALUResReg(.in(ALUResIn), .ld(1'b1), .sclr(1'b0), .clk(clk), .rst(rst), .out(ALUResOut));
    Register #(32) ReadData2Reg(.in(ReadData2In), .ld(1'b1), .sclr(1'b0), .clk(clk), .rst(rst), .out(ReadData2Out));
    Register #(32) PcReg(.in(PcIn), .ld(1'b1), .sclr(1'b0), .clk(clk), .rst(rst), .out(PcOut));

    Register #(5) RdReg(.in(RdIn), .ld(1'b1), .sclr(1'b0), .clk(clk), .rst(rst), .out(RdOut));
endmodule

module RegMem_WB (RegDataIn, RegWriteIn, MemDataIn, ALUResIn, RdIn, PcIn, clk, rst,
                  RegDataOut, RegWriteOut, MemDataOut, ALUResOut, RdOut, PcOut);
    input RegWriteIn;
    input [1:0] RegDataIn;
    input [31:0] MemDataIn, ALUResIn, PcIn;
    input [4:0] RdIn;
    input clk, rst;
    output RegWriteOut;
    output [1:0] RegDataOut;
    output [31:0] MemDataOut, ALUResOut, PcOut;
    output [4:0] RdOut;

    DFF RegWriteDff(.in(RegWriteIn), .ld(1'b1), .sclr(1'b0), .clk(clk), .rst(rst), .out(RegWriteOut));

    Register #(2) RegDataReg(.in(RegDataIn), .ld(1'b1), .sclr(1'b0), .clk(clk), .rst(rst), .out(RegDataOut));

    Register #(32) ALUResReg(.in(ALUResIn), .ld(1'b1), .sclr(1'b0), .clk(clk), .rst(rst), .out(ALUResOut));
    Register #(32) MemDataReg(.in(MemDataIn), .ld(1'b1), .sclr(1'b0), .clk(clk), .rst(rst), .out(MemDataOut));
    Register #(32) PcReg(.in(PcIn), .ld(1'b1), .sclr(1'b0), .clk(clk), .rst(rst), .out(PcOut));

    Register #(5) RdReg(.in(RdIn), .ld(1'b1), .sclr(1'b0), .clk(clk), .rst(rst), .out(RdOut));
endmodule
