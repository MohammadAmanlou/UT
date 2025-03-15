`timescale 1ps/1ps
module MUX_4_1 (
    select,
    input0,
    input1,
    input2,
    input3,
    result
);
    input [1:0] select;
    input [31:0] input1,input2,input3,input0;
    output reg [31:0] result;

    always @(select , input1,input2,input3,input0) begin
        case (select)
            2'b00: result=input0;
            2'b01: result=input1;
            2'b10: result=input2;
            2'b11: result=input3;
            default: result=32'bx;
        endcase
        
    end
endmodule