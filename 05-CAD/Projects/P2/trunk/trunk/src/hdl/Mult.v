module mult (input [4:0] D1 , D2 , output [9:0] out);
	wire w10 , w20 , w30 , w40;
	And and00(.a(D1[0]) , .b(D2[0]) , .out(out[0]));
	And and10(.a(D1[1]) , .b(D2[0]) , .out(w10) );
	And and20(.a(D1[2]) , .b(D2[0]) , .out(w20) );
	And and30(.a(D1[3]) , .b(D2[0]) , .out(w30) );
	NAnd nand40(.a(D1[4]) , .b(D2[0]) , .out(w40) );

	wire w01 , w11 , w21 , w31 , w41 ;
	And and01(.a(D1[0]) , .b(D2[1]) , .out(w01));
	And and11(.a(D1[1]) , .b(D2[1]) , .out(w11));
	And and21(.a(D1[2]) , .b(D2[1]) , .out(w21));
	And and31(.a(D1[3]) , .b(D2[1]) , .out(w31));
	NAnd and41(.a(D1[4]) , .b(D2[1]) , .out(w41));

	wire c10 , c11 , c12 , c13 , c14 , s11 , s12 , s13 , s14;
	FA fa01(.A(w01),.B(w10) , .Cin(1'b0) , .Sum(out[1]) , .Cout(c10));
	FA fa11(.A(w11),.B(w20) , .Cin(c10) , .Sum(s11) , .Cout(c11));
	FA fa21(.A(w21),.B(w30) , .Cin(c11) , .Sum(s12) , .Cout(c12));
	FA fa31(.A(w31),.B(w40) , .Cin(c12) , .Sum(s13) , .Cout(c13));
	FA fa41(.A(w41),.B(1'b1) , .Cin(c13) , .Sum(s14) , .Cout(c14));


	wire w02 , w12 , w22 , w32 , w42 ;
	And and02(.a(D1[0]) , .b(D2[2]) , .out(w02));
	And and12(.a(D1[1]) , .b(D2[2]) , .out(w12) );
	And and22(.a(D1[2]) , .b(D2[2]) , .out(w22) );
	And and32(.a(D1[3]) , .b(D2[2]) , .out(w32) );
	NAnd nand42(.a(D1[4]) , .b(D2[2]) , .out(w42) );

	wire c20 , c21 , c22 , c23 , c24 , s21 , s22 , s23 , s24;
	FA fa02(.A(w02),.B(s11) , .Cin(1'b0) , .Sum(out[2]) , .Cout(c20));
	FA fa12(.A(w12),.B(s12) , .Cin(c20) , .Sum(s21) , .Cout(c21));
	FA fa22(.A(w22),.B(s13) , .Cin(c21) , .Sum(s22) , .Cout(c22));
	FA fa32(.A(w32),.B(s14) , .Cin(c22) , .Sum(s23) , .Cout(c23));
	FA fa42(.A(w42),.B(c14) , .Cin(c23) , .Sum(s24) , .Cout(c24));


	wire w03 , w13 , w23 , w33 , w43 ;
	And and03(.a(D1[0]) , .b(D2[3]) , .out(w03));
	And and13(.a(D1[1]) , .b(D2[3]) , .out(w13) );
	And and23(.a(D1[2]) , .b(D2[3]) , .out(w23) );
	And and33(.a(D1[3]) , .b(D2[3]) , .out(w33) );
	NAnd nand43(.a(D1[4]) , .b(D2[3]) , .out(w43) );

	wire c30 , c31 , c32 , c33 , c34 , s31 , s32 , s33 , s34;
	FA fa03(.A(w03),.B(s21) , .Cin(1'b0) , .Sum(out[3]) , .Cout(c30));
	FA fa13(.A(w13),.B(s22) , .Cin(c30) , .Sum(s31) , .Cout(c31));
	FA fa23(.A(w23),.B(s23) , .Cin(c31) , .Sum(s32) , .Cout(c32));
	FA fa33(.A(w33),.B(s24) , .Cin(c32) , .Sum(s33) , .Cout(c33));
	FA fa43(.A(w43),.B(c24) , .Cin(c33) , .Sum(s34) , .Cout(c34));


	wire w04 , w14 , w24 , w34 , w44 ;
	NAnd and04(.a(D1[0]) , .b(D2[4]) , .out(w04));
	NAnd and14(.a(D1[1]) , .b(D2[4]) , .out(w14) );
	NAnd and24(.a(D1[2]) , .b(D2[4]) , .out(w24) );
	NAnd and34(.a(D1[3]) , .b(D2[4]) , .out(w34) );
	And nand44(.a(D1[4]) , .b(D2[4]) , .out(w44) );

	wire c40 , c41 , c42 , c43 , c44 , s41 , s42 , s43 , s44;
	FA fa04(.A(w04),.B(s31) , .Cin(1'b0) , .Sum(out[4]) , .Cout(c40));
	FA fa14(.A(w14),.B(s32) , .Cin(c40) , .Sum(out[5]) , .Cout(c41));
	FA fa24(.A(w24),.B(s33) , .Cin(c41) , .Sum(out[6]) , .Cout(c42));
	FA fa34(.A(w34),.B(s34) , .Cin(c42) , .Sum(out[7]) , .Cout(c43));
	FA fa44(.A(w44),.B(c34) , .Cin(c43) , .Sum(out[8]) , .Cout(c44));
	FA fa54(.A(c44),.B(1'b1) , .Cin(1'd0) , .Sum(out[9]) , .Cout());

endmodule









	

