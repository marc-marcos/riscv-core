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

  logic funct3, rd, rs1, rs2, opcode, imm;
  logic valid_funct3, valid_rd, valid_rs1, valid_rs2, valid_imm;
  

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

    // Validity of fields
    assign valid_funct3 = (is_b || is_i || is_r || is_s) ? 1'b1 : 1'b0;
    assign valid_rd = (is_r || is_i || is_u || is_j) ? 1'b1 : 1'b0;
    assign valid_rs1 = (is_r || is_i || is_s || is_b) ? 1'b1 : 1'b0;
    assign valid_rs2 = (is_r || is_s || is_b) ? 1'b1 : 1'b0;
    assign valid_imm = (is_i || is_s || is_b || is_u || is_j) ? 1'b1 : 1'b0

    assign imm = is_i ? {21{instruction[31]}, instruction[30:20]} :
                 is_s ? {} :
                 is_b ? {} :
                 is_u ? {} :
                 is_j ? {} : 0;

    
  end

endmodule
