`timescale 1 ns/ 100 ps
module multiplier(input [15:0] a,b, output [15:0] c);
wire [31:0]temp;
	assign temp = a*b;
	assign c = temp[31:16];
endmodule
