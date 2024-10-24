`include "i_mem.sv"

module tb_i_mem();
  wire [31:0] data;
  reg [31:0] addr;

  i_mem uut(
    .addr(addr),
    .data(data)
    );

  initial begin 
    addr = 0;

    #10

    addr = 1;

    #10

    addr = 2;

    #10

    addr = 0;
  end

  initial begin
    $dumpfile("i_mem.vcd");
    $dumpvars(0, tb_i_mem);
  end

endmodule
