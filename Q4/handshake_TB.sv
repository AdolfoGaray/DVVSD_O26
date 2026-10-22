`timescale 1ns/1ps

module handshake_TB;

logic clkA = 0;
logic clkB = 0;
logic rst_n = 0;
logic signal_i = 0;
logic signal_o;
logic busy_o;

handshake shakehand_DUT(.clkA(clkA),.clkB(clkB),.rst_n(rst_n),.signal_i(signal_i),.signal_o(signal_o),.busy_o(busy_o));

always #2 clkA = ~clkA;
always #7 clkB = ~clkB;

initial begin
    #2
    rst_n = 1;
    #2
    wait(clkA == 1'b1);
    signal_i = 1;
    wait(clkA == 1'b0);
    wait(clkA == 1'b1);
    signal_i = 0;
end

endmodule