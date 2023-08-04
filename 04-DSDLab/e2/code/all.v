
`define 	A 	2'b00
`define 	B 	2'b01
`define 	C 	2'b10	

`define 	Q0	3'b000
`define 	Q1	3'b001
`define 	Q2	3'b010
`define 	Q3	3'b011
`define 	Q4 	3'b100
`define 	Q5 	3'b101
`define 	Q6 	3'b110

module counter(input clk,rst,clkEn,load,output reg Co,output reg[3:0] cnt_out);
	reg[3:0] counterUp;
	always@(posedge clk,posedge rst)begin
		if(rst)begin
			counterUp<=4'b0110;
			Co<=0;
			end
		else if(clkEn&&load)
			{Co,counterUp}<=counterUp+1;
	end
	assign cnt_out=counterUp;
endmodule
module one_pulser(input clk,rst,clkPB,output reg SP);
	reg[1:0] ps,ns;
	always@(posedge clk,posedge rst)begin
		if (rst)
			ps<=0;
		else 
			ps<=ns;
	end
	always@(ps,clkPB)begin 
		case(ps)
			`A:ns=clkPB?`B:`A;
			`B:ns=`C;
			`C:ns=clkPB?`C:`A;
		endcase
	end
	always@(ps,clkPB)begin 
		case(ps)
			`A:SP=0;
			`B:SP=1;
			`C:SP=0;
		endcase
	end
endmodule
module Sequence_Detector(input clk,rst,clkEn,serIn,Co,output reg serOut,serOutValid,cnt_load,reset_cnt);
	reg[2:0] ps,ns;
	always@(posedge clk,posedge rst)begin
		if (rst)
			ps<=`A;
		else 
			ps<=ns;
	end
	always@(ps,clkEn,serIn,Co)begin 
		case(ps)
			`Q0:ns=(~clkEn)?`Q0:(serIn)?`Q1:`Q0;
			`Q1:ns=(~clkEn)?`Q1:(serIn)?`Q2:`Q0;
			`Q2:ns=(~clkEn)?`Q2:(serIn)?`Q2:`Q3;
			`Q3:ns=(~clkEn)?`Q3:(serIn)?`Q4:`Q0;
			`Q4:ns=(~clkEn)?`Q4:(serIn)?`Q2:`Q5;
			`Q5:ns=(~clkEn)?`Q5:(serIn)?`Q6:`Q0;
			`Q6:ns=Co?`Q0:`Q6;
		endcase
	end
	always@(ps,clkEn,serIn,Co)begin 
		{serOut,serOutValid,cnt_load,reset_cnt}=4'b0000;
		case(ps)
			`Q0:;
			`Q1:;
			`Q2:;
			`Q3:;
			`Q4:;
			`Q5:reset_cnt=(clkEn&&serIn)?1:0;
			`Q6:begin 
				cnt_load=1;
				serOutValid=1;
				serOut=clkEn?serIn:1'bz;
			end
		endcase
	end
	assign serOut = serOutValid?serIn:1'bz;
endmodule
