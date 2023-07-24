`include "Coefficient_calculator_controller.v"
`include "Coefficient_calculator_datapath.v"

module Coefficient_calculator(inX, inY, meanStart, calcStart, clk, rst, meanReady, calcReady, outB0, outB1);
    input [19:0] inX, inY;
    input meanStart, calcStart, clk, rst;
    output meanReady, calcReady;
    output [19:0] outB0, outB1;


    wire ldX, ldY,
         clrSumX, clrSumY, ldSumX, ldSumY,
         divideXbarY, ldMeanX, ldMeanY,
         subForYiOrB0, multForXiOrB0,
         clrSSxx, clrSSxy, ldSSxx, ldSSxy,
         ldB0, ldB1;


    Coefficient_calculator_datapath dp(
        inX, inY, clk, rst, ldX, ldY,
        clrSumX, clrSumY, ldSumX, ldSumY,
        divideXbarY, ldMeanX, ldMeanY,
        subForYiOrB0, multForXiOrB0,
        clrSSxx, clrSSxy, ldSSxx, ldSSxy,
        ldB0, ldB1, outB0, outB1
    );
    Coefficient_calculator_controller cu(
        meanStart, calcStart, clk, rst,
        meanReady, calcReady,
        ldX, ldY,
        clrSumX, clrSumY, ldSumX, ldSumY,
        divideXbarY, ldMeanX, ldMeanY,
        subForYiOrB0, multForXiOrB0,
        clrSSxx, clrSSxy, ldSSxx, ldSSxy,
        ldB0, ldB1
    );
endmodule
