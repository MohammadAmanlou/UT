`timescale 1ps/1ps
module inst_Mem (
    adr,
    instruction
);  
    input [31:0] adr;
    output reg[31:0] instruction;
    reg[31:0] Memory[1000:0];//4KB
    initial begin
        $readmemh("machine.mem", Memory);
    end 

    always @(adr) begin
         instruction[31:0] <= Memory[{2'b00 , adr[31:2]}];
    end
    
endmodule
