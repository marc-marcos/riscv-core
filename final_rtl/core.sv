`include "pc.sv"
`include "i_mem.sv"
`include "decode.sv"
`include "register_file.sv"
`include "alu.sv"

module core(
  input reset,
  input clk
);


always_comb begin
  if (reset) begin
    choice_pc = 2'b11;
  end

  else begin
    choice_pc = 0;
  end
end

// PC 
logic [31:0] data;
logic [31:0] pc_out;
logic [1:0] choice_pc;

pc pc_inst(
  .pc_out(pc_out),
  .choice(choice_pc),
  .reset(reset),
  .clk(clk)
);

i_mem i_mem_inst(
  .addr(pc_out),
  .data(data)
);

// DECODE
logic is_add, is_addi, is_beq, is_bne, is_blt, is_bge, is_bltu, is_bgeu, incorrect;
logic valid_rd, valid_rs1, valid_rs2, valid_imm;
logic [31:0] imm;
logic [4:0] rd, rs1, rs2;

decode decode_inst(
  .instruction(data),
  .is_add(is_add),
  .is_addi(is_addi),
  .is_beq(is_beq),
  .is_bne(is_bne),
  .is_blt(is_blt),
  .is_bge(is_bge),
  .is_bltu(is_bltu),
  .is_bgeu(is_bgeu),
  .incorrect(incorrect),
  .valid_rd(valid_rd),
  .valid_rs1(valid_rs1),
  .valid_rs2(valid_rs2),
  .valid_imm(valid_imm),
  .imm(imm),
  .rd(rd),
  .rs1(rs1),
  .rs2(rs2)
);

// REGFILE 
logic [31:0] output_reg1, output_reg2;

register_file regfile_inst(
  .reset(reset),
  .wr_en(valid_rd),
  .wr_addr(rd), 
  .wr_data(result_alu), // Este es el resultado de la ALU
  .rd_en1(valid_rs1),
  .rd_en2(valid_rs2),
  .rd_addr1(rs1),
  .rd_addr2(rs2),
  .rd_data1(output_reg1),
  .rd_data2(output_reg2)
);

logic [31:0] first_operand;
logic [31:0] result_alu;

always_comb begin
  if (valid_imm) begin
    first_operand = imm;
  end
  else begin
    first_operand = output_reg1;
  end
end

alu alu_inst(
  .op1(first_operand),
  .op2(output_reg2),
  .is_addi(is_addi),
  .is_add(is_add),
  .reset(reset),
  .result(result_alu)
);

endmodule
