module Datapath(input clk , en1 , en2 , en3 , sel , input [4:0] x1 , x2 , x3 , x4 ,
 output [4:0] Result , output done );

wire [4:0] a0_old , a1_old  , a2_old , a3_old;
memory5 mem(.clk(clk), .rst(), .en(en3) , .In0(x1), .In1(x2), .In2(x3), .In3(x4), .Out0(a0_old), .Out1(a1_old), .Out2(a2_old), .Out3(a3_old));
wire [4:0]pu0in , pu1in , pu2in , pu3in ;
wire [4:0]a0_new , a1_new  , a2_new, a3_new ;
Mux2To1 #5 m210(.in0(a0_new), .in1(a0_old), .sel(sel), .out(pu0in));
Mux2To1 #5 m211(.in0(a1_new), .in1(a1_old), .sel(sel), .out(pu1in));
Mux2To1 #5 m212(.in0(a2_new), .in1(a2_old), .sel(sel), .out(pu2in));
Mux2To1 #5 m213(.in0(a3_new), .in1(a3_old), .sel(sel), .out(pu3in));
PU pu0(.a1(pu0in) , .a2(pu1in) , .a3(pu2in) , .a4(pu3in) , .a_new(a0_new) , .clk(clk) , .en1(en1) , .en2(en2) );
PU pu1(.a1(pu1in) , .a2(pu0in) , .a3(pu2in) , .a4(pu3in) , .a_new(a1_new) , .clk(clk) , .en1(en1) , .en2(en2) );
PU pu2(.a1(pu2in) , .a2(pu1in) , .a3(pu0in) , .a4(pu3in) , .a_new(a2_new) , .clk(clk) , .en1(en1) , .en2(en2) );
PU pu3(.a1(pu3in) , .a2(pu0in) , .a3(pu1in) , .a4(pu2in) , .a_new(a3_new) , .clk(clk) , .en1(en1) , .en2(en2) );
wire [1:0] idx;
decoder dcd(.a0(a0_new), .a1(a1_new), .a2(a2_new), .a3(a3_new), .idx(idx) , .done(done));
Mux4To1 m4to1(.in0(a0_old) , .in1(a1_old)  , .in2(a2_old) , .in3(a3_old),.sel(idx),.out(Result));

endmodule
