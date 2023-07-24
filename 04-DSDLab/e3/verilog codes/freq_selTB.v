`timescale 1ns/1ns 
module freq_sel_TB();
	reg clk = 0;
	reg rst , ld_init;
	wire out;
	reg[2:0] digit;
	freq_sel f1(ld_init , clk , rst , digit  ,out);
	always #1 clk = ~clk;
	initial begin 
	#5
	rst = 1;
	#5
	rst = 0;
	digit=3'b100;
	ld_init = 1;
	#5
	ld_init = 0;
	#1000
	$stop;
	end
endmodule
