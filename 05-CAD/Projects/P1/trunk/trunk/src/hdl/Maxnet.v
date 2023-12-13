module Maxnet(input [31:0] a0,a1,a2,a3 , input clk , start , output [31:0] Result);
wire en1 , en2 , en3 , sel , done , reset ;
Datapath dp(clk , en1 , en2 , en3 , sel , a0 , a1 , a2 , a3 ,Result , done);
Controller ctrl(clk,done,start,en1 , en2 , en3 , sel );

endmodule
