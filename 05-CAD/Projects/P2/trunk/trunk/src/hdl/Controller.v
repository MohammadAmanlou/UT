`define 	Begin	3'b000
`define 	Init	3'b001
`define 	Mult	3'b010
`define 	Add	3'b011
`define 	Decode	3'b100
`define 	Done	3'b101


module Controller(input clk,done,start , rst,output wire en1 , en2 , en3 , sel );
	wire A,B,C;
	wire Ab , Bb , Cb , doneb;
	Not nota(.a(A) , .out(Ab));
	Not notb(.a(B) , .out(Bb));
	Not notc(.a(C) , .out(Cb));
	Not notdone(.a(done) , .out(doneb));
	And and1(.a(Ab) , .b(C) , .out(en1));
	wire en2t;
	And and2(.a(Ab) , .b(B) , .out(en2t));
	And and3(.a(en2t) , .b(Cb) , .out(en2));
	wire en3t;
	And and4(.a(Ab) , .b(Bb) , .out(en3t));
	And and5(.a(en3t) , .b(Cb) , .out(en3));
	And and6(.a(en3t) , .b(C) , .out(sel));
	wire D0 , D1 , D2;
	wire D0_1 , D0_2_1 , D0_2_2 , D0_2;
	And and7(.a(en2t) , .b(Cb) , .out(D0_1));
	And and8(.a(A) , .b(Bb) , .out(D0_2_1));
	And and9(.a(Cb)  , .b(done) , .out(D0_2_2));
	And and10(.a(D0_2_1) , .b(D0_2_2) , .out(D0_2));
	Or or1(.a(D0_2) , .b(D0_1) , .out(D0));
	register1 A_reg(.clk(clk), .rst(rst), .en(clk) , .in(D0),.out(A));

	wire D1_2_2 , D1_2;
	And and11(.a(D0_2_1) , .b(D1_2_2) , .out(D1_2));
	And and12(.a(doneb)  , .b(Cb) , .out(D1_2_2));
	Or or2(.a(D1_2) , .b(en1)  , .out(D1));
	register1 B_reg(.clk(clk), .rst(rst), .en(clk) , .in(D1),.out(B));

	wire D2_1_1 , D2_1 , D2_2;
	And and13(.a(Bb) , .b(Cb) , .out(D2_1_1));
	And and14(.a(D2_1_1) , .b(start) , .out(D2_1));
	And and15(.a(D0_2_1) , .b(Cb) , .out(D2_2));
	Or or3(.a(D2_1) , .b(D2_2) , .out(D2));
	register1 C_reg(.clk(clk), .rst(rst), .en(clk) , .in(D2),.out(C));
	
endmodule





