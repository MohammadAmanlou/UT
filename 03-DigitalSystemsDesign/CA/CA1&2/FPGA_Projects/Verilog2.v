`timescale 1ns/1ns
module Q2Nand(input a , b ,output w);
	nand #(10,7)(w,a,b);
endmodule
