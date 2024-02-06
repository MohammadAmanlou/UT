module mac(a, b, en, rst, clk, out);
	input[7:0] a, b;
	input en, rst, clk;
	output[7:0] out;
	
	wire [15:0] mult = a * b;
	reg [12:0] sumOfMult;
	always@(posedge clk)
	begin
		if(rst)
			sumOfMult <= 12'b0;
		else if(en)
		begin
			sumOfMult <= sumOfMult + mult[15:8];
		end
	end
	assign out = sumOfMult[11:4];
endmodule
