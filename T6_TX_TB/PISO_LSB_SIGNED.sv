module PISO_LSB_SIGNED #(parameter DW = 8)(
	input logic clk,
	input logic rst,
    input logic baudrate_enable,
	input logic load_not_shift,
	input logic [DW-1:0] data_in,

	output logic data_out
);
logic [DW:0] register, register_next;

always_comb begin
	if(load_not_shift) register_next = {data_in,1'b0};
	else register_next = {register[DW],register[DW:1]};
end

always_ff @(posedge clk or negedge rst) begin
	if(!rst) register <= '0;
	if(baudrate_enable) begin
		register <= register_next;
	end
end

assign data_out = register[0];

endmodule