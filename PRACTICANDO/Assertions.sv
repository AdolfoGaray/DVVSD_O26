module Assertions (
	input logic clk_50,
	input logic a,
	output logic b,
	output logic c
);
// wire clk_100, locked;
// pll pll_inst (
// 		.refclk   (clk_50),   //  refclk.clk
// 		.rst      (0),      //   reset.reset
// 		.outclk_0 (clk_100), // outclk0.clk
// 		.locked   (locked)    //  locked.export
// 	);

// always_ff @(posedge clk_100) begin
// 	b <= ~a;
// end

always_ff @(posedge clk_50) begin
	c <= ~a;
end

endmodule