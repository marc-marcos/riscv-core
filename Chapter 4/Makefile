all: pc i_mem decode

pc: pc.sv tb_pc.sv
	iverilog -g2012 -o tb_pc.vvp tb_pc.sv

i_mem: i_mem.sv tb_i_mem.sv
	iverilog -g2012 -o tb_i_mem.vvp tb_i_mem.sv

decode: decode.sv tb_decode.sv
	iverilog -g2012 -o tb_decode.vvp tb_decode.sv

clean:
	rm -rf *.vvp *.vcd

