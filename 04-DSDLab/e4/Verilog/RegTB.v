`timescale 1 ns/ 1 ns
module UI_RegTB();
	reg clk = 0;
	reg ld, rst;
	reg[1:0] in;
	wire [1:0] out;
	
	UI_Reg ur(clk , rst , ld , in,out);

	always #1 clk = ~clk;
	initial begin
		rst = 1'b1;
		#5 rst = 1'b0;
		#5 ld = 1;
		#5 in = 2'b00;
		#5 ld = 0;
		#5  ld =1 ; in = 2'b01;
		#5 in = 2'b11;
		#10 $stop;
	end

endmodule 
