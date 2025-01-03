module PE (clk,bufferInput,en1,sel,mac2Input,en2,rst2,en3,en4,rst4,wr,addr,cout4,done,number);
    input clk;
    input en2,en3,en4;
    input rst2,rst4;
    input wr;
    input done;
    input [31:0] number;
    input [3:0] sel;
    input [31:0] addr;
    input [7:0] bufferInput[0:3];
    input [15:0] en1;
    input [7:0] mac2Input;
    wire [7:0] bufferOut [0:15];
    wire [7:0] mac1Input;
    wire [7:0] macOut;
	wire [7:0] shiftRegOut[3:0];
    output cout4;
    filterBuffer    Kernel(.clk(clk),.dataIn(bufferInput),.en(en1),.dataOut(bufferOut));
    mux16to1        Mux_16_1(.sel(sel),.in(bufferOut),.out(mac1Input));
    mac             Mac(.a(mac1Input), .b(mac2Input), .en(en2), .rst(rst2), .clk(clk), .out(macOut));
    shiftRegister   ShiftReg(.clk(clk),.en(en3),.dataIn(macOut),.dataOut(shiftRegOut));
    counter4        myCounter(.clk(clk),.rst(rst4),.en(en4),.cout(cout4),.count());
    OFM             ofm(.clk(clk),.address(addr),.wrData(shiftRegOut),.wr(wr),.done(done),.number(number));
endmodule