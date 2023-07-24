`timescale 1ns/1ns
module Q4Nand(input a , b , c,output w);
	nand #(15 , 12)(w,a,b,c);
endmodule
