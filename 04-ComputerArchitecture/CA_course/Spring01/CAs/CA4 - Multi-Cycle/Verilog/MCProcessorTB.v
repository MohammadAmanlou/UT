`include "MCProcessor.v"

`timescale 1ns/1ns

module MCProcessorTB ();
    reg clk = 1'b0, rst = 1'b0;

    MCProcessor processor(clk, rst);

    always #5 clk = ~clk;

    initial begin
        #1 rst = 1'b1;
        #3 rst = 1'b0;
        #7000 $finish;
    end
endmodule
