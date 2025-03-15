`timescale 1ns/1ns
module mux2(select, Src1, Src2, out);
    input select;
    input [31:0] Src1, Src2;
    output [31:0] out;
    reg [31:0] out;
    always @(*) begin
        case (select)
            1'd0: out= Src1;
            1'd1: out= Src2;
            default: out=32'd0;
        endcase
    end
endmodule