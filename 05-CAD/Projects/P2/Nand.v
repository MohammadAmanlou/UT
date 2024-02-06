module NAnd(input a , b , output out );
	wire temp;
	And an(.a(a) , .b(b) , .out(temp) );
	Not n(.a(temp) , .out(out));
endmodule
