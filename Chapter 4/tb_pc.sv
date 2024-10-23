`include "pc.sv"

module tb_pc();
  wire [31:0] pc_out;
  reg clk;
  reg reset;
  reg [1:0] choice;

  pc uut(
    .pc_out(pc_out),
    .reset(reset),
    .choice(choice),
    .clk(clk)
  );

  always #5 clk = ~clk;

  initial begin 
    clk = 0;
    reset = 1;
    choice = 2'b11;

    #10;

    reset = 0;
    choice = 2'b00;

    #150

    $finish;
  end

  initial begin
    $dumpfile("pc.vcd");
    $dumpvars(0, tb_pc);
  end
endmodule
