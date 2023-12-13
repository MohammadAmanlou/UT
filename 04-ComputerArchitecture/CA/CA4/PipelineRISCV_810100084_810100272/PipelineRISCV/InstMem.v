
module InstMemory2 (input[31:0] A,output[31:0] RD); 

    reg [31:0] instMem [0:16383];

    wire [31:0] adr;
    assign adr = {2'b00,A[31:2]}; 

    initial $readmemh("inst_memory.txt", instMem);
    assign RD=instMem[adr];
endmodule



module InstMemory (input[31:0] A,output[31:0] RD); 

    reg [7:0] instMem [0:$pow(2, 16)-1]; 

    wire [31:0] adr;
    assign adr = {A[31:2],2'b00}; 
    

    initial $readmemh("instructions.mem", instMem);
    assign RD = {instMem[adr + 3], instMem[adr + 2], instMem[adr + 1], instMem[adr]};
endmodule




