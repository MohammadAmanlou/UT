module shiftRegister(clk,en,in,out , rst);
	input clk,en , rst;
	input[7:0] in;
	output reg[31:0] out;
	reg [7:0] register[3:0];
	integer i , j;
	always@(posedge clk)
	begin
		if(rst) 
		begin
			for(j=0;j<4;j=j+1)
			begin
				register[j] = 0;
			end
		end
		else if(en)
		begin
			for(i=0;i<3;i=i+1)
			begin
				register[i]=register[i+1];
			end
			register[3]=in;
		end
	end
	assign out = {register[0] , register[1] , register[2] , register[3]};
endmodule


////everything is OK!

