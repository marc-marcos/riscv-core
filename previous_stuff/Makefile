all: counter

counter:
	iverilog -o counter_tb.vvp tb_counter.sv

fibonacci:
	iverilog -o fibonacci_tb.vvp tb_fibonacci.sv

rec_calc:
	iverilog -o rec_calc.vvp rec_calc_tb.sv

clean:
	rm -rf *.vvp *.vcd
