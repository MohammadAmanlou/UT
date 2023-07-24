`define Idle       4'b0000
`define Init       4'b0001
`define Load       4'b0010
`define LoadCount  4'b0011
`define MeanSig    4'b0100
`define MeanSendXY 4'b0101
`define MeanWait   4'b0110
`define CalcSig    4'b0111
`define CalcSendXY 4'b1000
`define Calc       4'b1001
`define CalcCount  4'b1010
`define CalcWait   4'b1011
`define ErrSig     4'b1100
`define ErrSendXY  4'b1101
`define ErrCount   4'b1110
`define ErrWait    4'b1111

module Data_loader_controller(start, cntCo, meanReady, calcReady, errReady, clk, rst,
                              ready, cntEn, cntClr, memWrite, meanStart, calcStart, errStart, errDone);
    input start, cntCo, meanReady, calcReady, errReady, clk, rst;
    output ready, cntEn, cntClr, memWrite, meanStart, calcStart, errStart, errDone;
    reg ready, cntEn, cntClr, memWrite, meanStart, calcStart, errStart, errDone;

    reg [3:0] ps, ns;

    always @(posedge clk) begin
        if (rst)
            ps <= 4'd0;
        else
            ps <= ns;
    end

    always @(ps or start or cntCo or meanReady or calcReady or errReady) begin
        case (ps)
            `Idle:       ns = start ? `Init : `Idle;
            `Init:       ns = `Load;
            `Load:       ns = `LoadCount;
            `LoadCount:  ns = cntCo ? `MeanSig : `Load;
            `MeanSig:    ns = meanReady ? `MeanSendXY : `MeanSig;
            `MeanSendXY: ns = cntCo ? `CalcSig : `MeanWait;
            `MeanWait:   ns = `MeanSendXY;
            `CalcSig:    ns = calcReady ? `CalcSendXY : `CalcSig;
            `CalcSendXY: ns = `Calc;
            `Calc:       ns = calcReady ? `CalcCount : `Calc;
            `CalcCount:  ns = cntCo ? `ErrSig : `CalcWait;
            `CalcWait:   ns = `Calc;
            `ErrSig:     ns = errReady ? `ErrSendXY : `ErrSig;
            `ErrSendXY:  ns = `ErrCount;
            `ErrCount:   ns = cntCo ? `Idle : `ErrWait;
            `ErrWait:    ns = `ErrSendXY;
            default: ns = `Idle;
        endcase
    end

    always @(ps) begin
        {ready, cntClr, cntEn, memWrite, meanStart, calcStart, errStart, errDone} = 8'd0;
        case (ps)
            `Idle:;
            `Init: {ready, cntClr} = 2'b11;
            `Load: memWrite = 1'b1;
            `LoadCount: cntEn = 1'b1;
            `MeanSig: {cntClr, meanStart} = 2'b11;
            `MeanSendXY: cntEn = 1'b1;
            `MeanWait:;
            `CalcSig: {cntClr, calcStart} = 2'b11;
            `CalcSendXY:;
            `Calc:;
            `CalcCount: cntEn = 1'b1;
            `CalcWait:;
            `ErrSig: {cntClr, errStart} = 2'b11;
            `ErrSendXY:;
            `ErrCount: {cntEn, errDone} = 2'b11;
            `ErrWait:;
            default:;
        endcase
    end
endmodule
