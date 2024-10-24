`include "counter.sv"

module tb_counter();
    reg clk;
    reg reset;

    wire [16:0] count;

    counter uut (
        .clk(clk),
        .reset(reset),
        .out(count)
    );

    always #5 clk = ~clk;

    always begin
        clk = 0;
        reset = 1;

        #10 reset = 1;
        #10 reset = 0;

        #50;

        #10 reset = 1;
        #10 reset = 0;
        
        #150;

        $finish;
    end

    always begin
        $dumpfile("counter_wave.vcd");
        $dumpvars(0, tb_counter);
    end
endmodule
