`timescale 1ns/1ns
module ALU_TB();
    logic[7:0] A , B ;
    logic[2:0] F = 3'b0;
    wire[7:0] W;
    wire c, z;
    ALU uut(A, B, F, W, c, z);    
    initial begin
        A = 8'b00100110;
        B = 8'b00000011;
        F = 3'b000;
        #100;
        F = 3'b001;
        #100;
        F = 3'b010;
	#100
        F = 3'b011;
        #100;
        F = 3'b100;
        #100
        F = 3'b101;
        #100;
        F = 3'b110;
        #100;
        F = 3'b111;
        #100 $stop;
    end
endmodule
