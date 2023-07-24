module HazardUnit (IFIDRs1, IFIDRs2, IDExRt, IDExMemRead, PcWrite, IFIDLoad, IDExFlush);
    input [4:0] IFIDRs1, IFIDRs2, IDExRt;
    input IDExMemRead;
    output reg PcWrite, IFIDLoad, IDExFlush;

    always @(IFIDRs1, IFIDRs2, IDExRt, IDExMemRead) begin
        {PcWrite, IFIDLoad, IDExFlush} = 3'b110;
        if (IDExMemRead == 1'b1 && (IDExRt == IFIDRs1 || IDExRt == IFIDRs2) && IDExRt != 5'd0)
            {PcWrite, IFIDLoad, IDExFlush} = 3'b001;
    end
endmodule
