`timescale 1 ns/ 1 ns
module CombShiftTB();
	reg[1:0] shift;
	reg [17:0] data_in = 18'b1111111000001011001100;
	wire [20:0] data_out;
	
	CombShift CS(shift,data_in,data_out);

	initial begin
		#5 shift = 2'b00;
		#5 shift = 2'b01;
		#5 shift = 2'b10;
		#5 shift = 2'b11;
		#30 $stop;
	end

endmodule 
