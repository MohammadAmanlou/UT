`timescale 1ns/1ns
module	TBPipe();
	reg clk=1'b0;
	TopLevelPipe	P(clk);
	always #20 clk=~clk;
	initial begin 
	#20000
	$stop;
	end
endmodule

