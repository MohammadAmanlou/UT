`include "Controller.v"
`include "ForwardingUnit.v"
`include "HazardUnit.v"

module CpuController (opc, func, equal, IFIDRs, IFIDRt, IDExMemRead, ExMemRd, MemWBRd,
                      ExMemRegWrite, MemWBRegWrite, IDExRs, IDExRt, clk, rst,
                      PcSrc, IFIDFlush, ALUSrc, RegDst, MemRead, MemWrite, RegData,
                      RegWrite, ALUOpc, PcWrite, IFIDLoad, IDExFlush, forwardA, forwardB);
    input [5:0] opc, func;
    input equal, IDExMemRead, ExMemRegWrite, MemWBRegWrite;
    input [4:0] IFIDRs, IFIDRt, IDExRs, IDExRt, ExMemRd, MemWBRd;
    input clk, rst;
    output [1:0] PcSrc, RegDst, RegData, forwardA, forwardB;
    output [2:0] ALUOpc;
    output IFIDLoad, IFIDFlush, IDExFlush, ALUSrc, MemRead, MemWrite, RegWrite, PcWrite;

    Controller controller(opc, func, equal, clk, rst, PcSrc, IFIDFlush, ALUSrc,
                          RegDst, MemRead, MemWrite, RegData, RegWrite, ALUOpc);

    HazardUnit hazardUnit(IFIDRs, IFIDRt, IDExRt, IDExMemRead, PcWrite, IFIDLoad, IDExFlush);

    ForwardingUnit forwardingUnit(ExMemRd, MemWBRd, ExMemRegWrite, MemWBRegWrite, IDExRs, IDExRt, forwardA, forwardB);
endmodule
