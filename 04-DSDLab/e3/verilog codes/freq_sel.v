module freq_sel (input ld_init , clk ,rst,input [2:0] digit, output reg low_freq_clk);
	reg[8:0] sum;
	always@(posedge clk or posedge rst  )begin 
		if(rst) begin sum = 9'b000101001; low_freq_clk = 1'b0; end
		else if(ld_init) sum={digit,sum[5:0]};
		else {low_freq_clk,sum} = sum+1;	
	end
endmodule

