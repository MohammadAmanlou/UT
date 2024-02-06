module CNN #(parameter N) (clk,start,X,Y,Z,M,doneOut);
	input clk,start;
	input [6:0] X,Y,Z,M;	
	wire done , done2;
	output doneOut;
	assign doneOut = done2;

	wire rst3,rst5,rst6,rst7,rst8,rst9,en20,rst20,rst11,rst12, en3,en5,en6,en7,en8,en9,en10,en11,en12, cout3,cout5,cout6,cout7,cout8,cout9,cout11, wr, shift;
	wire sel , buf13x13_we , rst_adr_buf13 , cout_adr_buf13 , count_max_cout , PE2_mac_en , count_max_en , OFM_cout;
	wire PE2_counter_en,count_max_rst, PE2_mac_rst , PE_counter_rst , OFM_wr ;
	wire [15:0] en2,en4,buf4x4_en;
	wire [31:0] OFM_adr_in;
	wire [15:0] en1 [0:N-1]; 
	wire [15:0] kernel_filter2_en [0:N-1];

	controller #N myController(.clk(clk),.start(start),.cout3(cout3), .cout5(cout5),.en20(en20),.kernel_filter2_en(kernel_filter2_en) ,.cout6(cout6), .cout7(cout7), .cout8(cout8), .cout9(cout9),
	.cout11(cout11), .en1(en1), .en2(en2), .en3(en3), .en4(en4), .en5(en5), .en6(en6),.en7(en7),.en8(en8),.en9(en9), .en10(en10),
	.en11(en11), .en12(en12), .rst3(rst3),.rst5(rst5), .rst6(rst6), .rst20(rst20),.rst7(rst7), .rst8(rst8), .rst9(rst9), .rst11(rst11), .rst12(rst12),
	.sel(sel), .shift(shift), .wr(wr), .done(done) , .buf13x13_we(buf13x13_we) , .rst_adr_buf13(rst_adr_buf13)
	, .cout_adr_buf13(cout_adr_buf13) , .count_max_cout(count_max_cout) , .PE2_mac_en(PE2_mac_en) , 
	.count_max_en(count_max_en) , .OFM_cout(OFM_cout) , .PE2_counter_en(PE2_counter_en), .PE2_sh_reg_en(PE2_counter_en),
	.count_max_rst(count_max_rst), .PE2_mac_rst(PE2_mac_rst) , .PE_counter_rst(PE_counter_rst) , .OFM_wr(OFM_wr) , .done2(done2),
	.buf4x4_en(buf4x4_en) , .en_adr_buf13(en_adr_buf13) , .shift_buf13x13(shift_buf13x13) , .OFM_adr_in(OFM_adr_in));

	dataPath #N myDataPath(.clk(clk),.rst6(rst6),.rst7(rst7),.rst9(rst9),.en6(en6),.en7(en7),.M(M),.en20(en20),.kernel_filter2_en(kernel_filter2_en),.en9(en9),.cout6(cout6),.cout7(cout7),.cout9(cout9),
	.sel(sel),.done(done),.wr(wr),.rst11(rst11),.en11(en11),.cout11(cout11),.shift(shift),.en1(en1),.en2(en2),.en3(en3),.rst3(rst3),.cout3(cout3),
	.en4(en4),.rst5(rst5),.en5(en5),.cout5(cout5),.rst12(rst12),.rst20(rst20),.en12(en12),.en10(en10),.rst8(rst8),.en8(en8), .cout8(cout8)
	,.X(X),.Y(Y),.Z(Z) , .buf13x13_we(buf13x13_we) , .rst_adr_buf13(rst_adr_buf13) , .cout_adr_buf13(cout_adr_buf13)
	,.count_max_cout(count_max_cout) , .PE2_mac_en(PE2_mac_en) , .count_max_en(count_max_en) , .OFM_cout(OFM_cout), .PE2_counter_en(PE2_counter_en), .PE2_sh_reg_en(PE2_counter_en),
	.count_max_rst(count_max_rst), .PE2_mac_rst(PE2_mac_rst) , .PE_counter_rst(PE_counter_rst) , .OFM_wr(OFM_wr) ,.done2(done2) ,
	.buf4x4_en(buf4x4_en) , .en_adr_buf13(en_adr_buf13) , .shift_buf13x13(shift_buf13x13) , .OFM_adr_in(OFM_adr_in));
endmodule

