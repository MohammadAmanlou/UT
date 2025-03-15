`timescale 1ns/1ns
module controller (opcode, func3, func7, zero, bge, lt, 
                    PCSrc, ResultSrc, MemWrite, ALUControl, ALUSrc2, ImmSrc, RegWrite);
    input [6:0] opcode;
    input [2:0] func3;
    input [6:0] func7;
    input zero, bge, lt;
    output  MemWrite,RegWrite;
    output [1:0] PCSrc, ResultSrc, ALUSrc2;
    output [2:0] ALUControl, ImmSrc;
    reg MemWrite, RegWrite;
    reg [1:0] PCSrc, ResultSrc, ALUSrc2;
    reg [2:0] ALUControl, ImmSrc;
    wire [9:0] function_choose={func7,func3};
    always @(*) begin
        {MemWrite, RegWrite} =2'd0;
        {PCSrc, ResultSrc, ALUSrc2} =6'd0;
        {ALUControl, ImmSrc} =6'd0;
        case (opcode)
            7'd51: case (function_choose)
                10'd0: {RegWrite}=2'b1;              //add
                10'd256:begin
                    RegWrite=1'b1;
                    ALUControl=3'b001;
                end           //sub
                10'd6:begin
                    RegWrite=1'b1;
                    ALUControl=3'b011;
                end              //or
                10'd7:begin
                    ALUControl=3'b010;
                    RegWrite=1'b1;
                end              //and
                10'd2:begin
                    RegWrite=1'b1;
                    ALUControl=3'b101;
                end              //slt
                10'd3:begin
                    ALUControl=3'b110;
                    RegWrite=1'b1;
                end               //sltu
            endcase 
            7'd19:case (func3)
                3'b000:begin
                    RegWrite=1'b1;
                    ALUSrc2=2'b01;
                end     //addi
                3'b100:begin
                    ALUControl=3'b100;
                    RegWrite=1'b1;
                    ALUSrc2=2'b01;
                end     //xori
                3'b110:begin
                    ALUControl=3'b011;
                    RegWrite=1'b1;
                    ALUSrc2=2'b01;
                end     //ori
                3'b010:begin
                    ALUControl=3'b101;
                    RegWrite=1'b1;
                    ALUSrc2=2'b01;
                end     //slti
                3'b011:begin
                    ALUControl=3'b110;
                    ALUSrc2=2'b01;
                    RegWrite=1'b1;
                end     //sltui
            endcase
            7'd3:begin
                ResultSrc=2'b01;
                ALUSrc2=2'b01;
                RegWrite=1'b1;
            end           //lw
            7'd35:begin
                MemWrite=1'b1;
                ImmSrc=3'b001;
                ALUSrc2=2'b01;
            end          //sw
            7'd99:case (func3)
                3'b000:begin
                    PCSrc=(zero==1)? 2'b01 : 2'b00;
                    ImmSrc=3'd2;
                end             //beq
                3'b001:begin
                    PCSrc=(zero==1)? 2'b00 : 2'b01;
                    ImmSrc=3'd2;

                end             //bne
                3'b100:begin
                    PCSrc=(lt==1)?  2'b01: 2'b00;
                    ImmSrc=3'd2;

                end             //blt
                3'b101:begin
                    PCSrc=(bge==1)? 2'b01: 2'b00;
                    ImmSrc=3'd2;
                end   //bge
            endcase
            7'd55:begin
                ImmSrc= 3'b011;
                RegWrite= 1'b1;
                ResultSrc=2'b11;
            end           //lui
            7'd111:begin
                PCSrc=2'b01;
                ResultSrc=2'b10;
                ImmSrc=3'b100;
                RegWrite=1'b1;
            end            //jal
            7'd103:begin
                PCSrc=2'b10;
                ResultSrc=2'b10;
                RegWrite=1'b1;
                ALUSrc2=2'b01;
            end //jalr
        endcase
    end
endmodule
