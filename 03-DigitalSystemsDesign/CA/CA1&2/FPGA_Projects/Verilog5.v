`timescale 1ns/1ns
module myInv (input a , output b);
	supply1 Vdd;
	Q1Nand N1(a , Vdd , b);
endmodule

module myXor (input a , b , output w);
	wire b1 , a1 , w1 , w2;
	myInv I1(b , b1) , I2(a,a1);
	Q1Nand NN1(a , b1 , w1) , NN2(a1,b,w2) , NN3(w1,w2,w);
endmodule

module myComXor (input a , b , output w);
	wire y1;
	myXor X(a , b,y1);
	myInv I(y1 , w);
endmodule

module myCompretor ( input a1 , a2, a3,a4,b1,b2,b3,b4 ,output w);
	wire x1,x2,x3,x4 , y1 , y2 , w1;
	myComXor X1(a1 , b1,x1) , X2(a2,b2,x2) , X3(a3,b3,x3) , X4(a4,b4,x4);
	Q3Nand NQ31(.a(x1) , .b(x2) , .c(x3) , .w(y1));
	myInv IN(.a(y1) , .b(y2));
	Q1Nand N1(.a(y2) , .b(x4) , .w(w1));
	myInv IN2(.a(w1) , .b(w));
endmodule
	
