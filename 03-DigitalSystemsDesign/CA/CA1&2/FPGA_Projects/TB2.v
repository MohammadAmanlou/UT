`timescale 1ns/1ns
module NandQ2TB();
	reg aa , bb=1;
	wire ww , ww2;
	Q1Nand Q1NandTB(aa , bb ,ww);
	Q2Nand Q2NandTB(aa,bb,ww2);
	initial begin 
		#10 aa =0 ;
		#15 aa=1;
		#20 bb=0;
		repeat(4) #17  aa=~aa;
		#20 $stop ;
	end
endmodule
