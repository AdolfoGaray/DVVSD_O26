module CLK_BAUDRATE #(
    parameter baudrate = 5
)(
    input logic clk,
    input logic send_bit,

    output logic baudrate_enable
);

logic [$clog2(baudrate)-1:0] counter;

always_ff @(negedge clk or posedge send_bit) begin
    if(send_bit) counter <= 1'b0;
    if(counter >= baudrate) begin
        baudrate_enable <= 1'b1;
        counter <= 1'b0;
    end else begin
        baudrate_enable <= 1'b0;
        counter <= counter + 1'b1;        
    end
end

endmodule