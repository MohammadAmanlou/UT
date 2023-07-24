`include "CpuDatapath.v"
`include "CpuController.v"

module Cpu (memData, clk, rst, memAdr, memWriteData, memWrite, memRead);
    input clk, rst;
    input [15:0] memData;
    output [11:0] memAdr;
    output [15:0] memWriteData;
    output memWrite, memRead;

    wire IorD, IRWrite, regDst, dataFromMem, regWrite, aluSrcA, PcWrite, branch, noOp, moveTo;
    wire [1:0] aluSrcB, PcSrc;
    wire [2:0] aluOpc;
    wire [3:0] opcode;
    wire [8:0] func;

    CpuDatapath datapath(memData, PcWrite, branch, IorD, IRWrite, regDst, moveTo, dataFromMem, noOp, regWrite,
                         aluSrcA, aluSrcB, aluOpc, PcSrc, clk, rst, memAdr, memWriteData, opcode, func);

    CpuController controller(opcode, func, clk, rst, memWrite, memRead, IorD,
                             IRWrite, regDst, dataFromMem, regWrite, aluSrcA, aluSrcB, aluOpc,
                             PcSrc, PcWrite, branch, noOp, moveTo);
endmodule
