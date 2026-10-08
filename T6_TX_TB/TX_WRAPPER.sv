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
    .clk(UART_INTERFACE.clk),
    .rst(UART_INTERFACE.rst),
    .data_in(UART_INTERFACE.data_in),
    .send_bit(UART_INTERFACE.send_bit),
    .data_out(UART_INTERFACE.data_out),
    .ready(UART_INTERFACE.ready)
);

endmodule