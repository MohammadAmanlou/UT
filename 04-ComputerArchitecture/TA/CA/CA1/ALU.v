`timescale 1ns/1ns
module ALU (SrcA, SrcB, ALUControl, ALUResult, zero, bge, lt);
    input [31:0] SrcA, SrcB;
    input [2:0] ALUControl;
    output [31:0] ALUResult;
    output  zero, bge, lt;
    reg [31:0] ALUResult;
    wire [1:0] mode_choose;
    assign mode_choose={SrcA[31],SrcB[31]};
    always @(*) begin
        case (ALUControl)
            3'd0: ALUResult=SrcA+SrcB;
            3'd1: ALUResult=SrcA-SrcB;
            3'd2: ALUResult=SrcA & SrcB;
            3'd3: ALUResult=SrcA | SrcB;
            3'd4: ALUResult= SrcA ^ SrcB;
            3'd5:case (mode_choose)
                2'b00: ALUResult = (SrcA < SrcB) ? 32'd1 : 32'd0;
                2'b01: ALUResult = 32'd0;
                2'b10: ALUResult = 32'd1;
                2'b11: ALUResult= (SrcA > SrcB) ? 32'd1 : 32'd0; 
            endcase //slt
            3'd6: ALUResult= (SrcA < SrcB) ? 32'd1 : 32'd0; //sltu
            default: ALUResult=32'd0;
        endcase
    end
    assign zero =(SrcA == SrcB)? 1'b1 :1'b0;
    assign bge =(SrcA >= SrcB)? 1'b1 :1'b0;
    assign lt =(SrcA < SrcB)? 1'b1 :1'b0;

endmodule