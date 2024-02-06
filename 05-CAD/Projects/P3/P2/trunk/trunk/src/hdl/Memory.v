module memory(clk, adr, in, we, out);
	input clk;
	input[31:0] adr;
	input[31:0] in;
	input we;
	output[31:0] out;

	reg [31:0] data[0:511];
	initial $readmemh("file/input.txt", data); // ../../sim/file/input.txt
	
	assign out = data[adr];

	always@(posedge clk)
	begin
	if(we)
		data[adr] = in;
	end
endmodule

module out_mem #(parameter PE)(clk , pic_out , filter_out1, filter_out2 , filter_out3, filter_out4, Z , M  );
	input clk;
	input[31:0] M;
	input[6:0] Z;
	output reg[7:0] pic_out [0:12][0:12] ;
	output reg[31:0] filter_out1, filter_out2 , filter_out3, filter_out4;

	reg [31:0] pic[0:511];
	reg [31:0] filter[0:511];
	initial $readmemh($sformatf("file/output%0d_L1.txt", PE+1), pic); // "../../sim/file/output%0d_L1.txt"
	initial $readmemh($sformatf("file/filter%0d_L2.txt", PE+1), filter); // ../../sim/file/filter%0d_L2.txt
	
	reg [7:0] d;
	integer z , line = 0 , col = 0;
	always@(*)begin
		//pic_out = pic[Z];
		for(z = Z ; z < Z + 43 * 4  ; z = z + 1)begin
			if(line < 13)begin
			pic_out[col][line] = ((z-Z)%4 == 0) ? pic[Z + (z-Z)/4][31:24] : 
			     ((z-Z)%4 == 1) ? pic[Z + (z-Z)/4][23:16] :
			     ((z-Z)%4 == 2) ? pic[Z + (z-Z)/4][15:8] :
			     ((z-Z)%4 == 3) ? pic[Z + (z-Z)/4][7:0] : 8'b0;
			line = line + 1;
			end
			else if(line == 13)begin
				line = 0;
				col = col + 1;
				z = z - 1;
			end
		end
	end
	always@(posedge clk)begin
		filter_out1 = filter[M];
		filter_out2 = filter[M + 4];
		filter_out3 = filter[M + 8];
		filter_out4 = filter[M + 12];
	end

endmodule



//everything is OK!