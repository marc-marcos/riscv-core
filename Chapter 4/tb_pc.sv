`include "pc.sv"

module tb_pc();
  wire [31:0] pc_out;
  reg clk;
  reg reset;

  pc uut(
    .pc_out(pc_out),
    .reset(reset),
    .clk(clk)
  );

  always #5 clk = ~clk;

  initial begin 
    clk = 0;
    reset = 1;

    #10;

    reset = 0;

    #150

    $finish;
  end

  initial begin
    $dumpfile("pc.vcd");
    $dumpvars(0, tb_pc);
  end
endmodule
