`define   S0      5'b00000
`define   S1      5'b00001
`define   S2      5'b00010
`define   S3      5'b00011
`define   S4      5'b00100
`define   S5      5'b00101
`define   S6      5'b00110
`define   S7      5'b00111
`define   S8      5'b01000
`define   S9      5'b01001
`define   S10     5'b01010
`define   S11     5'b01011
`define   S12     5'b01100
`define   S13     5'b01101
`define   S14     5'b01110
`define   S15     5'b01111
`define   S16     5'b10000
`define   S17     5'b10001
`define   S18     5'b10010
`define   S19     5'b10011
`define   S20     5'b10100
`define   S21     5'b10101
`define   S22     5'b10110
`define   S23     5'b10111


module controller (start, x0, x1, rst, clk, ldY, ldE, clrE, clrA, ldA, shA, ldX, shX, sel, done,addsub);
  input start, x0, x1,rst, clk;
  output ldY, ldE, clrE, clrA, ldA, shA, ldX, shX, sel,addsub, done;
  reg ldY, ldE, clrE, clrA, ldA, shA, ldX, shX, sel,addsub, done;
  
  reg [4:0] ps, ns;
  
  // Sequential part 
  always @(posedge clk)
    if (rst)
      ps <= `S0;
    else
      ps <= ns;

        
  always @(ps or start or x0 or x1)
  begin  
  case (ps)
    `S0:  ns = start ? `S1 : `S0;
    `S1:  ns = `S2;
    `S2:  ns = (x1==0 && x0==1)? `S3 :(x1==1 && x0==0)? `S5: `S4;
    `S3:  ns = `S4;
    `S4:  ns = `S6;
    `S5:  ns = `S4;
    `S6:  ns = (x1==0 && x0==1)? `S7 :(x1==1 && x0==0)? `S9: `S8;
    `S7:  ns = `S8;
    `S8:  ns = `S10;
    `S9:  ns = `S8;
    `S10: ns = (x1==0 && x0==1)? `S11 :(x1==1 && x0==0)? `S13: `S12;
    `S11: ns = `S12 ;
    `S12: ns = `S14;
    `S13: ns = `S12;
    `S14: ns = (x1==0 && x0==1)? `S15 :(x1==1 && x0==0)? `S17: `S16;
    `S15: ns = `S16;
    `S16: ns = `S18;
    `S17: ns = `S16;
    `S18: ns = (x1==0 && x0==1)? `S19 :(x1==1 && x0==0)? `S21: `S20;
    `S19: ns = `S20;
    `S20: ns = `S22;
    `S21: ns = `S20;
    `S22: ns = `S23;
    `S23: ns = `S0;
    endcase
  end
 
  always @(ps)
  begin
    {ldY,addsub,ldA,clrA,shA,ldX,shX,sel,clrE,ldE,done} = 11'b000_0000_0000;
    case (ps)
      `S0: ;
      `S1: {ldX,clrA,clrE} = 3'b111;
      `S2: ldY = 1'b1;
      `S3: {ldA, addsub} = 2'b11;
      `S4: {shX, ldE, shA} = 3'b111;
      `S5: ldA = 1'b1;
      `S6: ;
      `S7: {ldA, addsub} = 2'b11;
      `S8: {shX, ldE, shA} = 3'b111;
      `S9: ldA = 1'b1;
      `S10: ;
      `S11: {ldA, addsub} = 2'b11;
      `S12: {shX, ldE, shA} = 3'b111;
      `S13: ldA = 1'b1;
      `S14: ;
      `S15: {ldA, addsub} = 2'b11;
      `S16: {shX, ldE, shA} = 3'b111;
      `S17: ldA = 1'b1;
      `S18: ;
      `S19: {ldA, addsub} = 2'b11;
      `S20: {shX, ldE, shA} = 3'b111;
      `S21: ldA = 1'b1;
      `S22: done = 1'b1;
      `S23: {sel , done} = 2'b11;
    endcase
  end
  
  
endmodule 
