module one_pulser (
    input clkPB,clk,rst,
    output reg SP
);
    parameter A = 0, B = 1, C = 2;
    reg [1:0] pstate,nstate;
    initial pstate = A;
    always @(pstate, clkPB) begin
        SP = 0;
        case (pstate)
            A: nstate = clkPB ? B : A;
            B: begin
                    nstate = C;
                    SP = 1;
                end
            C: nstate = clkPB ? C : A;
            default: nstate = A;
        endcase
    end
    always @(posedge clk, posedge rst) begin
        if(rst)
            pstate <= A;
        else
            pstate <= nstate;
    end
endmodule

