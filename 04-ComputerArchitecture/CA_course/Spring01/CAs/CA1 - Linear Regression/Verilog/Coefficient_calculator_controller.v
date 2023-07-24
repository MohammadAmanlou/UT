`include "Counter_modN.v"

`define Idle       4'b0000
`define MeanInit   4'b0001
`define MeanLdXY   4'b0010
`define MeanLdSum  4'b0011
`define MeanX      4'b0100
`define MeanY      4'b0101
`define CalcStWait 4'b0110
`define CalcInit   4'b0111
`define CalcLdXY   4'b1000
`define CalcSum    4'b1001
`define CalcB      4'b1010
`define CalcCount  4'b1011
`define CalcWait   4'b1100

module Coefficient_calculator_controller(meanStart, calcStart, clk, rst,
                                         meanReady, calcReady,
                                         ldX, ldY,
                                         clrSumX, clrSumY, ldSumX, ldSumY,
                                         divideXbarY, ldMeanX, ldMeanY,
                                         subForYiOrB0, multForXiOrB0,
                                         clrSSxx, clrSSxy, ldSSxx, ldSSxy,
                                         ldB0, ldB1);
    input meanStart, calcStart, clk, rst;
    output meanReady, calcReady,
           ldX, ldY,
           clrSumX, clrSumY, ldSumX, ldSumY,
           divideXbarY, ldMeanX, ldMeanY,
           subForYiOrB0, multForXiOrB0,
           clrSSxx, clrSSxy, ldSSxx, ldSSxy,
           ldB0, ldB1;
    reg meanReady, calcReady,
        ldX, ldY,
        clrSumX, clrSumY, ldSumX, ldSumY,
        divideXbarY, ldMeanX, ldMeanY,
        subForYiOrB0, multForXiOrB0,
        clrSSxx, clrSSxy, ldSSxx, ldSSxy,
        ldB0, ldB1;


    reg [3:0] ps, ns;
    reg cntEn, cntClr;
    wire cntCo;
    wire [7:0] cnt;

    Counter_modN #(150) counter(cntEn, cntClr, clk, rst, cntCo, cnt);

    always @(posedge clk) begin
        if (rst)
            ps <= 4'd0;
        else
            ps <= ns;
    end

    always @(ps or meanStart or calcStart or cntCo) begin
        case (ps)
            `Idle:       ns = meanStart ? `MeanInit : `Idle;
            `MeanInit:   ns = `MeanLdXY;
            `MeanLdXY:   ns = `MeanLdSum;
            `MeanLdSum:  ns = cntCo ? `MeanX: `MeanLdXY;
            `MeanX:      ns = `MeanY;
            `MeanY:      ns = `CalcStWait;
            `CalcStWait: ns = calcStart ? `CalcInit : `CalcStWait;
            `CalcInit:   ns = `CalcLdXY;
            `CalcLdXY:   ns = `CalcSum;
            `CalcSum:    ns = `CalcB;
            `CalcB:      ns = `CalcCount;
            `CalcCount:  ns = cntCo ? `Idle : `CalcWait;
            `CalcWait:   ns = `CalcLdXY;
            default: ns = `Idle;
        endcase
    end

    always @(ps) begin
        {cntEn, cntClr} = 2'd0;
        {meanReady, ldX, ldY, clrSumX, clrSumY, ldSumX, ldSumY, divideXbarY, ldMeanX, ldMeanY} = 10'd0;
        {calcReady, clrSSxx, clrSSxy, ldSSxx, ldSSxy, ldB0, ldB1, subForYiOrB0, multForXiOrB0} = 9'd0;
        case (ps)
            `Idle:;
            `MeanInit: {meanReady, cntClr, clrSumX, clrSumY} = 4'b1111;
            `MeanLdXY: {ldX, ldY} = 2'b11;
            `MeanLdSum: {cntEn, ldSumX, ldSumY} = 3'b111;
            `MeanX: {divideXbarY, ldMeanX} = 2'b01;
            `MeanY: {divideXbarY, ldMeanY} = 2'b11;
            `CalcStWait:;
            `CalcInit: {calcReady, cntClr, clrSSxx, clrSSxy} = 4'b1111;
            `CalcLdXY: {ldX, ldY} = 2'b11;
            `CalcSum: {ldSSxx, ldSSxy, subForYiOrB0, multForXiOrB0} = 4'b1100;
            `CalcB: {ldB0, ldB1, subForYiOrB0, multForXiOrB0, calcReady} = 5'b11111;
            `CalcCount: {cntEn} = 1'b1;
            `CalcWait:;
            default:;
        endcase
    end
endmodule
