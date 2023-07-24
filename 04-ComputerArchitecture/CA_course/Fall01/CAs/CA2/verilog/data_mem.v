module data_mem (adr, d_in, mrd, mwr, clk, d_out);
  input [31:0] adr;
  input [31:0] d_in;
  input mrd, mwr, clk;
  output [31:0] d_out;
  
  reg [7:0] mem[0:65535];
  
  initial
  begin
    {mem[103], mem[102], mem[101], mem[100]} = 32'd0;
    {mem[107], mem[106], mem[105], mem[104]} = 32'd1;
    {mem[111], mem[110], mem[109], mem[108]} = 32'd2;
    {mem[115], mem[114], mem[113], mem[112]} = 32'd3;
    {mem[119], mem[118], mem[117], mem[116]} = 32'd4;    
    {mem[123], mem[122], mem[121], mem[120]} = 32'd5;
  end
  
  
  // The following initial block is for TEST PURPOSE ONLY 
  initial
    #500 $display("The content of mem[200] = %d", {mem[203], mem[202], mem[201], mem[200]});
  
  always @(posedge clk)
    if (mwr==1'b1)
      {mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} = d_in;
  
  assign d_out = (mrd==1'b1) ? {mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} : 32'd0;
  
endmodule   
