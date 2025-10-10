module Mux2to1(
	input select,
	input [31:0] a,
	input [31:0] b,
	output[31:0] out0
	);
	assign out0= (select==0) ? a : b ;
endmodule