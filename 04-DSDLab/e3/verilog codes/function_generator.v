module waveform_generator_processor(input clk , rst ,input[7:0]count_num, 
output reg[7:0] waveform_square,waveform_reciprocal,waveform_triangle, waveform_sin , waveform_full_wave_rectified,waveform_half_wave_rectified);
	reg [7:0]  square, reciprocal, triangle,sinrep, down , up,half_wave_rectified,full_wave_rectified;
	reg [15:0] sin, cos, n_sin, n_cos , sin_moved;
	always @(count_num) begin
        	{up, down} = 16'b0000000000000000;
        	if (count_num[7]) begin 
			up = 8'b11111111 - count_num;
			down = count_num - 8'b11111111;
		end
        	else begin up = count_num;
			down = -count_num; 
		end
    	end

	always @(count_num) begin
        	square = 8'b11111111;
        	if (count_num[7]) begin
			square = 8'b00000000;
		end
	end

	always @(count_num) begin
        	reciprocal = 8'b11111111 / (8'b11111111 - count_num);
    	end

	always @(count_num) begin
		if(count_num < 128) triangle = count_num;
		else triangle = 255 - count_num;
	end

	always @(posedge clk or posedge rst) begin
        	if (rst)begin sin <= 16'b0000000000000000; cos <= 16'b0111010100110000; end  
        	else begin sin <= n_sin; cos <= n_cos; end
    	end

    	always @(sin or cos) begin
        	n_sin = sin + {{6{cos[15]}}, cos[15:6]};
		n_cos = cos - {{6{n_sin[15]}}, n_sin[15:6]};
    	end

	always @(sin) begin
       		sin_moved = sin[15:8] + 8'b01111111; 
    	end

    	always @(sin or sin_moved) begin
        	full_wave_rectified = 8'b00000000;
        	if (sin[15]) full_wave_rectified = -sin_moved;
        	else full_wave_rectified = sin_moved;
    	end

    	always @(sin or sin_moved) begin
        	half_wave_rectified = 8'b00000000;
        	if (sin[15]) half_wave_rectified = 8'b01111111;
        	else half_wave_rectified = sin_moved;       
    	end

	always @(square or reciprocal or triangle or sin or half_wave_rectified or full_wave_rectified)begin
		waveform_reciprocal = reciprocal;
            	waveform_triangle = triangle ;
            	waveform_full_wave_rectified = full_wave_rectified - 8'b01111111;
            	waveform_half_wave_rectified = half_wave_rectified - 8'b01111111;
            	waveform_sin = sin[15:8] ;
	end
endmodule

module Counter8bit(input clk,input rst,output reg [7:0] out);
    always @(posedge clk or posedge rst) begin
        if (rst) out <= 8'b00000000;
        else out <= out + 8'b00000001;
    end
endmodule

module mux7_1(input[7:0] waveform_square,waveform_reciprocal,waveform_triangle, waveform_sin , waveform_full_wave_rectified,waveform_half_wave_rectified,DDS_out, input[2:0] sel,output reg[7:0] out);
	assign out=(sel==3'b000)?waveform_square:
	(sel==3'b001)?waveform_reciprocal:
	(sel==3'b010)?waveform_triangle:
	(sel==3'b011)?waveform_sin:
	(sel==3'b100)?waveform_full_wave_rectified:
	(sel==3'b101)?waveform_half_wave_rectified:
	(sel==3'b110)?DDS_out:8'b00000000;

endmodule

module waveform_generator(input clk,rst,phase_cnt ,input[2:0] func , output [7:0] out);
	wire[7:0] DDS_out;
	wire [7:0] count_num;
	wire [7:0] waveform_square,waveform_reciprocal,waveform_triangle, waveform_sin , waveform_full_wave_rectified,waveform_half_wave_rectified;
	waveform_generator_processor wgp(clk , rst ,count_num, waveform_square,waveform_reciprocal,waveform_triangle, waveform_sin , waveform_full_wave_rectified,waveform_half_wave_rectified);
	DDS d(phase_cnt,clk ,rst,DDS_out);
	Counter8bit c(clk,rst ,count_num);
	mux7_1 m7_1(waveform_square,waveform_reciprocal,waveform_triangle, waveform_sin , waveform_full_wave_rectified,waveform_half_wave_rectified,DDS_out,func,out);
	
endmodule

