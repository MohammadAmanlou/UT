module  controller #(parameter N) (clk, start, cout3, cout5, cout6, cout7, cout8, cout9, cout11, en1, en2, en3, en4, en5, en6, en7, en8,
		 en9, en10, en11, en12, rst3,rst5, rst6, rst7, rst8, rst9, rst11, rst12, sel, shift, wr, done);

	parameter[4:0] Q0=5'b00000, Q1=5'b00001, Q2=5'b00010, Q3=5'b00011, Q4=5'b00100, Q5=5'b00101, Q6=5'b00110,Q7=5'b00111, Q8=5'b01000,
	 Q9=5'b01001, Q10=5'b01010, Q11=5'b01011, Q12=5'b01100, Q13=5'b01101, Q14=5'b01110, Q15=5'b01111, Q16=5'b10000, Q17=5'b10001,
	 Q18=5'b10010, Q19=5'b10011, Q20=5'b10100, Q21=5'b10101, Q22=5'b10110, Q23=5'b10111;

	input clk, start, cout3, cout5, cout6, cout7, cout8, cout9, cout11;

	output reg en3,en5, en6, en7, en8, en9, en10, en11, en12, rst3, rst5, rst6, rst7, rst8, rst9, rst11, rst12, shift, wr, done;
	output reg sel;
	output reg[15:0] en2,en4;

	output reg [15:0] en1 [0:N-1];  //////////////////


	reg[4:0] ps=5'b0, ns;

//////////////////////////////// changes
	wire[31:0] kernel;
	reg enK,rstK;
	wire coutK;

	kernelCounter #N myCounter(.clk(clk),.rst(rstK),.en(enK),.count(kernel),.cout(coutK));
////////////////////////////////
	integer i;
	always@(ps,start,cout3, cout5, cout7, cout8, cout11) begin
		for(i = 0; i < N; i = i + 1) begin
           		en1[i] = 16'b0;
        	end
		{en2, en3, en4, en5, en6, en7, en8, en9, en10, en11, en12, rst3, rst5, rst6, rst7, rst8, rst9, rst11, rst12, sel, shift, wr, done,enK,rstK}=57'b0;////////////////////
		case(ps)
			Q0 : {rst3, rst5, rst6, rst7, rst8, rst9, rst11, rst12,rstK} = 9'b111111111;/////////////////////
			Q1 : {en1[kernel][15:12], sel, en9} = 6'b1111_1_1;/////////////////////
			Q2 : {en1[kernel][11:8], sel, en9} = 6'b1111_1_1;///////////
			Q3 : {en1[kernel][7:4], sel, en9} = 6'b1111_1_1;///////////////
			Q4 : {en1[kernel][3:0], sel, en9,enK} = 7'b1111_1_1_1;///////////////
			Q5 : {en2[15:12], sel, en6} = 6'b1111_0_1;
			Q6 : {en2[11:8], sel, en6} = 6'b1111_0_1;
			Q7 : {en2[7:4], sel, en6} = 6'b1111_0_1;
			Q8 : {en2[3:0], sel, en6, en11} = 7'b1111_0_1_1;
			Q9 : shift = 1'b1;
			Q10 : {en3, en4} = 17'b1_1111_1111_1111_1111;
			Q11 : {en5, en12} = 2'b11;
			Q12 : {en8, en10, rst5, rst12} = 4'b1111;
			Q13 : {wr, en7, sel, rst8} = 5'b11_10_1;
			Q14 : {shift, rst3} = 2'b11;
			Q15 : {en2[15:12], sel, en6} = 6'b1111_0_1;
			Q16 : {en2[11:8], sel, en6} = 6'b1111_0_1;
			Q17 : {en2[7:4], sel, en6} = 6'b1111_0_1;
			Q18 : {en2[3:0], sel, en6} = 6'b1111_0_1;
			Q19 : en10 = 1'b1;
			Q20 : en10 = 1'b1;
			Q21 : en10 = 1'b1;
			Q22 : {wr, sel} = 3'b110;
			Q23 : done = 1'b1;
		endcase
	end

	always@(ps,start,cout3, cout5, cout7, cout8, cout11)
	begin
		case(ps)
			Q0 : ns= start ? Q1 : Q0 ;
			Q1 : ns= Q2;
			Q2 : ns= Q3;
			Q3 : ns= Q4;
			Q4 : ns= coutK ? Q5 : Q1 ;
			Q5 : ns= Q6;
			Q6 : ns= Q7;
			Q7 : ns= Q8;
			Q8 : ns= cout11 ? Q10 : Q9 ;
			Q9 : ns= Q5;
			Q10 : ns= Q11;
			Q11 : ns= cout5 ? Q12 : Q11 ;
			Q12 : ns= (cout3==0 & cout8==0) ? Q10 :
				(cout3==1 & cout8==0) ? Q14 : Q13;
			Q13 : ns= cout3 ? Q14 : Q10;
			Q14 : ns= cout7 ? Q19 : Q15;
			Q15 : ns= Q16;
			Q16 : ns= Q17;
			Q17 : ns= Q18;
			Q18 : ns= Q10;
			Q19 : ns= Q20;
			Q20 : ns= Q21;
			Q21 : ns= Q22;
			Q22 : ns= Q23;
			Q23 : ns= Q0;
		endcase
	end

	always@(posedge clk)
	begin
		ps<=ns;
	end

endmodule