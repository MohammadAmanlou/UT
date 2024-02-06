module Maxnet(input [4:0] a0,a1,a2,a3 , input clk , start , rst , output [4:0] Result);
wire en1 , en2 , en3 , sel , done , reset ;
Datapath dp(clk , en1 , en2 , en3 , sel , a0 , a1 , a2 , a3 ,Result , done);
Controller ctrl(clk,done,start,rst,en1 , en2 , en3 , sel );

endmodule
