`include "CpuDatapath.v"
`include "CpuController.v"

module Cpu (inst, memReadData, clk, rst, pc, memAdr, memWriteData, memRead, memWrite);
    input [31:0] inst, memReadData;
    input clk, rst;
    output [31:0] pc, memAdr, memWriteData;
    output memRead, memWrite;

    wire zero, pcOrMemAlu, regDst, link, regWrite, aluSrc, pcSrc, jumpReg, jump, memToReg;

    wire [2:0] aluOp;

    CpuDatapath dp(inst, memReadData, pcOrMemAlu, regDst, link,
                   regWrite, aluSrc, pcSrc, jumpReg, jump, memToReg,
                   aluOp, clk, rst, zero, pc, memAdr, memWriteData);

    CpuController cu(inst[31:26], inst[5:0], zero, memRead, memWrite,
                     pcOrMemAlu, regDst, link, regWrite, aluSrc,
                     pcSrc, jumpReg, jump, memToReg, aluOp);
endmodule
