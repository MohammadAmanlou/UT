`timescale 1ps/1ps
module MUX_2_1 (
    select,
    input0,
    input1,
    result
);
    input  select;
    input [31:0] input1,input0;
    output reg [31:0] result;

    always @(select , input1,input0) begin
        case (select)
            1'b0: result=input0;
            1'b1: result=input1;
            default: result=32'bx;
        endcase
        
    end
endmodule