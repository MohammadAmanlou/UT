module Buffer_44 (
  input [31:0] data_in,
  input we, clk,
  input [8:0] address,
  output reg [127:0] data_out
);

wire [31:0] temp;
assign temp = {data_in[7:0],data_in[15:8],data_in[23:16],data_in[31:24]};


reg [127:0] data ;
integer i;
always@(posedge clk)begin
  if (we) begin
    for(i =0 ; i <32 ; i=i+1)begin
        data[address + i] <= temp[i];
    end
  end
end

assign data_out = data;

endmodule