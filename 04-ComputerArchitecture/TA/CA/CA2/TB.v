`timescale 1ns/1ns
module	TBPipe();
	reg clk=1'b0;
	reg rst = 0;
	TopLevelPipe	DUT(clk , rst);
	always #1 clk=~clk;
	initial begin 
	#1 rst =1;
	#1 rst=0;
	#5000
	#50 $stop;
	end
endmodule

