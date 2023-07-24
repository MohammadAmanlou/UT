`timescale 1ns/1ns
module NandQ1TB();
	reg aa=0 , bb=1;
	wire ww;
	Q1Nand Q1NandTB(aa , bb ,ww);
	initial begin 
		#15 bb=0 ;
		#15 bb=1;
		#15 bb=0;
		#15 bb=1;
		repeat(4) #17  aa=~aa ;
		#20 $stop ;
	end
endmodule
