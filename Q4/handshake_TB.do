vlib work
vmap work work

vlog handshake.sv
vlog handshake_TB.sv

vsim -voptargs=+acc work.handshake_TB

add wave sim:/handshake_TB/*
run 75ns