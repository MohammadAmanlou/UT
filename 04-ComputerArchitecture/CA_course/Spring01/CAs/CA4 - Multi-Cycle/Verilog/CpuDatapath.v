`include "ALU.v"
`include "Memory.v"
`include "RegisterFile.v"
`include "Register.v"
`include "Mux.v"

module CpuDatapath (memData, PcWrite, branch, IorD, IRWrite, regDst, moveTo, dataFromMem,
                    noOp, regWrite, ALUSrcA, ALUSrcB, ALUopc, PcSrc, clk, rst, memAdr, memWriteData, opcode, func);
    input [15:0] memData;
    input PcWrite, branch, IorD, IRWrite, regDst, moveTo, dataFromMem, noOp, regWrite, ALUSrcA;
    input [1:0] ALUSrcB, PcSrc;
    input [2:0] ALUopc;
    input clk, rst;
    output [11:0] memAdr;
    output [15:0] memWriteData;
    output [3:0] opcode;
    output [8:0] func;

    wire zero;

    wire [11:0] pcRegOut, pcRegIn;
    wire pcRegWrite;
    assign pcRegWrite = (zero & branch) | PcWrite;
    Register #(.N(12), .Init(0)) pcReg(.in(pcRegIn), .ld(pcRegWrite), .clk(clk), .rst(rst), .out(pcRegOut));

    wire [11:0] leastInst12Bits;
    Mux2To1 #(12) memAdrMux(.a0(pcRegOut), .a1(leastInst12Bits), .sel(IorD), .out(memAdr));

    wire [15:0] inst, data;
    Register #(.N(16)) IR(.in(memData), .ld(IRWrite), .clk(clk), .rst(rst), .out(inst));
    Register #(.N(16)) MDR(.in(memData), .ld(1'b1), .clk(clk), .rst(rst), .out(data));

    assign leastInst12Bits = inst[11:0];

    wire [2:0] regFileWriteAdr;
    wire [15:0] regFileWriteData, aluRegOut;
    Mux2To1 #(3)  regFileWriteAdrMux(.a0(3'd0), .a1(inst[11:9]), .sel(regDst | moveTo), .out(regFileWriteAdr));
    Mux2To1 #(16) regFileWriteDataMux(.a0(aluRegOut), .a1(data), .sel(dataFromMem), .out(regFileWriteData));

    wire [15:0] ARegIn, ARegOut, BRegIn, BRegOut;
    RegisterFile regFile(.readAdr(inst[11:9]), .writeAdr(regFileWriteAdr), .writeData(regFileWriteData),
                         .regWrite(regWrite & ~noOp), .clk(clk), .rst(rst), .readData0(ARegIn), .readData1(BRegIn));

    Register #(.N(16)) AReg(.in(ARegIn), .ld(1'b1), .clk(clk), .rst(rst), .out(ARegOut));
    Register #(.N(16)) BReg(.in(BRegIn), .ld(1'b1), .clk(clk), .rst(rst), .out(BRegOut));

    wire [15:0] aluInA, aluInB, SExtendedLeastInst12Bits;
    assign SExtendedLeastInst12Bits = {{4{leastInst12Bits[11]}}, leastInst12Bits};
    Mux2To1 #(16) aluInAMux(.a0(ARegOut), .a1({4'd0, pcRegOut}), .sel(ALUSrcA), .out(aluInA));
    Mux4To1 #(16) aluInBMux(.a00(BRegOut), .a01(16'd1), .a10(SExtendedLeastInst12Bits), .sel(ALUSrcB), .out(aluInB));

    wire [15:0] aluRegIn;
    ALU #(16) alu(.a(aluInA), .b(aluInB), .opc(ALUopc), .res(aluRegIn), .zero(zero));
    Register #(16) aluReg(.in(aluRegIn), .ld(1'b1), .clk(clk), .rst(rst), .out(aluRegOut));

    Mux4To1 #(12) pcMux(.a00(aluRegIn[11:0]), .a01({pcRegOut[11:9], inst[8:0]}), .a10(inst[11:0]), .sel(PcSrc), .out(pcRegIn));

    assign memWriteData = ARegOut;
    assign opcode = inst[15:12];
    assign func = inst[8:0];
endmodule
