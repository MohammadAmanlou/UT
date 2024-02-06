module datapath(input mem_write , clk , buf88_write , buf88_shift , buf44_write , buf8_reg_jmp , mux_buf44_sel , reg_buf44_reset
	, buf16_write , mux16_1_sel , mac_reset , mac_enable , sh_reg_reset , sh_reg_en , sh_reg_sh ,count16_mux_reset 
	, count16_mux_en,X_reset,Y_reset,Z_reset, input[1:0] mem_mux_sel, 
	input muxX_sel,muxY_sel,muxZ_sel,reg_buf88_reset,input[1:0]mux_buf88_sel ,input[8:0] X , Y , Z 
	,output count16_mux_cout);
	wire[31:0] mem_data , mem_out ;
        wire[8:0]mem_adr,buf88_adr,buf44_adr;
	wire[7:0] mac_in1 , mac_in2 , mac_result ;
	wire[127:0] buf88_out , buf44_out , buf16_out;
	wire[3:0] mux16_sel;
	wire [8:0] X_in,X_out , Y_in,Y_out,Z_in ,Z_out ;
	wire [8:0] adderX_in,adderY_in,adderZ_in;
	wire [8:0] adder_buf88_in , adder_buf88_out;
	wire [8:0] adder_buf44_in , adder_buf44_out;
	wire jmp;
	mux2_1_9bit m2X(9'b0,9'd1,muxX_sel,adderX_in);
	mux2_1_9bit m2Y(9'b0,9'd1,muxY_sel,adderY_in);
	mux2_1_9bit m2Z(9'b0,9'd1,muxZ_sel,adderZ_in);
	Adder adderY(adderY_in,Y_out,Y_in);
	Adder adderX(adderX_in,X_out,X_in);
	Adder adderZ(adderZ_in,Z_out,Z_in);
	register X_reg(clk,X_reset,jmp,X_in,X,X_out);
	register Y_reg(clk,Y_reset,jmp,Y_in,Y,Y_out);
	register Z_reg(clk,Z_reset,jmp,Z_in,Z,Z_out);
	mux4_1_9bit mux_mem(X_out,Y_out,Z_out,9'b0,mem_mux_sel,mem_adr);
	
	Memory mem(mem_data ,mem_write , clk , mem_adr , mem_out);
	mux4_1_9bit mux_buf88(9'b0,9'd4,9'd1 ,9'b0,mux_buf88_sel,adder_buf88_in);
	Adder adder_buf88(adder_buf88_in, buf88_adr,adder_buf88_out);
	register reg_buf88(clk,reg_buf88_reset,buf8_reg_jmp,adder_buf88_out,9'b0,buf88_adr);
	Buffer_16x4 buf88(mem_out,buf88_write, clk, buf88_shift,buf88_adr,buf88_out);

	Adder adder_buf44(adder_buf44_in, buf44_adr,adder_buf44_out);
	mux2_1_9bit mux_buf44(9'b0,9'd32,mux_buf44_sel,adder_buf44_in);
	Buffer_44 buf44(mem_out,buf44_write, clk,buf44_adr,buf44_out);
	register reg_buf44(clk,reg_buf44_reset,jmp,adder_buf44_out,9'b0,buf44_adr);

	Buffer_16 buf16(buf88_out,buf16_write, clk,buf16_out);
	counter16 c16(clk,count16_mux_reset,count16_mux_en,count16_mux_cout,mux16_sel);
	mux_16to1 mux16_1_44(buf44_out,mux16_sel,mac_in1);
	mux_16to1 mux16_1_16(buf16_out,mux16_sel,mac_in2);
	MAC mac(clk,mac_reset,mac_in1 , mac_in2 ,mac_enable, mac_result);
	shift_register32 sh_reg(clk,sh_reg_reset,sh_reg_sh,sh_reg_en,mac_result,mem_data);
endmodule