module controller(input clk,rst,start,co,
		    output reg done, zx,initx,ldx, zt,initt,ldt, zr,initr,ldr, zc,ldc,enc, s);

	reg [2:0] ps, ns;
	parameter [2:0]
	Idle = 0, Initialization = 1, Begin = 2, Mult1 = 3, Mult2 = 4, Add=5;
	always@(ps,co,start)begin
		ns = Idle;
		case(ps)
			Idle:
				ns = (start)? Initialization : Idle;
			Initialization:
				ns = (start)? Initialization : Begin;
			Begin:
				ns = Mult1;
			Mult1:
				ns = Mult2;
			Mult2:
				ns = Add;
			Add:
				ns = (co)? Idle : Mult1;
		endcase
	end

	always@(ps,co,start)begin
	done = 1'b0; zx = 1'b0; initx = 1'b0; ldx = 1'b0; zt = 1'b0; initt = 1'b0; ldt = 1'b0; 
	zr = 1'b0; initr = 1'b0; ldr = 1'b0;  zc = 1'b0; ldc = 1'b0; enc = 1'b0; s = 1'b0;
		case(ps)
			Idle:begin
				zx = 1'b1;
				zt = 1'b1;
				//zr = 1'b1;
				zc = 1'b1;
				done = 1'b1;
			end
			Initialization: begin
				ldx = 1'b1;
			end
			Begin:begin
				initr = 1'b1;
				initt = 1'b1;
			end
			Mult1:begin
				s = 1'b0;
				ldt = 1'b1;
			end
			Mult2:begin
				s = 1'b1;
				ldt = 1'b1;
			end
			Add:begin
				enc =1'b1;
				ldr = 1'b1;
			end
		endcase
	end

	always@(posedge clk,posedge rst)begin
		if(rst == 1'b1)
			ps <= Idle;
		else
			ps <= ns;
	end
endmodule

