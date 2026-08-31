module top #(
//	parameter [7:0] BINARY = 8'd000
//	parameter [7:0] BINARY = 8'd058
//	parameter [7:0] BINARY = 8'd097
//	parameter [7:0] BINARY = 8'd123
//	parameter [7:0] BINARY = 8'd146
//	parameter [7:0] BINARY = 8'd200
	parameter [7:0] BINARY = 8'd255
)(
	output logic [6:0] segments0,
	output logic [6:0] segments1,
	output logic [6:0] segments2
);

logic [3:0] bcd0, bcd1, bcd2;

BCD bcd(.binary(BINARY),.BCD0(bcd0),.BCD1(bcd1),.BCD2(bcd2));
Segments segs0(.num(bcd0),.segs(segments2));
Segments segs1(.num(bcd1),.segs(segments1));
Segments segs2(.num(bcd2),.segs(segments0));

endmodule
`timescale 1ns/1ps