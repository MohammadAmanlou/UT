module mux3to1(sel,a,b,c,out);
	input [1:0] sel;
	input [6:0] a,b,c;
	output [6:0] out;
	assign out= (sel==2'b00) ? a:
		    (sel==2'b01) ? b:
		    (sel==2'b10) ? c:
			7'b0 ;
endmodule