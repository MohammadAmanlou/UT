module pwm(input[7:0] in ,  input clk , output reg out);
	reg[7:0] cnt;

	always@(in)begin
		cnt = 8'b00000000;
	end
	
	always@(posedge clk)begin
		if(cnt <= in)begin cnt = cnt + 1; out=1; end
		else begin cnt = cnt + 1; out=0; end
	end
endmodule
