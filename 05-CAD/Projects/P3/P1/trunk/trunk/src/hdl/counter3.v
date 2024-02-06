module counter3(input clk, rst, en, output cout, output reg [1:0] count);
	always @(posedge clk or posedge rst) 
	begin
		if(rst)
			count <= 2'b00;
		else if(en)
			count <= (count==2'b10) ? 2'b0 : count+1;
	end
	assign cout = (count == 2'b10) ? 1'b1 : 1'b0;
endmodule 