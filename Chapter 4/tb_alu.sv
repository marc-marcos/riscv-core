`include "alu.sv"

module tb_alu();
  reg [31:0] op1, op2, imm;
  reg reset;
  wire [31:0] result;
  reg is_addi, is_add;

  alu alu_inst(
    .op1(op1),
    .op2(op2),
    .imm(imm),
    .is_addi(is_addi),
    .is_add(is_add),
    .reset(reset),
    .result(result)
  );

  initial begin
    op1 = 32'h00000000;
    op2 = 32'h00000000;
    imm = 32'h00000000;
    is_addi = 1'b0;
    is_add = 1'b0;
    reset = 1'b1;
    #1;
    op1 = 32'h00000002;
    op2 = 32'h00000001;
    is_add = 1'b1;
    reset = 1'b0;
    #1;
    op1 = 32'h00000001;
    op2 = 32'h00000002;
    imm = 32'h00000002;
    is_addi = 1'b1;
    is_add = 1'b0;
    #1;

    $finish;
  end

  initial begin
    $dumpfile("tb_alu.vcd");
    $dumpvars(0, tb_alu);
  end

endmodule
