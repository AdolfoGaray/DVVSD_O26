class star_light_monitor;

virtual star_light_itf monitor_itf;
logic light_anterior;

function new(virtual star_light_itf.monitor m_itf);
    monitor_itf = m_itf;
    light_anterior = m_itf.lights;
endfunction

task save();
    light_anterior = m_itf.lights;
endtask

task check(input logic [1:0] caso, input light_anterior);
    if((caso == 0) & (m_itf.lights != light_anterior)) $display("Pass");
    else $display("FAIL");
    if((caso == 1) & (m_itf.lights == light_anterior)) $display("Pass");
    else $display("FAIL");
    if((caso == 2) & (m_itf.lights != light_anterior)) $display("Pass");
    else $display("FAIL");
endtask

endclass