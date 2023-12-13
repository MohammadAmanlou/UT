module Register(clk,en,sclr,in,out);
	parameter N=32;
	input clk,en,sclr;
	input[N-1:0] in;
	output reg[N-1:0] out={N{1'b0}};
	always@(posedge clk)begin
		if(sclr)
		    	out<={N{1'b0}};
		else if(en)
			out<=in;
	end
endmodule
