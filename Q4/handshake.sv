module handshake (
    input clkA,
    input clkB,
    input rst_n,
    input signal_i,
    output signal_o,
    output busy_o
);

logic data_clean_oneShot, data_o_doubleFlop, data_o_flopA, next_data_o_flopA;

always_comb begin
    next_data_o_flopA = (signal_i) ? 1'b1 : ((data_o_doubleFlop) ? 1'b0 : data_o_flopA);
end

always_ff @(posedge clkA, negedge rst_n) begin
    if(!rst_n) begin
        data_o_flopA <= '0;
    end
    else begin
        data_o_flopA <= next_data_o_flopA;
    end
end

DoubleFlop doubleFlop(.clk(clkA),.rst_n(rst_n),.data_i(data_clean_oneShot),.data_o(data_o_doubleFlop));
OneShot oneShot(.clk(clkB),.rst_n(rst_n),.data_i(data_o_flopA),.data_o(signal_o),.data_clean_oneShot(data_clean_oneShot));

assign busy_o = data_o_doubleFlop | data_o_flopA;

endmodule


module DoubleFlop(
    input clk, // Destination clock
    input rst_n,
    input data_i,
    output data_o
);

logic meta_stable_data, clean_data;

always_ff@(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        {clean_data, meta_stable_data} <= 2'b00;
    end
    else begin
        {clean_data, meta_stable_data} <= {meta_stable_data, data_i};
    end
end

assign data_o = clean_data;

endmodule

module OneShot(
    input clk, // Destination clock
    input rst_n,
    input data_i,
    output data_o,
    output data_clean_oneShot
);

logic meta_stable_data, clean_data, delayed_data;

always_ff@(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        {delayed_data, clean_data, meta_stable_data} <= 3'b000;
    end
    else begin
        {delayed_data, clean_data, meta_stable_data} <= {clean_data, meta_stable_data, data_i};
    end
end

assign data_clean_oneShot = clean_data;
assign data_o = ~delayed_data & clean_data;


endmodule