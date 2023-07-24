`timescale 1ns/1ns
module maze_memo(input clk,read,write,d_in,rst,input[3:0] X,Y,output reg mode);
	reg[15:0] Maze[0:15];
	reg [0:15]temp;
	initial begin
		$readmemh("map.txt", Maze);
	end
	always@(posedge clk or posedge rst) begin
		if(rst)begin
			$readmemh("map.txt", Maze);
			mode = 1'bz;
		end
		else if(write)begin
			temp = Maze[15-Y];
			temp[X] = d_in;
			Maze[15 - Y] = temp;
		end	
	end
	always@(X or Y or read) begin
		if(read)begin
			temp = Maze[15-Y];
			mode = temp[X];

		end
		else	
			mode = 1'bz;
	end
endmodule

			
