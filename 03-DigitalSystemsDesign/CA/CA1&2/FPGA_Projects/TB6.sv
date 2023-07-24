`timescale 1ns/1ns
module ComparatorTB();
	reg a1=1 , a2=1 , a3=1 , a4=1 , b1=1 , b2=1 , b3=1 , b4=1 ;
	wire ww ;
	myCompretor MC( a1,a2,a3,a4,b1,b2,b3,b4,ww);
	initial begin 
		repeat (4) a1=~a1;
		repeat (4) a4=~a4;
		#100 b1=0 ;
		#100 a1=0;
		#100 b1=1;
		#100 a1=1 ;
		#100 $stop ;
	end
endmodule