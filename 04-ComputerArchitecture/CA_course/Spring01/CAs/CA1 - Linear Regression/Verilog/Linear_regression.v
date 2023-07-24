`include "Data_loader.v"
`include "Coefficient_calculator.v"
`include "Error_checker.v"

module Linear_regression(inX, inY, start, clk, rst, outB0, outB1, outErr, loaderReady, errDone);
    input [19:0] inX, inY;
    input start, clk, rst;
    output [19:0] outB0, outB1, outErr;
    output loaderReady, errDone;

    wire [19:0] x, y;
    wire meanReady, calcReady, errReady;
    wire meanStart, calcStart, errStart;

    Data_loader loader(
        inX, inY, start, meanReady, calcReady, errReady, clk, rst,
        x, y, loaderReady, meanStart, calcStart, errStart, errDone
    );
    Coefficient_calculator calc(
        x, y, meanStart, calcStart, clk, rst,
        meanReady, calcReady, outB0, outB1
    );
    Error_checker error(
        x, y, outB0, outB1, errStart, clk, rst,
        outErr, errReady
    );
endmodule
