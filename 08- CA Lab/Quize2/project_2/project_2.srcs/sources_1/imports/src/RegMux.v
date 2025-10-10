module RegMux(
    input MEM_W_EN,
    input [3:0] in0,
    input [3:0] in1,
    output[3:0] mOut
);
    assign mOut = MEM_W_EN ? in1 : in0;
endmodule