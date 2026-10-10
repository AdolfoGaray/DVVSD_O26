vlib work
vmap work work

vlog OUTPUT_ENUM.sv
vlog PARITY_ENUM.sv
vlog CLK_BAUDRATE.sv
vlog MUX4A1.sv
vlog PARITY_GETTER.sv
vlog PISO_LSB_SIGNED.sv
vlog UART_INTERFACE.sv
vlog TX_FSM.sv
vlog TX.sv
vlog TX_WRAPPER.sv
vlog TESTER.sv

vlog +define+PARITY_TYPE=PARITY_ODD TX_TB.sv
#vlog +define+PARITY_TYPE=PARITY_EVEN TX_TB.sv
#vlog +define+PARITY_TYPE=PARITY_NONE TX_TB.sv

vsim -voptargs=+acc work.TX_TB
view wave
add wave sim:/TX_TB/uart_itf/*
add wave -r sim:/TX_TB/tx_DUT/tx/tx_fsm/*
run 1000ns