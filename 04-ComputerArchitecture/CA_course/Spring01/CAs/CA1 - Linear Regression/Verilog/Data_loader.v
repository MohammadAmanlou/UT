`include "Data_loader_controller.v"
`include "Data_loader_datapath.v"

module Data_loader(inX, inY, start, meanReady, calcReady, errReady, clk, rst,
                   outX, outY, ready, meanStart, calcStart, errStart, errDone);
    input [19:0] inX, inY;
    input start, meanReady, calcReady, errReady, clk, rst;
    output [19:0] outX, outY;
    output ready, meanStart, calcStart, errStart, errDone;

    wire cntEn, cntClr, cntCo, memWrite;

    Data_loader_datapath dp(
        .inX(inX), .inY(inY), .cntEn(cntEn), .cntClr(cntClr), .memWrite(memWrite), .clk(clk), .rst(rst),
        .outX(outX), .outY(outY), .cntCo(cntCo)
    );
    Data_loader_controller cu(
        .start(start), .cntCo(cntCo), .meanReady(meanReady), .calcReady(calcReady), .errReady(errReady), .clk(clk), .rst(rst),
        .ready(ready), .cntEn(cntEn), .cntClr(cntClr), .memWrite(memWrite), .meanStart(meanStart), .calcStart(calcStart), .errStart(errStart), .errDone(errDone)
    );
endmodule
