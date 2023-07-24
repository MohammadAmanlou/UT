`timescale 1ns/1ns
module WGPTB();
    wire [7:0] waveform_square,waveform_reciprocal,waveform_triangle,waveform_full_wave_rectified,waveform_half_wave_rectified,waveform_sin;
    reg clk, rst;
    reg [7:0] count_num;
    integer i , j , k;

    waveform_generator_processor UUT(clk, rst, count_num, waveform_square,waveform_reciprocal,waveform_triangle,waveform_sin,waveform_full_wave_rectified,waveform_half_wave_rectified);
    
    initial begin
        rst = 1; #5;
        clk = 1; #10;
        rst = 0; #5;
        clk = 0;
        for(i = 0; i < 7; i = i+1)begin
          for(j = 0; j < 10; j = j+1) begin
            count_num = 8'b00000000;
            for(k = 0; k < 255; k = k+1) begin count_num = count_num + 8'b00000001;
	    clk = 1; #20; 
	    clk = 0; #20; end
          end
        end
    end

endmodule
