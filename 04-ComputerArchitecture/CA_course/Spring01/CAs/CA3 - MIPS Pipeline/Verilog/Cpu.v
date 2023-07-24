`include "CpuDatapath.v"
`include "CpuController.v"

module Cpu (Inst, MemReadData, clk, rst, Pc, MemAdr, MemWriteData, MemoryRead, MemoryWrite);
    input [31:0] Inst, MemReadData;
    input clk, rst;
    output [31:0] Pc, MemAdr, MemWriteData;
    output MemoryRead, MemoryWrite;

    wire PcWrite, IFIDFlush, IDExFlush, IFIDLoad, ALUSrc, MemRead, MemWrite, RegWrite, equal,
         IDExMemRead, ExMemRegWrite, MemWBRegWrite;
    wire [1:0] PcSrc, RegDst, RegData, forwardA, forwardB;
    wire [2:0] ALUOpc;
    wire [5:0] opc, func;
    wire [4:0] IFIDRs, IFIDRt, ExMemRd, MemWBRd, IDExRs, IDExRt;

    CpuDatapath dp(Inst, MemReadData, PcWrite, PcSrc, IFIDFlush, IDExFlush, IFIDLoad, ALUOpc, ALUSrc,
                   RegDst, MemRead, MemWrite, RegData, RegWrite, forwardA, forwardB, clk, rst,
                   Pc, equal, MemAdr, MemWriteData, MemoryRead, MemoryWrite, opc, func, IFIDRs, IFIDRt,
                   IDExMemRead, ExMemRd, MemWBRd, ExMemRegWrite, MemWBRegWrite, IDExRs, IDExRt);

    CpuController cu(opc, func, equal, IFIDRs, IFIDRt, IDExMemRead, ExMemRd, MemWBRd,
                     ExMemRegWrite, MemWBRegWrite, IDExRs, IDExRt, clk, rst,
                     PcSrc, IFIDFlush, ALUSrc, RegDst, MemRead, MemWrite, RegData,
                     RegWrite, ALUOpc, PcWrite, IFIDLoad, IDExFlush, forwardA, forwardB);
endmodule
