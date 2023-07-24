module LUT (input [3:0] adr, output [15:0] data);
reg [15:0] datat;
	always @(adr) begin
		case(adr)
			0: datat = 16'hFFFF;
			1: datat = 16'h8000;//1/2
			2: datat = 16'h5555;//1/3
			3: datat = 16'h4000;// 1/4
			4: datat = 16'h3333;// 1/5
			5: datat = 16'h2AAA;// 1/6
			6: datat = 16'h2492;// 1/7
			7: datat = 16'h2000;// 1/8
		endcase
	end
assign data = datat;
endmodule





