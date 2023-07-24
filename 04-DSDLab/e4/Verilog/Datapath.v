module datapath(input clk,rst, zx,initx,ldx, zt,initt,ldt, zr,initr,ldr, zc,ldc,enc, s,
		 input [15:0] x, output co,output [17:0]result);
	wire [15:0] xptwo;
	wire [2:0] c_in = 0;
	wire [15:0] data,m_out,temp_in,ymux;
	wire [15:0] xptwor,temp_out, xr;
	wire [17:0] res_in;
	wire [3:0] adr;

	register regx(clk,rst,zx,initx,ldx,x,xr);

	counter count(clk,rst,zc,ldc,enc,c_in,adr,co);

	LUT lut(adr,data);
	
	mux2to1 mux(xr,data,s,m_out);

	multiplier mult(m_out,temp_out,temp_in);

	register rtemp(clk,rst,zt,initt,ldt,temp_in,temp_out);
	adder add(result,{2'b00,temp_out},res_in);
	
	register18 rres(clk,rst,zr,initr,ldr,res_in,result);
endmodule

