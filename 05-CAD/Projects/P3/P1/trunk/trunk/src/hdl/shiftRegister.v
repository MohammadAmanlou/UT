module shiftRegister(clk,en,dataIn,dataOut);
	input clk,en;
	input[7:0] dataIn;
	output reg[7:0] dataOut[3:0];
	integer i;
	always@(posedge clk)
	begin
		if(en)
		begin
			for(i=0;i<3;i=i+1)
			begin
				dataOut[i]=dataOut[i+1];
			end
			dataOut[3]=dataIn;
		end
	end
endmodule
