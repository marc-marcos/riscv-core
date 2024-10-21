all: pc i_mem decode

pc: pc.sv tb_pc.sv
	iverilog -g2012 -o tb_pc.vvp tb_pc.sv

i_mem: i_mem.sv tb_i_mem.sv
	iverilog -g2012 -o tb_i_mem.vvp tb_i_mem.sv

decode: decode.sv tb_decode.sv
	iverilog -g2012 -o tb_decode.vvp tb_decode.sv

register_file: register_file.sv tb_register_file.sv
	iverilog -g2012 -o tb_register_file.vvp tb_register_file.sv

alu: alu.sv tb_alu.sv
	iverilog -g2012 -o tb_alu.vvp tb_alu.sv

core: pc i_mem decode register_file alu core.sv tb_core.sv
	iverilog -g2012 -o tb_core.vvp tb_core.sv

clean:
	rm -rf *.vvp *.vcd

