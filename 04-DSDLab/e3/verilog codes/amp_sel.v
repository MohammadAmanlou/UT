module amp_sel(input[1:0] sel ,  input[7:0] in ,output [7:0] out);
	assign out=(sel==2'b00)?in:
		(sel==2'b01)?{in[7],in[7:1]}:
		(sel==2'b10)?{in[7],in[7],in[7:2]}:
		(sel==2'b11)?{in[7],in[7],in[7],in[7:3]}:in;
endmodule
