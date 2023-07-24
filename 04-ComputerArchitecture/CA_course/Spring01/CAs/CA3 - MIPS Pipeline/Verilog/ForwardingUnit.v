module ForwardingUnit (ExMemRd, MemWBRd, ExMemRegWrite, MemWBRegWrite, IDExRsA, IDExRsB, forwardA, forwardB);
    input [4:0] ExMemRd, MemWBRd, IDExRsA, IDExRsB;
    input ExMemRegWrite, MemWBRegWrite;
    output reg [1:0] forwardA, forwardB;

    always @(ExMemRd, MemWBRd, ExMemRegWrite, MemWBRegWrite, IDExRsA) begin
        forwardA = 2'b00;
        if (ExMemRegWrite == 1'b1 && ExMemRd != 5'd0 && ExMemRd == IDExRsA)
            forwardA = 2'b01;
        else if (MemWBRegWrite == 1'b1 && MemWBRd != 5'd0 && MemWBRd == IDExRsA)
            forwardA = 2'b10;
    end

    always @(ExMemRd, MemWBRd, ExMemRegWrite, MemWBRegWrite, IDExRsB) begin
        forwardB = 2'b00;
        if (ExMemRegWrite == 1'b1 && ExMemRd != 5'd0 && ExMemRd == IDExRsB)
            forwardB = 2'b01;
        else if (MemWBRegWrite == 1'b1 && MemWBRd != 5'd0 && MemWBRd == IDExRsB)
            forwardB = 2'b10;
    end
endmodule
