`include "Memory.v"
`include "Counter_modN.v"

module Data_loader_datapath(inX, inY, cntEn, cntClr, memWrite, clk, rst, outX, outY, cntCo);
    input [19:0] inX, inY;
    input cntEn, cntClr, memWrite, clk, rst;
    output [19:0] outX, outY;
    output cntCo;

    wire [7:0] address;

    Counter_modN #(150) cnt(.en(cntEn), .clr(cntClr), .clk(clk), .rst(rst), .co(cntCo), .cnt(address));

    Memory #(.WordSize(20), .WordCount(150)) xMem(
        .adr(address), .dataIn(inX), .write(memWrite), .clr(1'b0), .clk(clk), .rst(rst),
        .dataOut(outX)
    );
    Memory #(.WordSize(20), .WordCount(150)) yMem(
        .adr(address), .dataIn(inY), .write(memWrite), .clr(1'b0), .clk(clk), .rst(rst),
        .dataOut(outY)
    );
endmodule
