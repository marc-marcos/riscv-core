`include "decode.sv"

module tb_decode();
  reg [31:0] instruction;
  wire is_add, is_addi, is_beq, is_bne, is_blt, is_bge, is_bltu, is_bgeu, incorrect;
  
  decode uut (
    .instruction(instruction), 
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2),
    .is_add(is_add),
    .is_addi(is_addi),
    .is_beq(is_beq), 
    .is_bne(is_bne),
    .is_blt(is_blt), 
    .is_bge(is_bge), 
    .is_bltu(is_bltu),
    .is_bgeu(is_bgeu),
    .incorrect(incorrect)
  );

  initial begin
    // Generate 10 random instructions
    repeat (10) begin
      instruction = 32'h00010463;
      #1;
      instruction = 32'h01010113;
      #1;
    end
  end

  initial begin
    $dumpfile("tb_decode.vcd");
    $dumpvars(0, tb_decode);
  end
endmodule
