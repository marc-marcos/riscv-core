`include "pc.sv"
`include "i_mem.sv"
`include "decode.sv"
`include "register_file.sv"

module core(
  input reset,
  input clk
);

// PC to i_mem
logic [31:0] pc_out;

// i_mem to decode
logic [31:0] data;

// decode onward
logic is_add, is_addi, is_beq, is_bne, is_blt, is_bge, is_bltu, is_bgeu, incorrect;
logic [4:0] rd, rs1, rs2;

pc pc_inst(
  .pc_out(pc_out),
  .reset(reset),
  .clk(clk)
);

i_mem i_mem_inst(
  .addr(pc_out),
  .data(data)
);

decode decode_inst(
  .incorrect(incorrect),
  .instruction(data),
  .is_add(is_add),
  .is_addi(is_addi),
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
  .is_bgeu(is_bgeu)
);

register_file register_file_inst(
  .reset(reset),
  .wr_en(0),
  .wr_addr(0),
  .wr_data(0),
  .rd_en1(0),
  .rd_en2(0),
  .rd_addr1(0),
  .rd_addr2(0),
  .rd_data1(0),
  .rd_data2(0)
);

endmodule
