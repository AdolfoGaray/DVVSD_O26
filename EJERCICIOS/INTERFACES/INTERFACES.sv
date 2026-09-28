interface MICROBUSERO#(parameter DW = 64);
    //reset
	 logic clk
    logic rst,
 
    // data
    logic [DW - 1 : 0] data0,
    logic [DW - 1 : 0] data1,
    logic square,
 
    // control
    logic start,
    logic ready,
 
    // data
    logic [2 * DW - 1 : 0]result
endinterface: MICROBUSERO

module sm_gm#(
    parameter DW=64
 
)(
    MICROBUSERO a
);
 
signed int internal_result;
 
initial begin
    a.result = {DW{1'b0}};
    a.ready = 1'b1;
    wait(a.rst == 1'b1);
end
 
always begin
    wait(a.rst == 1'b1);
    wait(a.start == 1'b1);
    internal_result = (a.square == 1'b1)? $signed(a.data0) * $signed(a.data0) :
                        $signed(a.data0) * $signed(a.data1);
    @(posedge a.clk);
    a.ready = 1'b0;
    repeat(DW) @(posdege a.clk);
    a.result <= internal_result;
    a.ready <= 1'b1;
end
   
endmodule