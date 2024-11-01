module pc(
    output [31:0] pc_out,
    input reset,
    input clk,
    input [31:0] branch_target,
    input [31:0] register_jump_target, 
    input [1:0] choice
  );

  logic [31:0] pc_value;

  always @(posedge clk) begin
    if (reset) begin
      pc_value <= 0;
    end
    else begin
      case (choice)
      2'b00: pc_value <= pc_value + 1;
      2'b01: pc_value <= branch_target;
      2'b10: pc_value <= register_jump_target;
      2'b11: pc_value <= 0;
      endcase
    end
      
  end

  assign pc_out = pc_value;

endmodule
