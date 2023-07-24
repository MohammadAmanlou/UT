`timescale 1ns/1ns
module Xreg(input clk,rst,ldx,input[3:0]Pi,output zx,fullx,output reg[3:0] Po);
	assign zx = ~(|Po);
	assign fullx = &Po;
	always@(posedge clk , posedge rst)begin
		if(rst)
			Po <= 4'b0000;
		else
			Po <= ldx?Pi:Po;
	end
endmodule

module Yreg(input clk,rst,ldy,input[3:0]Pi,output zy,output reg[3:0] Po);
	assign zy = ~(|Po);
	always@(posedge clk , posedge rst)begin
		if(rst)
			Po <= 4'b1111;
		else
			Po <= ldy?Pi:Po;
	end
endmodule

module add_sub(input [3:0] value_in ,input sel , output [3:0] value_out , output co);
	parameter ADD =1;
	parameter SUB =0;

	assign {co,value_out} = sel? value_in+1:value_in-1;
	

endmodule

module Mux2_1(input reg [3:0]d1,d2 ,input sel , output reg [3:0]y);
	assign y= (sel)? d1 : d2 ;
endmodule

module stack(input reg clk, rst , push , pop, qpop , input reg [1:0] value_in , output reg [1:0] value_out, output reg err);
	parameter WIDTH = 1;
	parameter DEPTH = 255;

	reg [WIDTH:0] stack [0:DEPTH];
	reg [7:0] size;
	reg [7:0] qpop_num;

	always @(posedge clk) begin
		if(rst)begin
			size <= 0;
			err<=0;
			qpop_num<=0;

		end
		
		else if (push) begin
			err=0;
			if(size == DEPTH+1)
				err<=1;
			else begin
				size<= size+1;
				stack[size]<= value_in;
			end
		end
		else if (pop)begin
			if(size==0)
				err<=1;
			else begin
				err=0;
				value_out = stack[qpop_num + size-1];
				stack[qpop_num + size-1]=2'bz ;
				size= size-1;
			end
		end
		else if (qpop)begin
			if(size==0)
				err<=1;
			else begin
				err=0;
				value_out = stack[qpop_num];
				stack[qpop_num]=2'bz ;
				size = size-1;
				qpop_num = qpop_num+1;
			end
		end
	end
endmodule

module queue(input reg clk, rst, enqueue, dequeue , input reg [1:0] direction_in, output reg err, output reg [7:0] out);
	parameter UP = 00;
	parameter RIGHT = 01;
	parameter LEFT = 10;
	parameter DOWN = 11;

	parameter WIDTH = 7;
	parameter DEPTH = 255;
	
	reg[WIDTH:0] q [0:DEPTH];
	reg [8:0] last_ptr;
	reg [8:0] first_ptr;
	reg [3:0] x;
	reg [3:0] y;

	always @(posedge clk) begin
		if(rst) begin
			last_ptr <= 0;
			first_ptr <= 0;
			x<= 4'b1111;
			y <= 0	;
		end
		else if (enqueue)begin
			case( direction_in)
				UP : y=y-1;	
				RIGHT: x= x-1;
				LEFT: x=x+1;
				DOWN: y=y+1;
			endcase
			q[last_ptr] <= {x,y} ;//?
			last_ptr<= last_ptr+1;
		end
			
		else if (dequeue) begin
			if(last_ptr == first_ptr)
				err<=1;
			
			out <= q[first_ptr];
			q[first_ptr]<= 8'bz;
			first_ptr <=first_ptr+1;
		end
		
	end
endmodule

module dcd(input[1:0] stack_out,output up,right,left,down);
	assign up=(stack_out==2'b00)?1:0;
	assign right=(stack_out==2'b01)?1:0;
	assign left=(stack_out==2'b10)?1:0;
	assign down=(stack_out==2'b11)?1:0;
endmodule

module datapath(input clk,rst,ldx,ldy ,XPorX,YPorY,XorY_sel,addOrSub_sel,push,pop,qpop,input[1:0]stack_in ,output [3:0] X,Y , output up,right,left,down,err,co,zx,zy,finish,output [1:0]move);
	wire fullx;
	wire [3:0]Po_x ,Po_y;
	wire [3:0]q1 , q2 ;
	wire [1:0] stack_out;
	Xreg x(clk,rst,ldx,X, zx,fullx, Po_x);
	Yreg y(clk,rst,ldy,Y, zy,Po_y);
	and a1(finish,zy ,fullx);
	Mux2_1 XorY( Po_x,Po_y ,XorY_sel , q1);
	add_sub as(q1 ,addOrSub_sel , q2 , co);
	Mux2_1 XPorXm( q2 ,Po_x , XPorX , X) ,m3( q2 ,Po_y , YPorY , Y);
	stack s(clk,rst,push,pop,qpop,stack_in,stack_out,err);
	dcd d(stack_out,up,right,left,down);
	assign move=qpop?stack_out:2'bzz;
	
endmodule

	
