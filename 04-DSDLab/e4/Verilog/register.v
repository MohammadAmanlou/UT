`timescale 1 ns/ 100 ps
module register (input clk,rst,zero,init,ld, input [15:0] r_in, output reg [15:0] r_out);

	always@(posedge clk, posedge rst)begin
		if(rst == 1'b1)
			r_out <= 0;
		else
			if(zero == 1'b1)
				r_out <= 0;
			else if (init == 1'b1)
				r_out <= 16'hFFFF;
			else if(ld == 1'b1)
				r_out <= r_in;
	end
 endmodule
