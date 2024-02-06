module dataPath #(parameter N) (clk,M,X,Y,Z,
	en20, en2,en1,en4,en3,en6,en7,en9,en11,en5,en12,en10,en8
	,wr, shift,buf13x13_we ,kernel_filter2_en ,
	shift_buf13x13,en_adr_buf13,buf4x4_en,PE2_mac_en,PE2_sh_reg_en,PE2_counter_en,OFM_wr,count_max_en,
	sel,done,done2, OFM_adr_in,
	rst3,rst6,rst7,rst9,rst11,rst5,rst12,rst8,rst20,rst_adr_buf13,PE2_mac_rst,PE_counter_rst,count_max_rst
	,cout3,cout6,cout7,cout9,cout11 , cout20,cout5,cout8 , cout_adr_buf13 , OFM_cout , count_max_cout
	);
	input clk, wr, shift, rst3,rst6,rst7,rst9,rst11,rst5,rst12,rst8,count_max_rst,PE_counter_rst ,PE2_counter_en;
	input rst20,en20, en3,en6,en7,en9,en11,en5,en12,en10,en8, PE2_mac_en , PE2_mac_rst ,PE2_sh_reg_en;
	input sel, done,done2, buf13x13_we , rst_adr_buf13 , en_adr_buf13 ,OFM_wr , count_max_en;
	input [6:0] X,Y,Z,M;
	input shift_buf13x13;
	input [31:0] OFM_adr_in;
	wire [31:0] addY,addX,addZ , addM;
	input [15:0] en2,en4,buf4x4_en;
	input [15:0] en1 [0:N-1];
	input [15:0] kernel_filter2_en [0:N-1];    
	wire [7:0] buffer16Out [0:15];
	wire [7:0] buffer13Out1 [0:15];
	wire [7:0] buffer13Out2 [0:15];
	wire [7:0] buffer13Out3 [0:15];
	wire [7:0] buffer13Out4 [0:15];
	wire [7:0] buffer4_2Out [0:15]  ;
	wire [7:0] buffer4x4Out_2_1 [0:15]  ;
	wire [7:0] buffer4x4Out_2_2 [0:15]  ;
	wire [7:0] buffer4x4Out_2_3 [0:15]  ;
	wire [7:0] buffer4x4Out_2_4 [0:15]  ;
   	wire [31:0] sumX,sumY,sumZ, sumM;
	wire [3:0] counterOut , counterOut2;
	wire [7:0] mac2Input;
	wire [7:0] mac22Input1 , mac22Input2, mac22Input3, mac22Input4;
	output cout3,cout6,cout7,cout9,cout11,cout5,cout8,cout20 , cout_adr_buf13 , OFM_cout , count_max_cout;
	wire [3:0] index , index_buf13x13;
	wire [31:0] muxOut;
	wire [31:0] memOut;

	mux_nx1 #(.Sel(1) , .IN(32) )mux1(.sel(sel) , .in1(sumX)  , .in2(sumY)  , .in3()  , .out(muxOut));
	memory		myMem(.clk(clk),.adr(muxOut),.in(),.we(),.out(memOut));
	counter #(.N(4), .M(2)) myCounter1(.clk(clk),.rst(rst11),.en(en11),.cout(cout11),.count());

	counter #(.N(64), .M(32)) xCounter(.clk(clk),.rst(rst6),.en(en6),.cout(cout6),.count(addX));
	counter #(.N(43), .M(32)) zCounter(.clk(clk),.rst(rst7),.en(en7),.cout(cout7),.count(addZ));
	counter #(.N(4*N), .M(32)) yCounter(.clk(clk),.rst(rst9),.en(en9),.cout(cout9),.count(addY));

	counter #(.N(16), .M(4)) myCounter3(.clk(clk),.rst(rst5),.en(en5),.cout(cout5),.count(counterOut));

	mux16to1	mux2(.sel(counterOut),.in(buffer4_2Out),.out(mac2Input));

	buffer4x16	bigBuff(.clk(clk),.shift(shift),.en(en2),.in(memOut),.adr(index),.out(buffer16Out));
	counter #(.N(14), .M(4)) myCounter2(.clk(clk),.rst(rst3),.en(en3),.cout(cout3),.count(index));
	buffer4x4	smallBuff(.clk(clk),.in(buffer16Out),.en(en4),.out(buffer4_2Out));
	genvar i;
    generate
        for (i = 0; i < N; i = i + 1)
        begin
		PE pe(.clk(clk),.bufferInput(memOut),.kernelFilter_en(en1[i]),.mux_sel(counterOut),.mac2_input(mac2Input),
	.mac_en(en12),.mac_rst(rst12),.shiftReg_en(en10),.counter_en(en8),.counter_rst(rst8),.ofm_we(wr),
	.ofm_addr(sumZ),.ofm_cout(cout8),.done(done),.number(i));
        end
    endgenerate
	
	assign sumX=addX+X;
	assign sumY=addY+Y;
	assign sumZ=addZ+Z;
	assign sumM=addM+M;


	wire [7:0] pic_out1 [0:12][0:12];
	wire [7:0] pic_out2 [0:12][0:12];
	wire [7:0] pic_out3 [0:12][0:12];
	wire [7:0] pic_out4 [0:12][0:12];

	wire [31:0] filter_out1_1 , filter_out1_2 , filter_out1_3 , filter_out1_4 ;
	wire [31:0] filter_out2_1 , filter_out2_2 , filter_out2_3 , filter_out2_4 ;
	wire [31:0] filter_out3_1 , filter_out3_2 , filter_out3_3 , filter_out3_4 ;
	wire [31:0] filter_out4_1 , filter_out4_2 , filter_out4_3 , filter_out4_4 ;

	out_mem #0 out_mem0(.clk(clk) , .pic_out(pic_out1) , .filter_out1(filter_out1_1),.filter_out2(filter_out1_2),.filter_out3(filter_out1_3),.filter_out4(filter_out1_4)  , .Z(Z) , .M(sumM)  );
	out_mem #1 out_mem1(.clk(clk) , .pic_out(pic_out2) , .filter_out1(filter_out2_1) ,.filter_out2(filter_out2_2),.filter_out3(filter_out2_3),.filter_out4(filter_out2_4) , .Z(Z) , .M(sumM)  );
	out_mem #2 out_mem2(.clk(clk) , .pic_out(pic_out3) , .filter_out1(filter_out3_1) ,.filter_out2(filter_out3_2),.filter_out3(filter_out3_3),.filter_out4(filter_out3_4) , .Z(Z) , .M(sumM)  );
	out_mem #3 out_mem3(.clk(clk) , .pic_out(pic_out4) , .filter_out1(filter_out4_1) ,.filter_out2(filter_out4_2),.filter_out3(filter_out4_3),.filter_out4(filter_out4_4) , .Z(Z) , .M(sumM)  );

	counter #(.N(4), .M(32)) mCounter(.clk(clk),.rst(rst20),.en(en20),.cout(cout20),.count(addM));
	
	buffer13x13 buf13x13_1(.clk(clk),.shift(shift_buf13x13),.en(buf13x13_we),.in(pic_out1), .adr(index_buf13x13),.out(buffer13Out1));
	buffer13x13 buf13x13_2(.clk(clk),.shift(shift_buf13x13),.en(buf13x13_we),.in(pic_out2), .adr(index_buf13x13),.out(buffer13Out2));
	buffer13x13 buf13x13_3(.clk(clk),.shift(shift_buf13x13),.en(buf13x13_we),.in(pic_out3), .adr(index_buf13x13),.out(buffer13Out3));
	buffer13x13 buf13x13_4(.clk(clk),.shift(shift_buf13x13),.en(buf13x13_we),.in(pic_out4), .adr(index_buf13x13),.out(buffer13Out4));
	
	counter #(.N(11), .M(4)) myCounter4(.clk(clk),.rst(rst_adr_buf13),.en(en_adr_buf13),.cout(cout_adr_buf13),.count(index_buf13x13));

	buffer4x4	buf4x41(.clk(clk),.in(buffer13Out1),.en(buf4x4_en),.out(buffer4x4Out_2_1));
	buffer4x4	buf4x42(.clk(clk),.in(buffer13Out2),.en(buf4x4_en),.out(buffer4x4Out_2_2));
	buffer4x4	buf4x43(.clk(clk),.in(buffer13Out3),.en(buf4x4_en),.out(buffer4x4Out_2_3));
	buffer4x4	buf4x44(.clk(clk),.in(buffer13Out4),.en(buf4x4_en),.out(buffer4x4Out_2_4));

	counter #(.N(16), .M(4)) myCounter6(.clk(clk),.rst(count_max_rst),.en(count_max_en),.cout(count_max_cout),.count(counterOut2));

	mux16to1	mux16To1_1(.sel(counterOut2),.in(buffer4x4Out_2_1),.out(mac22Input1));
	mux16to1	mux16To1_2(.sel(counterOut2),.in(buffer4x4Out_2_2),.out(mac22Input2));
	mux16to1	mux16To1_3(.sel(counterOut2),.in(buffer4x4Out_2_3),.out(mac22Input3));
	mux16to1	mux16To1_4(.sel(counterOut2),.in(buffer4x4Out_2_4),.out(mac22Input4));

	PE2 PE2_1(.clk(clk),.done(done2),
	.bufferInput1(filter_out1_1),.bufferInput2(filter_out1_2),
	.bufferInput3(filter_out1_3),.bufferInput4(filter_out1_4),
	.kernelFilter_en(kernel_filter2_en[0]),.mux_sel(counterOut2),
	.mac2_input1(mac22Input1),.mac2_input2(mac22Input2),.mac2_input3(mac22Input3),.mac2_input4(mac22Input4)
	,.mac_en(PE2_mac_en),.mac_rst(PE2_mac_rst),.shiftReg_en(PE2_sh_reg_en),.counter_rst(PE_counter_rst),
    .counter_en(PE2_counter_en),.ofm_we(OFM_wr),.ofm_addr(OFM_adr_in),.number(0),.ofm_cout(OFM_cout));

	PE2 PE2_2(.clk(clk),.done(done2),
	.bufferInput1(filter_out2_1),.bufferInput2(filter_out2_2),
	.bufferInput3(filter_out2_3),.bufferInput4(filter_out2_4),
	.kernelFilter_en(kernel_filter2_en[1]),.mux_sel(counterOut2),
	.mac2_input1(mac22Input1),.mac2_input2(mac22Input2),.mac2_input3(mac22Input3),.mac2_input4(mac22Input4)
	,.mac_en(PE2_mac_en),.mac_rst(PE2_mac_rst),.shiftReg_en(PE2_sh_reg_en),.counter_rst(PE_counter_rst),
    .counter_en(PE2_counter_en),.ofm_we(OFM_wr),.ofm_addr(OFM_adr_in),.number(1),.ofm_cout(OFM_cout));

	PE2 PE2_3(.clk(clk),.done(done2),
	.bufferInput1(filter_out3_1),.bufferInput2(filter_out3_2),
	.bufferInput3(filter_out3_3),.bufferInput4(filter_out3_4),
	.kernelFilter_en(kernel_filter2_en[2]),.mux_sel(counterOut2),
	.mac2_input1(mac22Input1),.mac2_input2(mac22Input2),.mac2_input3(mac22Input3),.mac2_input4(mac22Input4)
	,.mac_en(PE2_mac_en),.mac_rst(PE2_mac_rst),.shiftReg_en(PE2_sh_reg_en),.counter_rst(PE_counter_rst),
    .counter_en(PE2_counter_en),.ofm_we(OFM_wr),.ofm_addr(OFM_adr_in),.number(2),.ofm_cout(OFM_cout));

	PE2 PE2_4(.clk(clk),.done(done2),
	.bufferInput1(filter_out4_1),.bufferInput2(filter_out4_2),
	.bufferInput3(filter_out4_3),.bufferInput4(filter_out4_4),
	.kernelFilter_en(kernel_filter2_en[3]),.mux_sel(counterOut2),
	.mac2_input1(mac22Input1),.mac2_input2(mac22Input2),.mac2_input3(mac22Input3),.mac2_input4(mac22Input4)
	,.mac_en(PE2_mac_en),.mac_rst(PE2_mac_rst),.shiftReg_en(PE2_sh_reg_en),.counter_rst(PE_counter_rst),
    .counter_en(PE2_counter_en),.ofm_we(OFM_wr),.ofm_addr(OFM_adr_in),.number(3),.ofm_cout(OFM_cout));

endmodule
