module instmem_slti (adr, d_out);
  input [31:0] adr;
  output [31:0] d_out;
  reg [7:0] mem[0:65535];

  initial

  begin


    {mem[3], mem[2], mem[1], mem[0]}     = {6'h23, 5'd0, 5'd3, 16'd1000};   // LW R3 1000(R0)
    {mem[7], mem[6], mem[5], mem[4]}     = {6'b001010, 5'd3, 5'd1, 16'd20}; //SLTi R1, R3, 20       
    {mem[11], mem[10], mem[9], mem[8]}   = {6'b001010, 5'd3, 5'd2, 16'd10}; //SLTi  R2, R3, 10
    {mem[15], mem[14], mem[13], mem[12]} = {6'h2B, 5'd0, 5'd1, 16'd2000};   //SW R1, 2000(R0)
    {mem[19], mem[18], mem[17], mem[16]} = {6'h2B, 5'd0, 5'd2, 16'd2004};   //SW R2, 2004(R0) 
    {mem[23], mem[22], mem[21], mem[20]} = {6'h2B, 5'd9, 5'd3, 16'd1000};   //SW R3 1000(R9)
  end
  
  assign d_out = {mem[adr[15:0]+3], mem[adr[15:0]+2], mem[adr[15:0]+1], mem[adr[15:0]]};
  
endmodule
