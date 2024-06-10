`timescale 1ns/1ns
module regfile(clk,rst, RegWrite, A1, A2, A3, WD3, RD1, RD2);
    input clk, rst;
    input RegWrite;
    input [4:0] A1;
    input [4:0] A2;
    input [4:0] A3;
    input [31:0] WD3;
    output [31:0] RD1;
    output [31:0] RD2;

    reg [31:0] registers [31:0];

    assign RD1 = registers[A1];
    assign RD2 = registers[A2];

    always @(posedge clk or posedge rst) begin
      if (rst) registers[0]=32'd0;
      else if (RegWrite & A3 !=5'd0)
	    begin
	        registers[A3] <= WD3;
      end
    end
endmodule