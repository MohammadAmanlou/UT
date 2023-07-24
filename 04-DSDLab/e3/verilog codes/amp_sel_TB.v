`timescale 1ns/1ns 
module amp_sel_TB();
	reg [1:0] sel ;
 	reg [7:0] in = 8'b00010000;
	wire [7:0] out;
	amp_sel a1(sel ,  in ,out);
	initial begin 
	sel=2'b00;
	#5 sel=2'b01;
	#5 sel=2'b10;
	#5 sel=2'b11;
	#5;
	$stop;
	end
endmodule