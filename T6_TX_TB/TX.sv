import parity_pkg::*;

module TX #(
    parameter baudrate = 5,
    parameter parity = PARITY_ODD
)(
    input logic clk,
    input logic rst,
    input logic [7:0] data_in,
    input logic send_bit,

    output logic data_out,
    output logic ready
);

logic baudrate_enable, parity_enable, load_not_shift, ready, data_bit;
logic [1:0] output_selector;

CLK_BAUDRATE #(.baudrate(baudrate)) clk_baudrate(
    .clk(clk),
    .send_bit(send_bit),
    .baudrate_enable(baudrate_enable)
);
PARITY_GETTER #(.parity(parity)) parity_getter(
    .data_in(data_in),
    .parity_enable(parity_enable),
    .parity_bit(parity_bit)
);
TX_FSM tx_fsm(
    .clk(clk),
    .rst(rst),
    .send_bit(send_bit),
    .baudrate_enable(baudrate_enable),
    .parity_enable(parity_enable),
    .load_not_shift(load_not_shift),
    .output_selector(output_selector),
    .ready(ready)
);
PISO_LSB_SIGNED piso(
    .clk(clk),
    .rst(rst),
    .baudrate_enable(baudrate_enable),
    .load_not_shift(load_not_shift),
    .data_in(data_in),
    .data_out(data_bit)
);
MUX4A1 mux4a1(
    .data_bit(data_bit),
    .parity_bit(parity_bit),
    .output_selector(output_selector),
    .data_out(data_out)
);

endmodule