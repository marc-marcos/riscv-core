`include "register_file.sv"

module tb_register_file();
  reg reset;
  reg wr_en;
  reg [4:0] wr_addr;
  reg [31:0] wr_data;
  reg rd_en1;
  reg rd_en2;
  reg clk;
  reg [4:0] rd_addr1;
  reg [4:0] rd_addr2;
  wire [31:0] rd_data1;
  wire [31:0] rd_data2;

  register_file uut(
    .reset(reset),
    .wr_en(wr_en),
    .wr_addr(wr_addr),
    .wr_data(wr_data),
    .rd_en1(rd_en1),
    .rd_en2(rd_en2),
    .rd_addr1(rd_addr1),
    .rd_addr2(rd_addr2),
    .rd_data1(rd_data1),
    .rd_data2(rd_data2)
  );

  always begin
    #1 clk = ~clk;
  end;

  initial begin
    reset = 1;
    wr_en = 0;
    wr_addr = 0;
    wr_data = 0;
    rd_en1 = 0;
    rd_en2 = 0;
    rd_addr1 = 0;
    rd_addr2 = 0;
    clk = 1;

    #2;

    reset = 0;
    wr_en = 1;
    wr_addr = 1;
    wr_data = 32'hbeefdead;

    #2;

    wr_en = 1;
    wr_addr = 0;
    wr_data = 32'hdeadbeef;

    #2;

    wr_en = 0;
    rd_en1 = 1;
    rd_addr1 = 0;
    rd_en2 = 1;
    rd_addr2 = 0;

    #2;

    wr_en = 0;
    rd_en1 = 1;
    rd_addr1 = 0;
    rd_en2 = 1;
    rd_addr2 = 1;

    #10;
    $finish;
  end

  initial begin
    $dumpfile("register_file.vcd");
    $dumpvars(0, tb_register_file);
  end

endmodule
