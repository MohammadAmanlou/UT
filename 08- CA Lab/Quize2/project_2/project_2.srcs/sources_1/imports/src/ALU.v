module ALU (
    input [31:0] in1,
    input [31:0] in2,
    input carry_in,
    input [3:0] ALU_op,
    output reg [31:0] result,
    output reg [3:0] NZCV
);

function [31:0] fib;
    input [31:0] n;
    integer i;
    reg [31:0] x, y, t;
    begin
        x = 0;
        y = 1;
        for (i = 0; i < n; i = i + 1) begin
            t = x + y;
            x = y;
            y = t;
        end
        fib = x;
    end
endfunction

always @(*) begin
    case (ALU_op)
        4'b0001: result = in2;                                // MOV
        4'b1001: result = ~in2;                               // MVN
        4'b0010: {NZCV[1],result} = in1 + in2;                          // ADD
        4'b0011: {NZCV[1],result} = in1 + in2 + {31'b0,carry_in};               // ADC
        4'b0100: {NZCV[1],result} = in1 - in2;                          // SUB
        4'b0101: {NZCV[1],result} = in1 - in2 - {31'b0,~carry_in};              // SBC
        4'b0110: result = in1 & in2;                          // AND
        4'b0111: result = in1 | in2;                          // ORR
        4'b1000: result = in1 ^ in2;                          // EOR
        4'b0100: result = in1 - in2;                          // CMP
        4'b0110: result = in1 & in2;                          // TST
        4'b0010: result = in1 + in2;                          // LDR
        4'b0010: result = in1 + in2;                          // STR
        4'b1111: result = fib(in1);
        default: result = 32'b0;                               // NOP
    endcase

    NZCV[3] = result[31];  
    NZCV[2] = (result == 32'b0) ? 1 : 0;  


    if (ALU_op == 4'b0010 || ALU_op == 4'b0011) begin  // ADD or ADC
        NZCV[0] = ((in1[31] == in2[31]) && (result[31] != in1[31])) ? 1 : 0; 
    end
    else if (ALU_op == 4'b0100 || ALU_op == 4'b0101) begin  // SUB or SBC
        NZCV[0] = ((in1[31] == 0)&&((in2[31] == 1)) && (result[31] == 1)) ? 1 : 0;  
    end
    else begin
        NZCV[1] = 0; 
        NZCV[0] = 0;  
    end
end

endmodule

