module Register(clk,en,clr,in,out);
	input clk,en,clr;
	input[31:0] in;
	output reg[31:0] out={32{1'b0}};
	always@(posedge clk)begin
		if(clr)
		    	out<={32{1'b0}};
		else if(en)
			out<=in;
	end
endmodule
