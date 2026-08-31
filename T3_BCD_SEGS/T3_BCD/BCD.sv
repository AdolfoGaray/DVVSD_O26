module BCD (
	input logic [7:0] binary,
	
	output logic [3:0] BCD0,
	output logic [3:0] BCD1,
	output logic [3:0] BCD2
);

logic [19:0] w1,w2,w3,w4,w5,w6,w7,result;

BCD_STEP bcd0 (.stepIn({12'b0,binary}),.stepOut(w1));
BCD_STEP bcd1 (.stepIn(w1),.stepOut(w2));
BCD_STEP bcd2 (.stepIn(w2),.stepOut(w3));
BCD_STEP bcd3 (.stepIn(w3),.stepOut(w4));
BCD_STEP bcd4 (.stepIn(w4),.stepOut(w5));
BCD_STEP bcd5 (.stepIn(w5),.stepOut(w6));
BCD_STEP bcd6 (.stepIn(w6),.stepOut(w7));
BCD_STEP bcd7 (.stepIn(w7),.stepOut(result));

assign BCD0 = result[11:8];
assign BCD1 = result[15:12];
assign BCD2 = result[19:16];

endmodule

module BCD_STEP (
	input logic [19:0] stepIn,
	
	output logic [19:0] stepOut
);

logic [11:0] preShiftAdd3;

assign preShiftAdd3[3:0] = (stepIn[11:8] >= 4'd5) ? 4'd3 : 4'b0;
assign preShiftAdd3[7:4] = (stepIn[15:12] >= 4'd5) ? 4'd3 : 4'b0;
assign preShiftAdd3[11:8] = (stepIn[19:16] >= 4'd5) ? 4'd3 : 4'b0;

assign stepOut = (stepIn + {preShiftAdd3,8'b0}) << 1;

endmodule