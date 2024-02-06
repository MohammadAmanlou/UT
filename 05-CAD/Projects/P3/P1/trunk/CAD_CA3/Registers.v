module shift_register32 (
  input clk,
  input reset,shift,write,
  input [7:0] data_in,
  output [31:0] data_out
);

  reg [31:0] register;

  always @(posedge clk ) begin
    if (reset) begin
      register <= 0;
   end else if(write) begin
      register <= { register[31:8] , data_in }; // Shift in new data
    end else if(shift) begin
      register <= { register[23:0] , 8'b0}; // Shift in new data
    end
  end

  assign data_out = register;

endmodule


module register (
  input clk,
  input rst,jmp,
  input [8:0] data_in, default_val , 
  output reg [8:0] data_out
);

  always @(posedge clk) begin
    if (rst) begin
      data_out <= default_val;
    end else if(jmp === 1) begin
      data_out <= 48;
    end else begin
	data_out <= data_in;
     end
  end

endmodule

