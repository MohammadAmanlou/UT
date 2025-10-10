module CUMUX(
    input sel,
    input WB_EN,
    input imm,
    input MEM_R_EN,
    input MEM_W_EN,
    input B,
    input [3:0] EXE_CMD,
    input S,
    output WB_EN_out,
    output imm_out,
    output MEM_R_EN_out,
    output MEM_W_EN_out,
    output B_out,
    output [3:0] EXE_CMD_out,
    output S_out
);

assign WB_EN_out    = ~sel ? WB_EN    : 1'b0;
assign imm_out      = ~sel ? imm      : 1'b0;
assign MEM_R_EN_out = ~sel ? MEM_R_EN : 1'b0;
assign MEM_W_EN_out = ~sel ? MEM_W_EN : 1'b0;
assign B_out        = ~sel ? B        : 1'b0;
assign EXE_CMD_out  = ~sel ? EXE_CMD  : 4'b0000;
assign S_out        = ~sel ? S        : 1'b0;

endmodule
