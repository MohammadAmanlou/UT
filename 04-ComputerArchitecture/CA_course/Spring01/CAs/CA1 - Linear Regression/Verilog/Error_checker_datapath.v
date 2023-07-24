`include "Register.v"
`include "Adder.v"
`include "Substractor.v"
`include "Multiplier.v"

module Error_checker_datapath(Xi, Yi, B0, B1, ldErr, clk, rst, outErr);
    input [19:0] Xi, Yi, B0, B1;
    input ldErr, clk, rst;
    output [19:0] outErr;

    wire addCo;
    wire [39:0] multOut;
    wire [19:0] addOut, subOut;
    wire [19:0] regErr;

    Multiplier #(20) mult(B1, Xi, multOut);
    Adder #(20) add(multOut[29:10], B0, addOut, addCo);
    Substractor #(20) sub(Yi, addOut, subOut);
    Register #(20) rregErr(.load(ldErr), .ldData(subOut), .out(regErr), .clr(1'b0), .clk(clk), .rst(rst));
    assign outErr = regErr;
endmodule
