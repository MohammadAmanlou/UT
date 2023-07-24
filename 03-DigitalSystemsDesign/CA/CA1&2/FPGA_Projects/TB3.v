`timescale 1ns/1ns
module NandQ3TB();
	reg aa=1 , bb=1 , cc=1;
	wire ww;
	Q3Nand Q1NandTB(aa , bb , cc ,ww);
	initial begin 
		#20 aa =0 ;
		#20 aa=1;
		#20 aa = 0;
		#20 bb=0;
		#20 bb=1;
		#20 bb=0;
		repeat(4) #17  cc=~cc;
		#20 bb=1 ;
		repeat(4) #17  cc=~cc;
		#20 aa=1;
		repeat(4) #17  cc=~cc;
		#20 $stop ;
	end
endmodule
