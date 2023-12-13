module Mux4to1(input [1:0] select,input[31:0] a,b,c,d,output[31:0] out);
	assign out= (select==2'b00) ? a:
		    (select==2'b01) ? b:
		    (select==2'b10) ? c:
		    (select==2'b11) ? d:
			{32{1'b0}};
endmodule
