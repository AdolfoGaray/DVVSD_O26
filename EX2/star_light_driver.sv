class star_light_driver;

virtual star_light_itf driver_itf;

function new(virtual star_light_itf.driver d_itf);
    driver_itf = d_itf;
endfunction

task delay(input int cycles);
    for (int i = 0; i < cycles; i = i + 1) begin
        wait(clk);
        wait(!clk);
    end
endtask

task initial_condition();
    d_itf.switch_0_i = 0;
    d_itf.switch_1_i = 0;
    d_itf.switch_2_i = 0;
endtask

task change_1a();
    delay(1);
    d_itf.switch_0_i = ~d_itf.switch_0_i;
    d_itf.switch_1_i = d_itf.switch_1_i;
    d_itf.switch_2_i = d_itf.switch_2_i;
    delay(2);
endtask
task change_1b();
    delay(1);
    d_itf.switch_0_i = d_itf.switch_0_i;
    d_itf.switch_1_i = ~d_itf.switch_1_i;
    d_itf.switch_2_i = d_itf.switch_2_i;
    delay(2);
endtask
task change_1c();
    delay(1);
    d_itf.switch_0_i = d_itf.switch_0_i;
    d_itf.switch_1_i = d_itf.switch_1_i;
    d_itf.switch_2_i = ~d_itf.switch_2_i;
    delay(2);
endtask

task change_2a();
    delay(1);
    d_itf.switch_0_i = ~d_itf.switch_0_i;
    d_itf.switch_1_i = ~d_itf.switch_1_i;
    d_itf.switch_2_i = d_itf.switch_2_i;
    delay(2);
endtask
task change_2b();
    delay(1);
    d_itf.switch_0_i = d_itf.switch_0_i;
    d_itf.switch_1_i = ~d_itf.switch_1_i;
    d_itf.switch_2_i = ~d_itf.switch_2_i;
    delay(2);
endtask
task change_2c();
    delay(1);
    
    d_itf.switch_0_i = ~d_itf.switch_0_i;
    d_itf.switch_1_i = d_itf.switch_1_i;
    d_itf.switch_2_i = ~d_itf.switch_2_i;
    delay(2);
endtask

task change_3();
    delay(1);
    d_itf.switch_0_i = ~d_itf.switch_0_i;
    d_itf.switch_1_i = ~d_itf.switch_1_i;
    d_itf.switch_2_i = ~d_itf.switch_2_i;
endtask

endclass