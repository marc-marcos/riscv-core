module decode(
  input [31:0] instruction,
  output reg [4:0] rd,
  output reg [4:0] rs1,
  output reg [4:0] rs2,
  output reg incorrect,
  output reg is_add,
  output reg is_addi,
  output reg is_beq, 
  output reg is_bne,
  output reg is_blt, 
  output reg is_bge, 
  output reg is_bltu,
  output reg is_bgeu
  );

  logic funct7, funct3, opcode, imm, dec_bits;
  logic valid_funct3, valid_rd, valid_rs1, valid_rs2, valid_imm;
  logic is_b, is_i, is_j, is_r, is_s, is_u;

  always_comb begin
    is_b = 1'b0;
    is_i = 1'b0;
    is_j = 1'b0;
    is_r = 1'b0;
    is_s = 1'b0;
    is_u = 1'b0;
    incorrect = 1'b0;

    case (instruction[1:0]) 
      2'b11: begin
        incorrect = 1'b0;

        case (instruction[6:5]) 
          2'b00: begin
            case(instruction[4:2]) 
              3'b000, 3'b001, 3'b100, 3'b110: is_i = 1'b1;
              3'b101: is_u = 1'b1;
              default: incorrect = 1'b1;
            endcase
          end

          2'b01: begin
            case(instruction[4:2]) 
              3'b000, 3'b001: is_s = 1'b1;
              3'b011, 3'b100, 3'b110: is_r = 1'b1;
              3'b101: is_u = 1'b1;
              default: incorrect = 1'b1;
            endcase
          end

          2'b10: begin
            case(instruction[4:2])
              3'b100: is_r = 1'b1;
              default: incorrect = 1'b1;
            endcase
          end

          2'b11: begin
            case(instruction[4:2]) 
              3'b000:is_b = 1'b1;
              3'b001:is_i = 1'b1;
              3'b011:is_j = 1'b1;
              default: incorrect = 1'b1;
            endcase
          end

          default: incorrect = 1'b1;
        endcase
      end

      default: incorrect = 1'b1;
    endcase

    // Field extraction
    rs2 = instruction[24:20];
    rs1 = instruction[19:15];
    rd = instruction[11:7];
    opcode = instruction[6:0];
    funct3 = instruction[14:12];

    // Validity of fields
    valid_funct3 = (is_b || is_i || is_r || is_s) ? 1'b1 : 1'b0;
    valid_rd = (is_r || is_i || is_u || is_j) ? 1'b1 : 1'b0;
    valid_rs1 = (is_r || is_i || is_s || is_b) ? 1'b1 : 1'b0;
    valid_rs2 = (is_r || is_s || is_b) ? 1'b1 : 1'b0;
    valid_imm = (is_i || is_s || is_b || is_u || is_j) ? 1'b1 : 1'b0;

    imm = is_i ? {{21{instruction[31]}}, instruction[30:20]} :
                 is_s ? {{21{instruction[31]}}, instruction[30:25], instruction[11:7]} :
                 is_b ? {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0} :
                 is_u ? {instruction[31:12], 12'b0} :
                 is_j ? {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0} : 0;
    
    dec_bits = {instruction[30], funct3, opcode};
    
    is_beq = (dec_bits ==? 11'bx_000_1100011);
    is_bne = (dec_bits ==? 11'bx_001_1100011);
    is_blt = (dec_bits ==? 11'bx_100_1100011);
    is_bge = (dec_bits ==? 11'bx_101_1100011);
    is_bltu = (dec_bits ==? 11'bx_110_1100011);
    is_bgeu = (dec_bits ==? 11'bx_111_1100011);
    is_addi = (dec_bits ==? 11'bx_000_0010011);
    is_add = (dec_bits == 11'b0_000_0110011);

  end

endmodule
