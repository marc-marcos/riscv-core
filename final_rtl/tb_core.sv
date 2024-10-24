`include "core.sv"

module tb_core();
  reg clk = 0;
  reg reset = 0;

  core core_inst(
    .reset(reset),
    .clk(clk)
  );

  always begin
    #10 clk = ~clk;
  end

  initial begin
    clk = 1;
    reset = 1;
    #10;
    reset = 0;
    #100;
    $finish;
  end
  
  initial begin
    $dumpfile("tb_core.vcd");
    $dumpvars(0, tb_core);
  end

endmodule
