module buffer4x16(clk,shift,en,dataIn,readIdx,dataOut);
	input [7:0] dataIn[0:3];
	input clk, shift;
	input [15:0] en;
	input [3:0] readIdx;
	reg [7:0] buffer [0:3][0:15];
	output reg [7:0] dataOut[0:15];
	integer i,j;
	always@(posedge clk)begin
		 for (i = 0; i < 4; i = i + 1) begin
    			dataOut[i*4] 	 <= buffer[i][readIdx];
    			dataOut[i*4 + 1] <= buffer[i][readIdx + 1];
   			dataOut[i*4 + 2] <= buffer[i][readIdx + 2];
    			dataOut[i*4 + 3] <= buffer[i][readIdx + 3];
  		end
	end
	always@(posedge clk)begin
		if(shift)
		begin
			for (i = 0; i < 3; i = i + 1) 
			begin
        			for (j = 0; j < 16; j = j + 1)
				begin
          				buffer[i][j] <= buffer[i+1][j];
        			end
      			end
		end
		else begin
			for(i=0;i<16;i=i+1)begin
				if(en[15-i])
				begin
					buffer[3][i] = dataIn[0];
					buffer[3][i+1] = dataIn[1];
					buffer[3][i+2] = dataIn[2];
					buffer[3][i+3] = dataIn[3];
					i = 16;
				end
			end
		end
	end
	
endmodule