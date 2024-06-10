`timescale 1ns/1ns
module mux4 (select, Src1, Src2, Src3, Src4, out);
    input [1:0]select;
    input [31:0] Src1, Src2, Src3, Src4;
    output [31:0] out;
    reg [31:0] out;
    always @(*) begin
        case (select)
            2'd0: out= Src1;
            2'd1: out= Src2;
            2'd2: out= Src3;
            2'd3: out= Src4;
            default: out=32'd0;
        endcase
    end
endmodule