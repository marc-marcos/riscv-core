module decode(
  input [31:0] instruction,
  output reg is_b,
  output reg is_i,
  output reg is_j,
  output reg is_r,
  output reg is_s,
  output reg is_u,
  output reg incorrect
  );

  logic funct7, funct3, rd, rs1, rs2, opcode, imm, dec_bits;
  logic valid_funct3, valid_rd, valid_rs1, valid_rs2, valid_imm;
  logic is_beq, is_bne, is_blt, is_bge, is_bltu, is_bgeu, is_addi, is_add;

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
    assign rs2 = instruction[24:20];
    assign rs1 = instruction[19:15];
    assign rd = instruction[11:7];
    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];

    // Validity of fields
    assign valid_funct3 = (is_b || is_i || is_r || is_s) ? 1'b1 : 1'b0;
    assign valid_rd = (is_r || is_i || is_u || is_j) ? 1'b1 : 1'b0;
    assign valid_rs1 = (is_r || is_i || is_s || is_b) ? 1'b1 : 1'b0;
    assign valid_rs2 = (is_r || is_s || is_b) ? 1'b1 : 1'b0;
    assign valid_imm = (is_i || is_s || is_b || is_u || is_j) ? 1'b1 : 1'b0;

    // TODO fix this
    assign imm = is_i ? {{21{instruction[31]}}, instruction[30:20]} :
                 is_s ? {{21{instruction[31]}}, instruction[30:25], instruction[11:7]} :
                 is_b ? {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0} :
                 is_u ? {instruction[31:12], 12'b0} :
                 is_j ? {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0} : 0;

    // assign funct7 = is_r ? instruction[31:25] : 0;
    
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
