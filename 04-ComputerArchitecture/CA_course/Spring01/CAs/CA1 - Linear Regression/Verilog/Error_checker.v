`include "Error_checker_controller.v"
`include "Error_checker_datapath.v"

module Error_checker(Xi, Yi, B0, B1, start, clk, rst, outErr, ready);
    input [19:0] Xi, Yi, B0, B1;
    input start, clk, rst;
    output [19:0] outErr;
    output ready;

    wire ldErr;

    Error_checker_datapath dp(Xi, Yi, B0, B1, ldErr, clk, rst, outErr);
    Error_checker_controller cu(start, clk, rst, ready, ldErr);
endmodule
