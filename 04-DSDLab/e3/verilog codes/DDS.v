module ROM(input clk ,input [7:0] adr, output reg[7:0] out);
	(* romstyle = "M9K" *)(* ram_init_file="sine.mif.txt" *) reg [7:0] rom [7:0];
	always@(posedge clk)begin
		out = rom[adr];
	end
endmodule


module DDS(input phase_cnt, input clk , rst, output [7:0] wave);
	reg  [7:0] adr = 8'b0 ;
	reg [7:0] num_add ;
	always@(posedge clk or posedge rst)begin 
		if(rst) begin adr <= 8'b00000000 ; end
		else begin
			num_add = phase_cnt?(8'b00000010):8'b00000001;
			adr = adr + num_add;
		end
	end
	//ROM r(clk , adr,wave);
endmodule

