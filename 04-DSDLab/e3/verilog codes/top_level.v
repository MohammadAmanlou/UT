module top(input clk , rst , phase , ld_init , input [1:0]amp_sel, input [2:0] MSB ,func, output  out);
	wire[7:0] wave;
	wire low_freq_clk;
	wire[7:0] amp_out;
	freq_sel fs(ld_init , clk ,rst,MSB, low_freq_clk);
	amp_sel as(amp_sel ,  wave ,amp_out);

	waveform_generator wg(low_freq_clk,rst,phase ,func , wave);
	pwm p(amp_out , clk ,  out);	
endmodule
