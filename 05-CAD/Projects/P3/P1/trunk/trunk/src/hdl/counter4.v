module counter4(input clk, rst, en, output cout, output reg [1:0] count);
	always @(posedge clk or posedge rst) begin
		if(rst)
			count <= 2'b00;
		else if(en)
			count <= count+1;
	end
	assign cout = (count == 2'b11) ? 1'b1 : 1'b0;
endmodule 
