module convolution(input clk , start, input[8:0] X,Y,Z ,output done);

wire mem_write , buf88_write , buf88_shift , buf44_write , buf8_reg_jmp ,mux_buf44_sel , reg_buf44_reset
	, buf16_write , mux16_1_sel , mac_reset , mac_enable , sh_reg_reset , sh_reg_en ,sh_reg_sh,count16_mux_reset 
	, count16_mux_en,X_reset,Y_reset,Z_reset;
	wire[1:0] mem_mux_sel;
	wire muxX_sel,muxY_sel,muxZ_sel,reg_buf88_reset;
	wire[1:0]mux_buf88_sel;
	wire count16_mux_cout ;

controller c(mem_write , clk , buf88_write , buf88_shift , buf44_write , buf8_reg_jmp ,mux_buf44_sel , reg_buf44_reset
	, buf16_write , mux16_1_sel , mac_reset , mac_enable , sh_reg_reset , sh_reg_en ,sh_reg_sh,count16_mux_reset 
	, count16_mux_en,X_reset,Y_reset,Z_reset, mem_mux_sel, 
	muxX_sel,muxY_sel,muxZ_sel,reg_buf88_reset,mux_buf88_sel , done
	,count16_mux_cout , start);

datapath d(mem_write , clk , buf88_write , buf88_shift , buf44_write , buf8_reg_jmp , mux_buf44_sel , reg_buf44_reset
	, buf16_write , mux16_1_sel , mac_reset , mac_enable , sh_reg_reset , sh_reg_en , sh_reg_sh ,count16_mux_reset 
	, count16_mux_en,X_reset,Y_reset,Z_reset, mem_mux_sel, 
	muxX_sel,muxY_sel,muxZ_sel,reg_buf88_reset,mux_buf88_sel ,
	X,Y,Z, count16_mux_cout);
endmodule
