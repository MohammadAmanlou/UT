module Reg (
    input clock, reset, load,
    input [1:0] in,
    output [1:0] out
);
    reg [1:0] register;
    always @(posedge clock) begin
        if(reset)
            register = 0;
        else if(load)
            register = in;
        else
            register = register;
        
    end

    assign out = register;


endmodule