`timescale 1ps/1ps
module sign_extended (
    instruction,
    ImmSrc,
    ImmBits
);
    input  [31:0] instruction;
    input [2:0] ImmSrc;
    output reg[31:0] ImmBits;

    always @(instruction,ImmSrc) begin
        case (ImmSrc)
            3'b000: ImmBits={{20{instruction[31]}} , instruction[31:20]};//I
            3'b001: ImmBits={{20{instruction[31]}} , instruction[31:25] , instruction[11:7]};//S
            3'b010: ImmBits={{20{instruction[31]}} , instruction[7] , instruction[30:25] , instruction[11:8] , 1'b0};//B
            3'b011: ImmBits={{12{instruction[31]}} , instruction[19:12] , instruction[20] , instruction[30:21], 1'b0};//J
            3'b100: ImmBits={{instruction[31:12]},12'b0};//U
            default: ImmBits =32'bx;
        endcase
    end
endmodule