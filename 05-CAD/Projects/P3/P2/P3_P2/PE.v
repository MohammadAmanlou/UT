module PE (
    input wire clk,
    input wire done,
    input wire [31:0] bufferInput,
    input wire [15:0] kernelFilter_en,
    input wire [3:0] mux_sel,
    input wire [7:0] mac2_input,
    input wire mac_en,
    input wire mac_rst,
    input wire shiftReg_en,
    input wire counter_rst,
    input wire counter_en,
    input wire ofm_we,
    input wire [31:0] ofm_addr,
    input wire [31:0] number,
    output wire ofm_cout
);

    // Internal signal declarations
    wire [7:0] kernelFilter_out [0:15];
    wire [7:0] mux16to1_out;
    wire [7:0] mac_out;
    wire [31:0] shiftReg_out;

    // Instance: filterBuffer
    filterBuffer KernelBuffer (
        .clk(clk),
        .in(bufferInput),
        .en(kernelFilter_en),
        .out(kernelFilter_out)
    );

    // Instance: mux16to1
    mux16to1 Mux (
        .sel(mux_sel),
        .in(kernelFilter_out),
        .out(mux16to1_out)
    );

    // Instance: mac
    mac MacEngine (
        .a(mux16to1_out),
        .b(mac2_input),
        .en(mac_en),
        .rst(mac_rst),
        .clk(clk),
        .out(mac_out)
    );

    // Instance: shiftRegister
    shiftRegister ShiftReg (
        .clk(clk),
        .en(shiftReg_en),
        .in(mac_out),
        .out(shiftReg_out),
        .rst(1'b0)
    );

    // Instance: counter
    counter #(.N(4), .M(2)) myCounter (
        .clk(clk),
        .rst(counter_rst),
        .en(counter_en),
        .cout(ofm_cout),
	.count()
    );

    // Instance: OFM
    OFM OutputFeatureMap (
        .clk(clk),
        .adr(ofm_addr),
        .in(shiftReg_out),
        .we(ofm_we),
        .done(done),
        .number(number)
    );

endmodule


module PU (
    input wire clk,
    input wire [31:0] bufferInput,
    input wire [15:0] kernelFilter_en,
    input wire [3:0] mux_sel,
    input wire [7:0] mac2_input,
    input wire mac_en,
    input wire mac_rst,
    output [12:0] mac_out
);

    // Internal signal declarations
    wire [7:0] kernelFilter_out [0:15];
    wire [7:0] mux16to1_out;
    wire [31:0] shiftReg_out;

    // Instance: filterBuffer
    filterBuffer KernelBuffer (
        .clk(clk),
        .in(bufferInput),
        .en(kernelFilter_en),
        .out(kernelFilter_out)
    );

    // Instance: mux16to1
    mux16to1 Mux (
        .sel(mux_sel),
        .in(kernelFilter_out),
        .out(mux16to1_out)
    );

    // Instance: mac
    mac2 MacEngine (
        .a(mux16to1_out),
        .b(mac2_input),
        .en(mac_en),
        .rst(mac_rst),
        .clk(clk),
        .out(mac_out)
    );

endmodule


module PE2 (
    input wire clk,
    input wire done,
    input wire [31:0] bufferInput1,bufferInput2,bufferInput3,bufferInput4,
    input wire [15:0] kernelFilter_en,
    input wire [3:0] mux_sel,
    input wire [7:0] mac2_input1,mac2_input2,mac2_input3,mac2_input4,
    input wire mac_en,
    input wire mac_rst,
    input wire shiftReg_en,
    input wire counter_rst,
    input wire counter_en,
    input wire ofm_we,
    input wire [31:0] ofm_addr,
    input wire [31:0] number,
    output wire ofm_cout
);
    wire [12:0] mac_out1 , mac_out2, mac_out3, mac_out4;
    PU pu1(.clk(clk),.bufferInput(bufferInput1),.kernelFilter_en(kernelFilter_en),.mux_sel(mux_sel),
	.mac2_input(mac2_input1),.mac_en(mac_en),.mac_rst(mac_rst),.mac_out(mac_out1));
    PU pu2(.clk(clk),.bufferInput(bufferInput2),.kernelFilter_en(kernelFilter_en),.mux_sel(mux_sel),
	.mac2_input(mac2_input2),.mac_en(mac_en),.mac_rst(mac_rst),.mac_out(mac_out2));
    PU pu3(.clk(clk),.bufferInput(bufferInput3),.kernelFilter_en(kernelFilter_en),.mux_sel(mux_sel),
	.mac2_input(mac2_input3),.mac_en(mac_en),.mac_rst(mac_rst),.mac_out(mac_out3));
    PU pu4(.clk(clk),.bufferInput(bufferInput4),.kernelFilter_en(kernelFilter_en),.mux_sel(mux_sel),
	.mac2_input(mac2_input4),.mac_en(mac_en),.mac_rst(mac_rst),.mac_out(mac_out4));
   wire[14:0] sum_macs ;
   wire[31:0] shiftReg_out;
   assign sum_macs = mac_out1 + mac_out2 +  mac_out3 + mac_out4;
    

    // Instance: shiftRegister
    shiftRegister ShiftReg (
        .clk(clk),
        .en(shiftReg_en),
        .in(sum_macs[11:4]),
        .out(shiftReg_out),
        .rst(1'b0)
    );

    // Instance: counter
    counter #(.N(4), .M(2)) myCounter (
        .clk(clk),
        .rst(counter_rst),
        .en(counter_en),
        .cout(ofm_cout),
	.count()
    );

    // Instance: OFM
    OFM2 OutputFeatureMap (
        .clk(clk),
        .adr(ofm_addr),
        .in(shiftReg_out),
        .we(ofm_we),
        .done(done),
        .number(number)
    );

endmodule


////everything is OK!