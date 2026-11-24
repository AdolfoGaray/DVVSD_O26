`timescale 1ns/1ps
module Assertions_TB();

logic clk = 1;
always #10 clk = ~clk;

logic reset = 0;
logic a, b, c;

Assertions Assertions_DUT(.clk_50(clk),.a(a),.b(b),.c(c));
property priority_req1;
    @(posedge clk) disable iff (reset)
        (a |=> c);
endproperty

assert property (priority_req1)
    $display("working");
else $error("ERROR: a=1 debe producir c=0 en el siguiente flanco");

initial begin
    a=0;
    #20;
    a=1;
    #100;
    $stop;
end


endmodule