`include "decode.sv"

module tb_decode();
  reg [31:0] instruction;
  wire is_b, is_i, is_j, is_r, is_s, is_u, incorrect;
  
  decode uut (
    .instruction(instruction), 
    .is_b(is_b),
    .is_i(is_i),
    .is_j(is_j),
    .is_r(is_r),
    .is_s(is_s),
    .is_u(is_u),
    .incorrect(incorrect)
  );

  initial begin
    // Generate 10 random instructions
    repeat (10) begin
      instruction = $random;
      #1;
    end
  end

  initial begin
    $dumpfile("tb_decode.vcd");
    $dumpvars(0, tb_decode);
  end
endmodule
