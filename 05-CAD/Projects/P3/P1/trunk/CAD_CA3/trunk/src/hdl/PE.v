module PE (input clk,input [31:0] bufferInput, input buf4x4_we , counter_en,input [3:0]  sel,
	input [7:0] mac2Input,input Mac_en,Mac_rst , counter_rst,wr,input [8:0] addr,
	output counter_cout,input done,input [31:0] number ,input [8:0] buf_addr ,input shift_rst , shift_write , shif_shift );

    wire [127:0] bufferOut ;
    wire [7:0] mac1Input;
    wire [7:0] macOut;
    wire [31:0] shiftRegOut;

buffer4x4 kernel(.data_in(bufferInput),.we(buf4x4_we),.clk(clk),.address(buf_addr),.data_out(bufferOut));
mux_16to1 mux16_1(.data_inputs(bufferOut),.select(sel),.out(mac1Input));
MAC mac(.clk(clk),.reset(Mac_rst),.a(mac1Input),.b(mac2Input),.enable(Mac_en),.result(macOut));
shift_register32 shift_reg(.clk(clk),.reset(shift_rst),.shift(shif_shift),.write(shift_write),.data_in(macOut),.data_out(shiftRegOut));
counter #(.N(4) , .M(2)) Counter(.clk(clk),.rst(counter_rst),.en(counter_en),.cout(counter_cout),.count());
OFM ofm(.clk(clk),.address(addr),.wrData(shiftRegOut),.wr(wr),.done(done),.number(number));
endmodule