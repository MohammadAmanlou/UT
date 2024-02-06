module buffer4x4(clk,dataIn,en,dataOut);
	input clk;
	input [7:0] dataIn [0:15];
	input [15:0] en;
	output reg [7:0] dataOut [0:15];
	integer i;
	always @(posedge clk)
	begin
		for (i = 0; i < 16; i = i + 1)
		begin
			dataOut[i] = (en[i]) ? dataIn[i] : dataOut[i];
      		end
  	end
endmodule