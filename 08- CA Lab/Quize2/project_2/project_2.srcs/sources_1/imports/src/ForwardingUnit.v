module ForwardingUnit(
    input [3:0] id_ex_rs,
    input [3:0] id_ex_rt,
    input [3:0] ex_mem_rd,
    input ex_mem_wb_en,
    input [3:0] mem_wb_rd,
    input mem_wb_en,
    output reg forwardA,
    output reg forwardB
);

always @(*) begin
    forwardA = 0;
    forwardB = 0;
    if (ex_mem_wb_en && ex_mem_rd != 0 && ex_mem_rd == id_ex_rs)
        forwardA = 1;
    if (ex_mem_wb_en && ex_mem_rd != 0 && ex_mem_rd == id_ex_rt)
        forwardB = 1;
    if (mem_wb_en && mem_wb_rd != 0 && mem_wb_rd == id_ex_rs && !(ex_mem_wb_en && ex_mem_rd == id_ex_rs))
        forwardA = 0;
    if (mem_wb_en && mem_wb_rd != 0 && mem_wb_rd == id_ex_rt && !(ex_mem_wb_en && ex_mem_rd == id_ex_rt))
        forwardB = 0;
end
endmodule

