`timescale 1ns/1ns
module waveformGeneratorTB();
	reg clk = 0 ;
	reg rst ;
	reg phase_cnt ;
	reg[2:0]func;
	wire[7:0]out;
	waveform_generator wg(clk,rst,phase_cnt ,func  , out);
	always #1 clk = ~clk;
	initial begin 
	#5 
	rst = 1;
	#5
	rst = 0;
	#5
	phase_cnt = 0;
	#5
	func = 3'b001;
	#10000
	$stop ;
	end

endmodule