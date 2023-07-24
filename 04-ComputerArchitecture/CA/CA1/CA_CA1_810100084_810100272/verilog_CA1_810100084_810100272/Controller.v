`timescale 1ns/1ns
`define START 5'b00000
`define INIT 5'b00001
`define UP 5'b00010
`define READ_UP 5'b00011
`define GO_UP 5'b00100
`define RIGHT 5'b00101
`define READ_RIGHT 5'b00110
`define GO_RIGHT 5'b00111
`define LEFT 5'b01000
`define READ_LEFT 5'b01001
`define GO_LEFT 5'b01010
`define DOWN 5'b01011
`define READ_DOWN 5'b01100
`define GO_DOWN 5'b01101
`define BACK_TRACK 5'b01110
`define BACK_TRACK1 5'b11011
`define BACK_TRACK2 5'b11100
`define BACK_UP 5'b01111
`define BACK_RIGHT 5'b10000
`define BACK_LEFT 5'b10001
`define BACK_DOWN 5'b10010
`define BACK_LOAD 5'b10011
`define DONE 5'b10111
`define MOVE 5'b11000
`define FINISH 5'b11001
`define FAIL 5'b11010

module cu(input start,co,dout,zx,zy,finish,run,reset ,clk,err, up,right,left,down,
output reg rst,read,write,ldx,ldy,push,pop,qpop,fail,done,XorY,add_sub,YPorY,XPorX,din
,output reg[1:0] direct );
	reg[4:0] ps,ns;
	always@(posedge clk , posedge rst)begin
		if(reset)
			ps<=`START;
		else
			ps<=ns;
	end
	always@(ps or start or co or dout or zx or zy or up or right or left or down or finish or run or err)begin
		case(ps)
			`START:ns=start?`INIT:`START;
			`INIT:ns=start?`INIT:`UP;
			`UP:ns=finish?`DONE:co?`RIGHT:`READ_UP;
			`READ_UP:ns=dout?`RIGHT:`GO_UP;
			`RIGHT:ns=co?`LEFT:`READ_RIGHT;
			`READ_RIGHT:ns=dout?`LEFT:`GO_RIGHT;
			`LEFT:ns=zx?`DOWN:`READ_LEFT;
			`READ_LEFT:ns=dout?`DOWN:`GO_LEFT;
			`DOWN:ns=zy?`BACK_TRACK:`READ_DOWN;
			`READ_DOWN:ns=dout?`BACK_TRACK1:`GO_DOWN;
			`BACK_TRACK1:ns=`BACK_TRACK;
			`BACK_TRACK:ns=err?`FAIL:up?`BACK_UP:right?
				`BACK_RIGHT:left?`BACK_LEFT:`BACK_DOWN;
			`FAIL:ns=`START;
			`BACK_UP:ns=`UP;
			`BACK_RIGHT:ns=`UP;
			`BACK_LEFT:ns=`UP;
			`BACK_DOWN:ns=`UP;
			`GO_UP:ns=finish?`DONE:`UP;
			`GO_DOWN:ns=finish?`DONE:`UP;
			`GO_LEFT:ns=finish?`DONE:`UP;
			`GO_RIGHT:ns=finish?`DONE:`UP;
			`DONE:ns=run?`MOVE:`DONE;
			`MOVE:ns=err?`FINISH:`MOVE;
			`FINISH:ns=`START;
			default ns=`START;
		endcase
	end
	always@(ps)begin
		{rst,read,write,ldx,ldy,push,pop,qpop,fail,done,XorY,add_sub,YPorY,XPorX,din} = 15'b000000000000000;
		direct = 2'b00;
		case(ps)
			`START:rst=1;
			`INIT:begin write=1;din=1;end
			`UP:begin add_sub=1;YPorY=1;direct=2'b00;end
			`READ_UP:begin add_sub=1;YPorY=1;direct=2'b00;read=1;end
			`RIGHT:begin XorY=1;add_sub=1;XPorX=1;direct=2'b01;end
			`READ_RIGHT:begin XorY=1;add_sub=1;XPorX=1;direct=2'b01;read=1;end
			`LEFT:begin XorY=1;XPorX=1;direct=2'b10;end
			`READ_LEFT:begin XorY=1;XPorX=1;direct=2'b10;read=1;end
			`DOWN:begin YPorY=1;direct=2'b11;end
			`READ_DOWN:begin YPorY=1;direct=2'b11;read=1;end
			`BACK_TRACK1:begin pop=1;end
			`FAIL:fail=1;
			`BACK_UP:begin YPorY=1;ldx=1;ldy=1;end
			`BACK_RIGHT:begin XorY=1;XPorX=1;ldx=1;ldy=1;end
			`BACK_LEFT:begin XorY=1;add_sub=1;XPorX=1;ldx=1;ldy=1;end
			`BACK_DOWN:begin add_sub=1;YPorY=1;ldx=1;ldy=1;end
			`GO_UP:begin direct=2'b00;push=1;din=1;add_sub=1;YPorY=1;write=1;ldx=1;ldy=1;end
			`GO_RIGHT:begin XorY=1;add_sub=1;XPorX=1;direct=2'b01;push=1;din=1;write=1;ldx=1;ldy=1;end
			`GO_LEFT:begin XorY=1;XPorX=1;direct=2'b10;push=1;din=1;write=1;ldx=1;ldy=1;end
			`GO_DOWN:begin YPorY=1;direct=2'b11;push=1;din=1;write=1;ldx=1;ldy=1;end
			`DONE:done=1;
			`MOVE:begin qpop=1;end
			`FINISH:rst=1;
		endcase
	end
endmodule
