module TX_WRAPPER #(
    parameter baudrate = 5,
    parameter parity = PARITY_ODD
)(
    interface UART_INTERFACE
);

TX tx #(
    parameter baudrate = 5,
    parameter parity = PARITY_NONE
)(
    .clk(UART_INTERFACE.clk),
    .rst(UART_INTERFACE.rst),
    .data_in(UART_INTERFACE.data_in),
    .send_bit(UART_INTERFACE.send_bit),
    .data_out(UART_INTERFACE.data_out),
    .ready(UART_INTERFACE.ready)
);

endmodule