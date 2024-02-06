module MAC (
  input clk,
  input reset,
  input [7:0] a,
  input [7:0] b,
  input enable,
  output [7:0] result
);
wire [15:0] mult = a * b;
	reg [11:0] temp;
	always@(posedge clk )
	begin
		if(reset)
			temp <= 12'b0;
		else if(enable)
		begin
			temp <= temp + mult[15:8];
		end
	end
	assign result = temp[11:4];
endmodule

