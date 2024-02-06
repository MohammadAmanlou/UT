module buffer4x4 (
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

module Buffer_16 (
  input [127:0] data_in,
  input we, clk,
  output reg [127:0] data_out
);

reg [127:0] data ;
integer i;
always@(posedge clk)begin
  if (we) begin
    data <= data_in;
  end
end

assign data_out = data;

endmodule



module Buffer_16x4 (
  input [31:0] data_in,
  input we, clk, shift_up,
  input [8:0] address,
  output reg [127:0] data_out
);


wire [31:0] temp;
assign temp = {data_in[7:0],data_in[15:8],data_in[23:16],data_in[31:24]};


reg [127:0] data [3:0];
integer i ;
always @(posedge clk) begin
  if (shift_up) begin
    for (i = 0; i < 3; i = i+1) begin
      data[i] <= data[i + 1];
    end
  end

  if (we) begin
    for (i = 0; i < 8; i = i+1) begin
      data[address[5:4]][address[3:0] * 8 + i] <= temp[0 + i];
      data[address[5:4]][address[3:0] * 8 + i + 8] <= temp[ 8 + i];
      data[address[5:4]][address[3:0] * 8 + i + 16] <= temp[16 + i];
      data[address[5:4]][address[3:0] * 8 + i + 24] <= temp[24+i];
    end
  end
end

always @(*) begin
  for (i =0 ; i < 32 ; i= i +1)begin
	data_out[i] = data[0][8*address+i];
	data_out[i + 32] = data[1][8*address+i];
	data_out[i + 64] = data[2][8*address+i];
	data_out[i + 96] = data[3][8*address+i];
  end

end

endmodule
