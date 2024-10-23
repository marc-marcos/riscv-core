module alu(
  input logic [31:0] op1,
  input logic [31:0] op2,
  input logic is_addi, is_add, reset,
  output logic [31:0] result
  );

  always_comb begin
    if (reset) begin
      result = 32'b0;
    end

    else begin
      if (is_addi | is_add) begin
        result = op1 + op2;
      end
      else begin
        result = 32'b0;
      end
    end
  end


endmodule
