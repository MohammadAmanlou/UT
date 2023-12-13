module Datapath(input clk , en1 , en2 , en3 , sel , input [31:0] x1 , x2 , x3 , x4 ,
 output [31:0] Result , output done );
wire [31:0] a0_old , a1_old  , a2_old , a3_old;
Mem4 m1(x1 , x2 , x3 , x4 , clk , en3 , a0_old , a1_old  , a2_old , a3_old );
wire [31:0]pu0in , pu1in , pu2in , pu3in ;
wire [31:0]a0_new , a1_new  , a2_new, a3_new ;
Mux2To1 m210(a0_new,a0_old ,sel,pu0in);
Mux2To1 m211(a1_new,a1_old ,sel,pu1in);
Mux2To1 m212(a2_new,a2_old ,sel,pu2in);
Mux2To1 m213(a3_new,a3_old ,sel,pu3in);
PU pu0(pu0in , pu1in , pu2in , pu3in , a0_new , clk , en1 , en2 );
PU pu1(pu1in , pu0in , pu2in , pu3in , a1_new , clk , en1 , en2 );
PU pu2(pu2in , pu1in , pu0in , pu3in , a2_new , clk , en1 , en2 );
PU pu3(pu3in , pu0in , pu1in , pu3in , a3_new , clk , en1 , en2 );
wire [1:0] idx;
Decoder dec(a0_new , a1_new  , a2_new, a3_new ,  idx , done);
Mux4To1 m4to1(a0_old , a1_old  , a2_old , a3_old,idx,Result);
endmodule
