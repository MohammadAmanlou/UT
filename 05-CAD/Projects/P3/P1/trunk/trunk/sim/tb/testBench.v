`timescale 1ns/1ns
module testBench();
	reg clk=0,start=0;
	reg [6:0] X,Y,Z;
	wire done;
	mainProccess	#6 mainProccess(.clk(clk),.start(start),.X(X),.Y(Y),.Z(Z),.doneOut(done));
	always #60 clk=~clk;
	initial begin 
		X=24;
		Y=0;
		Z=0;
		#50 start=1;
		#200 start=0;
		#1200000 $stop;
	end
endmodule
