`timescale 1ns/1ps

module FIFO_TB;

parameter DW = 8;
parameter DEPTH = 16;

logic clk = 0;
logic rst, push, pop, full, empty;
logic [DW-1:0] data_in, data_out, data_out_GM;
logic [DW:0] errors = 0;

logic [DW-1:0] queue [$:(DEPTH-1)]; //Golden Model
FIFO #(.DW(DW),.DEPTH(DEPTH)) fifo (.clk(clk),.rst(rst),.data_in(data_in),.push(push),.pop(pop),.data_out(data_out),.full(full),.empty(empty));

always #1 clk = ~clk;

task PUSH_POP(input logic [DW:0] data);
    data_in = data;
    wait(clk);
    push = 1;
    pop = 1;
    data_out_GM = queue.pop_front();
    queue.push_back(data);
    #2;
    push = 0;
    pop = 0;
    #2;
endtask

task PUSH(input logic [DW:0] data);
    data_in = data;
    wait(clk);
    push = 1;
    queue.push_back(data);
    #2;
    push = 0;
    #2;
endtask

task POP();
    wait(clk);
    pop = 1;
    data_out_GM = queue.pop_front();
    #2;
    pop = 0;
    #2;
endtask

task CHECK();
    if(data_out == data_out_GM) begin
        $display("PASS | expected=%b got=%b",data_out_GM, data_out);
    end
    else begin
        $display("FAIL | expected=%b got=%b",data_out_GM, data_out);
        errors++;
    end
endtask

initial begin
    rst = 0;
    #2;
    rst = 1;
    #2;
    PUSH(8'b01010101);
    POP(); 
    CHECK(); //Primer chequeo
    for(int i=0; i<=16; i++) begin //17 pushes para llenar y verificar full push
        PUSH(i);//*10+i);
    end
    for(int i=0; i<=16; i++) begin //17 pops para vaciar y verificar empty pop
        POP();
        CHECK();
    end
    PUSH(8'b11111111);
    for(int i=0; i<=2**DW; i++) begin //Checar todas las posibilidades
        PUSH_POP(i);
        CHECK();
    end
    $display("ERRORS: %b", errors);
end

endmodule