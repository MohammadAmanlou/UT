module ShiftReg (
    input clock, reset, load, shiftEn,
    input [15:0] in,
    output [15:0] out
);

reg [15:0] register;

always @(posedge clock) begin
    if(reset)
        register = 16'b0;
    else if(load)
        register = in;
    else if(shiftEn)
        register = register << 1;
    else
        register = register;
end

assign out = register;
    
endmodule