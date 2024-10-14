`include "fibonacci.sv"
module fibonacci_tb();
    reg clk;
    reg reset;

    wire [16:0] fib;

    fibonacci uut(
        .clk(clk),
        .reset(reset),
        .out(fib)
        );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        #10;

        reset = 0;

        #150;

        $finish;
    end

    initial begin
        $dumpfile("counter_wave.vcd");
        $dumpvars(0, fibonacci_tb);
    end
endmodule
