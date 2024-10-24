module i_mem(
    input logic [31:0] addr,
    output logic [31:0] data
  );

  logic [31:0] internal [255:0];
  logic [31:0] data_internal;

  always_comb begin 
    data_internal = internal[addr];
  end

  assign data = data_internal;

  // memory initialization

  always_comb begin
    $readmemh("hex_dump.bin", internal);
  end

endmodule
