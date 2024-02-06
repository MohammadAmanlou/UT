`define q0 6'b000000
`define q1 6'b000001
`define q2 6'b000010
`define q3 6'b000011
`define q4 6'b000100
`define q5 6'b000101
`define q6 6'b000110
`define q7 6'b000111
`define q8 6'b001000
`define q9 6'b001001
`define q10 6'b001010
`define q11 6'b001011
`define q12 6'b001100
`define q13 6'b001101
`define q14 6'b001110
`define q15 6'b001111
`define q16 6'b010000
`define q17 6'b010001
`define q18 6'b010010
`define q19 6'b010011
`define q20 6'b010100
`define q21 6'b010101
`define q22 6'b010110
`define q23 6'b010111
`define q24 6'b011000
`define q25 6'b011001
`define q26 6'b011010 
`define q27 6'b011011 
`define q28 6'b011100 
`define q29 6'b011101
`define q30 6'b011110 
`define q31 6'b011111
`define q32 6'b100000
`define q33 6'b100001
`define q34 6'b100010
`define q35 6'b100011
`define q36 6'b100100
`define q37 6'b100101
`define q38 6'b100110





module  controller #(parameter N) (clk,rst20, start, cout3, cout5, cout6, cout7, cout8, buf13x13_we,
									cout9, cout11, en1, en2, en3, en4, en5, en6, en7, en8,
		 							en9,en20, en10, en11, en12, rst3,rst5, rst6, rst7, rst8, rst9, 
									rst11, rst12, sel, shift, wr,kernel_filter2_en, done , rst_adr_buf13
									,cout_adr_buf13 , count_max_cout , PE2_mac_en , count_max_en , OFM_cout,
									PE2_counter_en , PE2_sh_reg_en , PE2_mac_rst , OFM_wr , PE_counter_rst , done2 ,
									en_adr_buf13 , buf4x4_en , count_max_rst , shift_buf13x13 , OFM_adr_in);

	input clk, start, cout3, cout5, cout6, cout7, cout8, cout9, cout11 , cout_adr_buf13 , count_max_cout , OFM_cout;

	output reg en3,en20,en5, en6, en7, en8, en9,rst_adr_buf13, en10, en11,rst20,en12, rst3, rst5,shift_buf13x13, rst6, rst7, rst8, rst9, rst11, rst12, shift, wr, done , count_max_rst;
	output reg sel , buf13x13_we , PE2_mac_en , count_max_en , PE2_counter_en , PE2_sh_reg_en ,PE2_mac_rst,OFM_wr , PE_counter_rst , done2 ,  en_adr_buf13 ;
	output reg[15:0] en2,en4,buf4x4_en;
	output reg [15:0] kernel_filter2_en [0:N-1];
	output reg [15:0] en1 [0:N-1];  
	output reg [31:0] OFM_adr_in;
	reg [31:0]adr_OFM = 0 ;
	assign OFM_adr_in = adr_OFM;
	reg unsigned [31:0] check_final = 0 ;


	reg[5:0] ps=6'b0, ns;
	reg[4:0] count_max16 = 4'b0;

	wire[31:0] kernel;
	reg enK,rstK;
	wire coutK;


	counter #( .N(N), .M(32)) myCounter(.clk(clk),.rst(rstK),.en(enK),.cout(coutK),.count(kernel));


	integer i;
	always@(ps ) begin
		for(i = 0; i < N; i = i + 1) begin
           		en1[i] = 16'b0;
        	end
		{en2, en3, en4, en5, en6, en7, en8, en9, en10, en11, en12, rst3, rst5, rst6,rst_adr_buf13,
		 rst7, rst8, rst9, rst11, rst12, sel, shift, wr, done,enK,rstK , rst20 ,PE2_sh_reg_en,OFM_wr,en20,
		  kernel_filter2_en[0] , kernel_filter2_en[1], kernel_filter2_en[2], kernel_filter2_en[3],PE2_counter_en,shift_buf13x13,
		  buf4x4_en , en_adr_buf13 ,PE2_mac_en , count_max_en , PE_counter_rst, rst_adr_buf13 , done2, count_max_rst , PE2_mac_rst , buf13x13_we}=153'b0;
		case(ps)
			`q0 : {rst3, rst5, rst6, rst7, rst8, rst9, rst11, rst12,rstK , rst20 , PE_counter_rst , rst_adr_buf13 , count_max_rst , PE2_mac_rst} = 14'b11111111111111;
			`q1 : {en1[kernel][15:12], sel, en9} = 6'b1111_1_1;
			`q2 : {en1[kernel][11:8], sel, en9} = 6'b1111_1_1;
			`q3 : {en1[kernel][7:4], sel, en9} = 6'b1111_1_1;
			`q4 : {en1[kernel][3:0], sel, en9,enK} = 7'b1111_1_1_1; //27
			`q5 : {en2[15:12], sel, en6} = 6'b1111_0_1;
			`q6 : {en2[11:8], sel, en6} = 6'b1111_0_1;
			`q7 : {en2[7:4], sel, en6} = 6'b1111_0_1;
			`q8 : {en2[3:0], sel, en6, en11} = 7'b1111_0_1_1;
			`q9 : shift = 1'b1;
			`q10 : {en3, en4} = 17'b1_1111_1111_1111_1111; //28
			`q11 : {en5, en12} = 2'b11; //29
			`q12 : {en8, en10, rst5, rst12} = 4'b1111; // 30
			`q13 : {wr, en7, sel, rst8} = 5'b11_10_1; //31
			`q14 : {shift, rst3} = 2'b11; //32
			`q15 : {en2[15:12], sel, en6} = 6'b1111_0_1;
			`q16 : {en2[11:8], sel, en6} = 6'b1111_0_1;
			`q17 : {en2[7:4], sel, en6} = 6'b1111_0_1;
			`q18 : {en2[3:0], sel, en6} = 6'b1111_0_1;
			`q19 : en10 = 1'b1; // 33
			`q20 : en10 = 1'b1; // 34
			`q21 : en10 = 1'b1; //35
			`q22 : {wr, sel} = 3'b110; //36
			`q23 : begin done = 1'b1; en20 = 1'b1; end // 37
			`q24 : {kernel_filter2_en[0][15:12] ,kernel_filter2_en[1][15:12],kernel_filter2_en[2][15:12],kernel_filter2_en[3][15:12] , en20} = 17'b1111_1111_1111_1111_1_;
			`q25 : {kernel_filter2_en[0][11:8] ,kernel_filter2_en[1][11:8],kernel_filter2_en[2][11:8],kernel_filter2_en[3][11:8] , en20} = 17'b1111_1111_1111_1111_1_;
			`q26 : {kernel_filter2_en[0][7:4] ,kernel_filter2_en[1][7:4],kernel_filter2_en[2][7:4],kernel_filter2_en[3][7:4] , en20} = 17'b1111_1111_1111_1111_1_;
			`q27 : {kernel_filter2_en[0][3:0] ,kernel_filter2_en[1][3:0],kernel_filter2_en[2][3:0],kernel_filter2_en[3][3:0] , en20 , buf13x13_we } = 18'b1111_1111_1111_1111_1_1;
			`q28 : {buf4x4_en,en_adr_buf13 , rst20} = 18'b111111111111111111;
			`q29 : begin {PE2_mac_en , count_max_en} = 2'b11 ; count_max16 = count_max16 + 1; end
			`q30 : {PE2_counter_en, PE2_sh_reg_en, count_max_rst, PE2_mac_rst } = 4'b1111;
			`q31 : begin {OFM_wr , en20 , PE_counter_rst} = 3'b111; adr_OFM = adr_OFM + 1 ; check_final = check_final + 1;end
			`q32 : {shift_buf13x13 , rst_adr_buf13 } = 2'b11;
			`q33 : PE2_sh_reg_en = 1'b1;
			`q34 : PE2_sh_reg_en = 1'b1;
			`q35 : PE2_sh_reg_en = 1'b1;
			`q36 : OFM_wr = 1'b1;
			`q37 : done2 = 1'b1 ;
		
		
		endcase
	end

	always@(ps,start,cout3, cout5, cout7, cout8, cout11)
	begin
		case(ps)
			`q0 : ns= start ? `q1 : `q0 ;
			`q1 : ns= `q2;
			`q2 : ns= `q3;
			`q3 : ns= `q4;
			`q4 : ns= coutK ? `q5 : `q1 ;
			`q5 : ns= `q6;
			`q6 : ns= `q7;
			`q7 : ns= `q8;
			`q8 : ns= cout11 ? `q10 : `q9 ;
			`q9 : ns= `q5;
			`q10 : ns= `q11; //28
			`q11 : ns= cout5 ? `q12 : `q11 ; //29
			`q12 : ns= (cout3==0 & cout8==0) ? `q10 :
				(cout3==1 & cout8==0) ? `q14 : `q13; //30
			`q13 : ns= cout3 ? `q14 : `q10; //31
			`q14 : ns= cout7 ? `q19 : `q15; // 32
			`q15 : ns= `q16;
			`q16 : ns= `q17;
			`q17 : ns= `q18;
			`q18 : ns= `q10;
			`q19 : ns= `q20; //33
			`q20 : ns= `q21; // 34
			`q21 : ns= `q22; //35
			`q22 : ns= `q23; //36
			`q23 : ns= `q24; //37
		endcase
	end

	always@(ps,count_max_cout,cout_adr_buf13,OFM_cout)
	begin
		case(ps)
			`q24 : ns= `q25;
			`q25 : ns= `q26;
			`q26 : ns= `q27;
			`q27 : ns= `q38;
			`q38 : ns= `q28;
			`q28 : ns= `q29;
			`q29 : ns=  count_max_cout ? `q30 : `q29 ;
			`q30 : ns= (cout_adr_buf13==0 & OFM_cout==0) ? `q28 : (cout_adr_buf13==1 & OFM_cout==0) ? `q32 : `q31;
			`q31 : ns= cout_adr_buf13 ? `q32 : `q28 ;
			`q32 : ns= (check_final == 32'd25 )? `q33 : `q28; //////////////////
			`q33 : ns= `q34; 
			`q34 : ns= `q35; 
			`q35 : ns= `q36; 
			`q36 : ns= `q37; 
			`q37 : ns= `q0;
		endcase
	end

	always@(posedge clk)
	begin
		ps<=ns;
	end

endmodule
