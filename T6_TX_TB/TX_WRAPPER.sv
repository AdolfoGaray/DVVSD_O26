import parity_pkg::*;

module TX_WRAPPER #(
    parameter baudrate = 5,
    parameter parity = PARITY_ODD
)(
    UART_INTERFACE uart_itf
);

TX #(
    .baudrate(baudrate),
    .parity(parity)
) tx (
    .clk(uart_itf.clk),
    .rst(uart_itf.rst),
    .data_in(uart_itf.data_in),
    .send_bit(uart_itf.send_bit),
    .data_out(uart_itf.data_out),
    .ready(uart_itf.ready)
);

endmodule