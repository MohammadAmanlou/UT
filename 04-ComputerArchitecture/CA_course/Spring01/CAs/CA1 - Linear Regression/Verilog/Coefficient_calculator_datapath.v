`include "Register.v"
`include "Mux.v"
`include "Adder.v"
`include "Substractor.v"
`include "Multiplier.v"
`include "Divider.v"

module Coefficient_calculator_datapath(inX, inY, clk, rst, ldX, ldY,
                                       clrSumX, clrSumY, ldSumX, ldSumY,
                                       divideXbarY, ldMeanX, ldMeanY,
                                       subForYiOrB0, multForXiOrB0,
                                       clrSSxx, clrSSxy, ldSSxx, ldSSxy,
                                       ldB0, ldB1, outB0, outB1);
    input [19:0] inX, inY;
    input clk, rst, ldX, ldY,
          clrSumX, clrSumY, ldSumX, ldSumY,
          divideXbarY, ldMeanX, ldMeanY,
          subForYiOrB0, multForXiOrB0,
          clrSSxx, clrSSxy, ldSSxx, ldSSxy,
          ldB0, ldB1;
    output [19:0] outB0, outB1;

    wire [19:0] regX, regY, meanX, meanY, regB0, regB1;
    wire [27:0] sumX, sumY;
    wire [47:0] regSSxx, regSSxy;

    wire [27:0] sumAdderXOut, sumAdderYOut, meanDivideWire, meanDividerOut;
    wire [19:0] xiSubMeanX, yiSubMeanYorB0,
                subEntryYiorMeanYw, subEntryMeanYorB0w,
                multEntryXisubOrMeanXw, multEntryXisubOrB1w;
    wire [39:0] partSSxy, partSSxxOrB1MeanX;
    wire [47:0] addSSxxOut, addSSxyOut;
    wire [57:0] divideOutB1;
    wire sumAdderXco, sumAdderYco, addSSxxCo, addSSxyCo;

    Register #(20) rRegX (.load(ldX),     .ldData(inX),                  .out(regX), .clr(1'b0), .clk(clk), .rst(rst));
    Register #(20) rRegY (.load(ldY),     .ldData(inY),                  .out(regY), .clr(1'b0), .clk(clk), .rst(rst));
    Register #(28) rSumX (.load(ldSumX),  .ldData(sumAdderXOut),         .out(sumX), .clr(clrSumX), .clk(clk), .rst(rst));
    Register #(28) rSumY (.load(ldSumY),  .ldData(sumAdderYOut),         .out(sumY), .clr(clrSumY), .clk(clk), .rst(rst));
    Register #(20) rMeanX(.load(ldMeanX), .ldData(meanDividerOut[19:0]), .out(meanX), .clr(1'b0), .clk(clk), .rst(rst));
    Register #(20) rMeanY(.load(ldMeanY), .ldData(meanDividerOut[19:0]), .out(meanY), .clr(1'b0), .clk(clk), .rst(rst));
    Register #(20) rRegB0(.load(ldB0),    .ldData(yiSubMeanYorB0),       .out(regB0), .clr(1'b0), .clk(clk), .rst(rst));
    Register #(20) rRegB1(.load(ldB1),    .ldData(divideOutB1[19:0]),    .out(regB1), .clr(1'b0), .clk(clk), .rst(rst));
    Register #(48) rSSxs (.load(ldSSxx),  .ldData(addSSxxOut),           .out(regSSxx), .clr(clrSSxx), .clk(clk), .rst(rst));
    Register #(48) rSSxy (.load(ldSSxy),  .ldData(addSSxyOut),           .out(regSSxy), .clr(clrSSxy), .clk(clk), .rst(rst));

    Adder    #(28) sumAdderX({{8{regX[19]}}, regX}, sumX, sumAdderXOut, sumAdderXco);
    Adder    #(28) sumAdderY({{8{regY[19]}}, regY}, sumY, sumAdderYOut, sumAdderYco);
    Mux_2to1 #(28) meanDivideXorY(.a0(sumX), .a1(sumY), .sel(divideXbarY), .out(meanDivideWire));
    Divider  #(28) meanDivider(meanDivideWire, 28'd150, meanDividerOut);

    Substractor #(20) subXiMeanX(regX, meanX, xiSubMeanX);
    Mux_2to1    #(20) subEntryYiorMeanY(.a0(regY), .a1(meanY), .sel(subForYiOrB0), .out(subEntryYiorMeanYw));
    Mux_2to1    #(20) subEntryMeanYorB0(.a0(meanY), .a1(partSSxxOrB1MeanX[29:10]), .sel(subForYiOrB0), .out(subEntryMeanYorB0w));
    Substractor #(20) subYiMeanYorB0(subEntryYiorMeanYw, subEntryMeanYorB0w, yiSubMeanYorB0);

    Mux_2to1   #(20) multEntryXisubOrMeanX(.a0(xiSubMeanX), .a1(meanX), .sel(multForXiOrB0), .out(multEntryXisubOrMeanXw));
    Mux_2to1   #(20) multEntryXisubOrB1(.a0(xiSubMeanX), .a1(divideOutB1[19:0]), .sel(multForXiOrB0), .out(multEntryXisubOrB1w));
    Multiplier #(20) mult(multEntryXisubOrMeanXw, multEntryXisubOrB1w, partSSxxOrB1MeanX);
    Multiplier #(20) multSSxy(xiSubMeanX, yiSubMeanYorB0, partSSxy);

    Adder   #(48) addSSxx({{8{partSSxxOrB1MeanX[39]}}, partSSxxOrB1MeanX}, regSSxx, addSSxxOut, addSSxxCo);
    Adder   #(48) addSSxy({{8{partSSxy[39]}}, partSSxy}, regSSxy, addSSxyOut, addSSxyCo);
    Divider #(58) divideForB1({regSSxy, 10'd0}, {{10{regSSxx[47]}}, regSSxx}, divideOutB1);

    assign outB0 = regB0;
    assign outB1 = regB1;
endmodule
