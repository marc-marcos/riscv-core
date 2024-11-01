`include "pc.sv"

module tb_pc();
  wire [31:0] pc_out;
  reg clk;
  reg reset;
  reg [1:0] choice;
  reg [31:0] branch_target;
  reg [31:0] register_jump_target; 

  pc uut(
    .pc_out(pc_out),
    .reset(reset),
    .choice(choice),
    .clk(clk),
    .branch_target(branch_target),
    .register_jump_target(register_jump_target)
  );

  always #5 clk = ~clk;

  initial begin 
    clk = 0;
    reset = 1;
    choice = 2'b00;
    branch_target = 32'hdeadbeef;
    register_jump_target = 32'hbeef;

    #10;

    reset = 0;
    choice = 2'b00;

    #10;

    choice = 2'b01;

    #10;

    choice = 2'b00;

    #10;

    choice = 2'b10;

    #10;

    choice = 2'b00;

    #150

    $finish;
  end

  initial begin
    $dumpfile("pc.vcd");
    $dumpvars(0, tb_pc);
  end
endmodule
