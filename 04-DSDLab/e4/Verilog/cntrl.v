`define Idle 3'b000
`define Init 3'b001
`define Begin 3'b010
`define Eng 3'b011
`define Mult 3'b100
`define Done 3'b101
`define Shift 3'b110


module counter_ctrl (input clk,rst,zero,ld,enb, input [2:0] in ,output reg [3:0] out, output  co);
	always@(posedge clk, posedge rst)begin
		if(rst == 1'b1)
			out <= 0;
		else
			if(zero == 1'b1)
				out <= 0;
			else if(ld == 1'b1)
				out <= in;
			else if(enb == 1'b1)
				out <= out + 1'b1;
	end
	assign co = (out >= 4'b1000)? 1'b1: 1'b0;
endmodule 





module cu(input start,clk,rst,eng_done,
output reg done,reset,ld,ui_reg_ld,eng_start,wr_reg,cnt_en,sh_en);
	reg[2:0] ps,ns;
	reg[1:0] count ;
	reg co;
	always@(posedge clk , posedge rst)begin
		if(rst) begin
			ps<=`Idle;
			count <= 2'b00;
		end
		else
			ps<=ns;
	end
	
	always@(ps ,start,eng_done,co)begin
		case(ps)
			`Idle: ns = start?`Init:`Idle;
			`Init: ns = start?`Init:`Begin;
			`Begin: ns= `Eng;
			`Eng: ns = `Mult;
			`Mult : ns = eng_done?`Done:`Mult;
			`Done: ns = co?`Idle:`Shift;
			`Shift : ns = `Eng;
			default ns=`Idle;
		endcase
	end

	always@(ps)begin
		{done,reset,ld,ui_reg_ld,eng_start,wr_reg,cnt_en,sh_en } = 8'b00000000;
		case(ps)
			`Idle : done = 1;
			`Init : reset = 1;
			`Begin : begin ld = 1; ui_reg_ld=1 ; end
			`Eng : eng_start=1;
			`Done : begin wr_reg=1;cnt_en=1; end
			`Shift : sh_en =1;
		endcase
	end
	always@(posedge cnt_en)begin
		{co ,count} = count +1;
	end

endmodule


