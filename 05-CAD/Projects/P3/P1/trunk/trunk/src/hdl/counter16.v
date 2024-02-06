module counter16(input clk, rst, en, output cout, output reg [3:0] count);
	always @(posedge clk or posedge rst) 
	begin
		if(rst)
			count <= 4'b0000;
		else if(en)
			count <= count+1;
	end
	assign cout = (count == 4'b1111) ? 1'b1 : 1'b0;
endmodule 