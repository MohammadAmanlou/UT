`timescale 1 ns/ 100 ps
module counter (input clk,rst,zero,ld,enb, input [2:0] in ,output reg [3:0] out, output  co);
	always@(posedge clk, posedge rst)begin
		if(rst == 1'b1)
			out <= 0;
		else
			if(zero == 1'b1)
				out <= 0;
			else if(ld == 1'b1)
				out <= in;
			else if(enb == 1'b1)
				out <= out + 1'b1;
	end
	assign co = (out >= 4'b1000)? 1'b1: 1'b0;
endmodule 