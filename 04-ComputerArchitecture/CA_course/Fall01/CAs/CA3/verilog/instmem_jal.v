
module instmem_jal (adr, d_out);
  input [31:0] adr;
  output [31:0] d_out;
  
  reg [7:0] mem[0:65535];
  
  initial
  begin
    {mem[3], mem[2], mem[1], mem[0]}     = {6'h09, 5'd0, 5'd1, 16'd16};      //addi R1, R0, 3
    {mem[7], mem[6], mem[5], mem[4]}     = {6'h09, 5'd0, 5'd2, 16'd6};       //addi R2, R0, 6
    {mem[11], mem[10], mem[9], mem[8]}   = {6'h09, 5'd0, 5'd2, 16'd5};       //addi R2, R0, 5
    {mem[15], mem[14], mem[13], mem[12]} = {6'b000011,  26'd6};              //jump here and save mem[16] in R31
    {mem[19], mem[18], mem[17], mem[16]} = {6'h09, 5'd0, 5'd2, 16'd7};       //addi R2, R0, 7  //ignore
    {mem[23], mem[22], mem[21], mem[20]} = {6'h09, 5'd0, 5'd2, 16'd8};       //addi R2, R0, 8 //ignore
    {mem[27], mem[26], mem[25], mem[24]} = {6'h09, 5'd0, 5'd2, 16'd9};       //addi R2, R0, 9 //jump here 
    {mem[31], mem[30], mem[29], mem[28]} = {6'h09, 5'd31, 5'd2, 16'd0};      //addi R2, R31, 0 //see what saved in R31
    {mem[35], mem[34], mem[33], mem[32]} = {6'h2B, 5'd0, 5'd2, 16'd2000};    //SW R2, 2000(R0)
  end
  
  assign d_out = {mem[adr[15:0]+3], mem[adr[15:0]+2], mem[adr[15:0]+1], mem[adr[15:0]]};
  
endmodule




