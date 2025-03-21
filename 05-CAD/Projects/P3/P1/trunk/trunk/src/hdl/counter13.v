module counter13(input clk, rst, en, output cout, output reg [3:0] count);
	always @(posedge clk or posedge rst)
	begin
		if(rst)
			count <= 4'b0000;
		else if(en) 
			count <= (count == 4'b1101)? 4'b0000 : count+1;
	end
	assign cout = (count == 4'b1101) ? 1'b1 : 1'b0;
endmodule 