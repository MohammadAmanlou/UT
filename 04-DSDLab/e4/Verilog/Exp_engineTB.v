`timescale 1 ns/ 1 ns
module expTB;
	reg clk, rst, start;
	reg [15:0] x;
	wire done;
	wire [1:0] intpart;
	wire [15:0]fracpart;
	
	exponential expEng(clk ,rst , start, x, done, intpart, fracpart);

	always #5 clk = ~clk;
	initial begin
		rst = 1'b1;
		clk = 1'b0;
		start = 1'b0;
		#10 start = 1'b1;
		#10 x = 0;
		#5 rst = 1'b0;
		#40 start = 1'b0;
		#10000;
		#50 x = 16'b0100000000000000;
		#1000 start = 1'b1;
		#20 start = 1'b0;
		#10000;
		#50 x = 16'h8000;
		#1000 start = 1'b1;
		#20 start = 1'b0;
		#30000 $stop;
	end

endmodule 
