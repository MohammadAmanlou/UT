module top_level(input [4:0] vvi , input start , input[1:0] ui , input clk, rst ,  output wr_req ,
output done , output[20:0] wr_data) ;
	reg [15:0]vi;
	assign vi = {3'b000 , vvi , 8'b00000000};
	wire eng_done;
	wire[15:0] eng_x;
	wire[15:0] fracpart;
	wire[1:0] intpart;
	wire [20:0]data_out;
	wire [1:0] shift;
	cu c(start,clk,rst,eng_done,done,reset,ld,ui_reg_ld,eng_start,wr_req,cnt_en,sh_en);
	ShiftReg SR(clk, reset, ld, sh_en,vi,eng_x);
	exponential expEng(clk ,reset , eng_start, eng_x, eng_done, intpart, fracpart);
	UI_Reg UR(clk, rst, ui_reg_ld,ui,shift);
	CombShift CS(shift,{intpart,fracpart},wr_data);
	one_pulser op(clkPB,clk,rst,rd_req);

	

endmodule