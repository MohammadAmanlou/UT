module mux2to1(sel,a,b,out);
	input sel;
	input [31:0] a,b;
	output [31:0] out;
	assign out= (sel==1'b0) ? a:
		    (sel==1'b1) ? b:
			31'b0 ;
endmodule