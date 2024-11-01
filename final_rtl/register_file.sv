module register_file(
  input reset,
  input wr_en,
  input [4:0] wr_addr,
  input [31:0] wr_data,
  input rd_en1,
  input rd_en2,
  input [4:0] rd_addr1,
  input [4:0] rd_addr2,
  input clk,
  output [31:0] rd_data1,
  output [31:0] rd_data2
  );

  logic [31:0] internal [31:0];

  logic [31:0] data_internal1;
  logic [31:0] data_internal2;

  always_comb begin
    if (reset) begin
      integer i;
      for (i = 0; i < 32; i = i + 1) begin
        internal[i] = 32'b0;
      end
      data_internal1 = 32'b0;
      data_internal2 = 32'b0;
    end else begin
      if (rd_en1) begin
        data_internal1 = internal[rd_addr1];
      end

      if (rd_en2) begin
        data_internal2 = internal[rd_addr2];
      end

      if (wr_en) begin
        internal[wr_addr] = wr_data;
      end
    end
  end

  assign rd_data1 = data_internal1;
  assign rd_data2 = data_internal2;

endmodule
