`timescale 1ns/1ns
module CLA_4bit (input [3:0] A , B ,input cin , output [3:0] S , output Co);
	wire [3:0] p ,g ;
	wire [4:0] c;
	assign c[0] = cin;
	assign Co = c[4] ;
	genvar i;
	generate
		for (i =0 ; i < 4 ; i = i+1) begin: lookaheads
			assign #7 g[i] = A[i] & B[i];
			assign #7 p[i] = A[i]|B[i] ;
			assign #14 c[i+1] = g[i]| (p[i]&c[i]);
			assign #7.1 S[i]=A[i]^c[i]^B[i];
		end
	endgenerate
endmodule


module CRA_8bit (input [7:0] A , B ,input cin , output [7:0] S , output Co);
	wire cout;
	CLA_4bit a1 (A[3:0] , B[3:0],cin , S[3:0] , cout);
	CLA_4bit a2 (A[7:4] , B[7:4],cout , S[7:4] , Co);
endmodule