module SS_oneshot_five_cycles_TB();

logic clk = 1;
always #10 clk = ~clk;

logic rst, in, out;
int errors;

SS_oneshot_five_cycles SS_5(.clk(clk),.rst(rst),.in(in),.out(out));

task check(input int duration);
    if (duration >= 5) begin
        if (out) $display("PASS = Output did turn on %d cycles", duration);
        else begin 
            $display("FAIL = Output did not turn on %d cycles", duration);
            errors = errors + 1;
        end
    end
    else begin
        if (out) begin
            $display("FAIL = Output did turn on %d cycles", duration);
            errors = errors + 1;
        end
        else $display("PASS = Output did not turn on %d cycles", duration);
    end
endtask

task setup_input(input int duration);
    for (int i = 0; i < duration; i = i + 1) begin
        wait(clk);
        in = 1;
        #20;
    end
    wait(clk);
    in = 0;
    #20;
    check(duration);
endtask

initial begin
    rst = 0; in = 0;
    #20;
    rst = 1;
    #20;
    setup_input(3);
    #20;
    setup_input(4);
    #20;
    setup_input(5);
    #20;
    setup_input(6);
    #20;
    if(errors) $display("Errors %d", errors);
    else $display("PASSED :)");
    $stop;
end

endmodule