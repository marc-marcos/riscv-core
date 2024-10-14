`include "rec_calc.sv"
module rec_calc_tb();
    reg clk;
    reg reset;
    reg [16:0] valA;
    reg [3:0] op;
    wire [16:0] result;

    rec_calc uut(
        .valA(valA),
        .op(op),
        .clk(clk),
        .reset(reset),
        .result(result)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        valA = 0;
        reset = 1;
        op = 0;

        #10;

        reset = 0;
        valA = 'b1;

        #20;

        reset = 0;
        valA = 'b10;

        #150;

        $finish;
    end

    initial begin
        $dumpfile("counter_wave.vcd");
        $dumpvars(0, rec_calc_tb);
    end
endmodule
