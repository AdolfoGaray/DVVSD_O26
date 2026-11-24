vlib work
vmap work work

vlog SS_oneshot_five_cycles.sv
vlog SS_oneshot_five_cycles_TB.sv

vsim -voptargs=+acc work.SS_oneshot_five_cycles_TB

add wave sim:/SS_oneshot_five_cycles_TB/*
run -all