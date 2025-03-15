`timescale 1ns/1ns
module mux5(select, Src1, Src2, Src3, Src4, Src5, out);
    input [2:0]select;
    input [31:0] Src1, Src2, Src3, Src4, Src5;
    output [31:0] out;
    reg [31:0] out;
    always @(*) begin
        case (select)
            3'd0: out= Src1;
            3'd1: out= Src2;
            3'd2: out= Src3;
            3'd3: out= Src4;
            3'd4: out= Src5;
            default: out=32'd0;
        endcase
    end
endmodule