module DFF(clk,en,sclr,in,out);
	input clk,en,sclr,in;
	output reg out=1'b0;
	always@(posedge clk)
		if(sclr)
			out<=1'b0;
		else if(en)
			out<=in;




endmodule

