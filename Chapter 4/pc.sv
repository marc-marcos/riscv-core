module pc(
    output [31:0] pc_out,
    input reset,
    input clk
  );

  logic [31:0] pc_value;

  always @(posedge clk) begin
    if (reset == 1) begin
      pc_value <= 0;
    end else begin
      pc_value <= pc_value + 1;
    end
  end

  assign pc_out = pc_value;

endmodule
