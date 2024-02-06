`define q0 5'b00000
`define q1 5'b00001
`define q2 5'b00010
`define q3 5'b00011
`define q4 5'b00100
`define q5 5'b00101
`define q6 5'b00110
`define q7 5'b00111
`define q8 5'b01000
`define q9 5'b01001
`define q10 5'b01010
`define q11 5'b01011
`define q12 5'b01100
`define q13 5'b01101
`define q14 5'b01110
`define q15 5'b01111
`define q16 5'b10000
`define q17 5'b10001
`define q18 5'b10010
`define q19 5'b10011
`define q65 5'b10100
`define q77 5'b10101
`define q131 5'b10110
`define q144 5'b10111


module controller#(parameter P = 0)(input clk , output reg done , 
	output reg muxX_sel, muxY_sel , muxZ_sel, mem_mux_sel, output reg [1:0] mux_buf4x16_sel ,
	output reg mem_write, buf4x16_write , buf16_write, count16_mux_en, count_PE_en , MAC_en , ofm_write, shift_reg_we , output reg[P-1 : 0] buf4x4_we, 
	output reg reg_buf4x16_reset, X_reset, Y_reset , Z_reset , buf4x16_reg_jmp, count16_mux_reset , MAC_rst, counter_PE_rst , shift_reg_rst , reg_buf44_reset , 
	buf4x16_shift , reg_shift , mux_buf44_sel , 
	input count16_mux_cout , count_PE_cout , start);

	reg[1:0] make_8buf_counter_4_line = 0;
	reg[1:0] make_8buf_counter_3_shift = 0;
	reg[1:0] make_16buf_counter_4_line = 0 ;
	reg[4:0] ps=5'b0;
	reg[4:0] ns;
	reg[1:0] counter_4_result = 0 ;
	reg[3:0] counter13_buf8_ofoghi = 0;
	reg[3:0] counter13_buf8_amoodi = 0;
	reg[1:0] counter4_add_new_line = 0;
	reg[3:0] counter16_mac_mux = 0;
	reg[31:0] kernel = 0;

	always@(posedge clk)begin
		ps<=ns;
	end

	always@(ps , start)begin 
		case(ps)
		`q0:ns = (start) ? `q1 : `q0;
		`q1:ns = (start) ? `q1 : `q2; 

		`q2:ns = (1 != &make_8buf_counter_4_line) ? `q3 : (3 != make_8buf_counter_3_shift) ? `q4 : `q5 ;
		`q3:ns =`q2;
		`q4:ns =  `q2 ;

		`q5:ns =  `q6  ;
		`q6:ns = (1 !=&make_16buf_counter_4_line) ? `q5 : `q65;
		`q65: ns = (kernel == P - 1) ? `q7 : `q5;

		`q7:ns = (&counter16_mac_mux != 1) ? `q77 : `q8;
		`q77:ns= `q7;
		`q8:ns = (&counter_4_result != 1) & (counter13_buf8_ofoghi != 12) ? `q9 : `q10;
		`q9:ns = `q7;
		
		`q10:ns = (counter13_buf8_ofoghi == 4'd13) ? `q11 : `q9;

		`q11:ns = (counter13_buf8_amoodi == 4'd13) ? `q12 : `q131;
		`q131:ns = `q13;
		`q12:ns = `q0;
		`q13:ns = (&(counter4_add_new_line - 1)) ? `q144 : `q15;
		`q144: ns= `q14;
		`q14:ns = `q7;
		`q15:ns = `q13;
		
		endcase
	end

	always@(ps )begin
		{done , muxX_sel, muxY_sel , muxZ_sel, mem_mux_sel, mux_buf4x16_sel , 
		mem_write, buf4x16_write , buf16_write, count16_mux_en, count_PE_en , MAC_en , ofm_write, shift_reg_we , buf4x4_we, 
		reg_buf4x16_reset, X_reset, Y_reset , Z_reset , buf4x16_reg_jmp, count16_mux_reset , MAC_rst, counter_PE_rst , shift_reg_rst , reg_buf44_reset ,
		buf4x16_shift , reg_shift ,mux_buf44_sel} ={145'b0};
	      case(ps)
		`q1:{X_reset,Y_reset,Z_reset,buf4x16_reg_jmp,count16_mux_reset,MAC_rst,counter_PE_rst,shift_reg_rst , reg_buf44_reset} = 10'b1111111111;
		`q2:begin {buf4x16_write ,muxX_sel} = 2'b11; mux_buf4x16_sel = 2'b01; end
		`q3:begin  make_8buf_counter_4_line = make_8buf_counter_4_line+1;end
		`q4: begin {buf4x16_shift,buf4x16_reg_jmp} =2'b11; make_8buf_counter_3_shift = make_8buf_counter_3_shift + 1;make_8buf_counter_4_line = 0;end
		`q5: begin {mem_mux_sel,reg_buf4x16_reset}=2'b11 ;  end

		`q6: begin{muxY_sel,mux_buf44_sel ,buf16_write , mem_mux_sel , buf4x4_we[kernel] } = 5'b11111;make_16buf_counter_4_line = make_16buf_counter_4_line + 1;end
		`q65: begin kernel = kernel + 1; make_16buf_counter_4_line = 0; reg_buf44_reset = 1; end

		`q7: begin {count16_mux_en , MAC_en} = 2'b11; end
		`q77: counter16_mac_mux = counter16_mac_mux + 1;
		`q8: begin {shift_reg_we , MAC_rst  }=2'b11; counter_4_result = counter_4_result + 1; counter13_buf8_ofoghi = counter13_buf8_ofoghi + 1;mux_buf4x16_sel = 2'd2; end
		`q9: begin{buf16_write , count16_mux_reset , reg_shift} = 3'b111; counter16_mac_mux = 0;end
		`q10:begin {count16_mux_reset,ofm_write,buf16_write,shift_reg_rst,muxZ_sel}=5'b11111 ;mem_mux_sel = 2 ;counter_4_result = 0;  end
		`q11:begin counter4_add_new_line = counter4_add_new_line + 1; counter13_buf8_ofoghi = 0;counter13_buf8_amoodi = counter13_buf8_amoodi + 1;end
		`q12: done = 1;
		`q131: {buf4x16_reg_jmp ,buf4x16_shift} = 2'b11;
		`q13: begin {buf4x16_write , muxX_sel} = 2'b11; mux_buf4x16_sel = 1; end
		`q144: reg_buf4x16_reset = 1;
		`q14: begin {buf16_write} = 1'b1; counter13_buf8_ofoghi =0; counter_4_result = 0; counter16_mac_mux = 0; end
		`q15: counter4_add_new_line = counter4_add_new_line + 1;

	endcase
	end
endmodule


