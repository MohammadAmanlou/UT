module counter64(input clk, rst, en, output cout, output reg [31:0] count);
	always @(posedge clk or posedge rst)
	begin
		if(rst)
			count <= 32'b0;
		else if(en)
			count <= count+1;
	end
	assign cout = (count == 63) ? 1'b1 : 1'b0;
endmodule
