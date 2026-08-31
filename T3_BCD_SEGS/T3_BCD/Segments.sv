module Segments (
	input logic [3:0] num,
	output logic [6:0] segs
);

always_comb begin
	case(num)
		4'b0000: segs = 7'b1000000;
		4'b0001: segs = 7'b1111001;
		4'b0010: segs = 7'b0100100;
		4'b0011: segs = 7'b0110000;
		4'b0100: segs = 7'b0011001;
		4'b0101: segs = 7'b0010010;
		4'b0110: segs = 7'b0000010;
		4'b0111: segs = 7'b1111000;
		4'b1000: segs = 7'b0000000;
		4'b1001: segs = 7'b0011000;
		4'b1010: segs = 7'b0001000;
		4'b1011: segs = 7'b0000011;
		4'b1100: segs = 7'b0100111;
		4'b1101: segs = 7'b0100001;
		4'b1110: segs = 7'b0000110;
		4'b1111: segs = 7'b0001110;
		default: segs = 7'b0000000;
	endcase
end

endmodule