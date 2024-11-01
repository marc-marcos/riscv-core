# Things to re-test

## ALU

### Inputs
- [31:0] op1
- [31:0] op2
- [0:0] is_op (where op are all the operations supported inside the ALU.)

### Outputs
- [31:0] result

## DECODE

### Inputs
- [31:0] instruction

### Outputs 
- [0:0] is_op (where op are all the operations supported inside the ALU.)
- [31:0] imm
- [4:0] rd
- [4:0] rs1
- [4:0] rs2
- incorrect
- valid_rd
- valid_rs1
- valid_rs2
- valid_imm

## PC (TESTED) 

### Inputs
- clk
- [1:0] choice
- reset
- [31:0] branch_target 
- [31:0] register_jump_target

### Body

if reset -> pc_out = 0;
else
    if choice == 00: pc_value + 1
    if choice == 01: pc_value  = branch_target
    if choice == 10: pc_value = register_jump_target
    if choice == 11: 0;

### Outputs
- [31:0] pc_out

## REGISTER FILE (TESTED)

### Inputs
- reset
- wr_en
- [4:0] wr_addr
- [4:0] rd_addr1
- [4:0] rd_addr2
- [31:0] wr_data
- rd_en1
- rd_en2
- clk

### Outputs
- [31:0] rd_data1
- [31:0] rd_data2

## CONNECTIONS BETWEEN MODULES
