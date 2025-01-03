`timescale 1ns/1ns
module TB();
	reg clk=0,start=0;
	reg [6:0] X,Y,Z,M;
	wire done;
	CNN	#4 CNN(.clk(clk),.start(start),.X(X),.Y(Y),.Z(Z),.M(M),.doneOut(done));
	always #10 clk=~clk;
	initial begin 
		X=16;
		Y=0;
		Z=0;
		M = 0;
		#20 start=1;
		#40 start=0;
		#1000000 $stop;
	end
endmodule

////everything is OK!