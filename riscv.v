`include "program_counter.v"
`include "instruction_memory.v"
`include "register_file.v"
`include "control_unit.v"
`include "immediate_generator.v"
`include "alu_control.v"
`include "alu.v"
`include "data_memory.v"
`include "wb_mux.v"
`include "pc_mux.v"
module riscv(clk,rst,next_pc,pc_address,instruction,rd_reg1, rd_reg2, result, write_data, reg_write, rd_data1, rd_data2, opcode, alu_src, pc_src, 
             mem_read, mem_write, mem_to_reg, alu_op,imm_out, funct3, funct7, alu_sel, operand_a, operand_b, operand_c, zero, data_write,
              read_data, pc_plus4, branch_target,);
  input clk,rst;
  input [31:0] next_pc;
  input  [4:0]rd_reg1, rd_reg2, result;
  input  [31:0] write_data;
  input [6:0] opcode;
  input [2:0] funct3;
  input [6:0] funct7;
  input [31:0] operand_a;
  input [31:0] operand_b;
  input [31:0] data_write;
  input [31:0] pc_plus4;
  input [31:0] branch_target;

  output [31:0] read_data; 
  output [31:0] operand_c;
  output zero;
  output [3:0] alu_sel;
  output [31:0] rd_data1, rd_data2;
  output [31:0] pc_address;
  output [31:0] instruction;
  output reg_write;
  output alu_src;
  output pc_src; 
  output mem_read;
  output mem_write;
  output mem_to_reg;
  output [0:1] alu_op;
  output [31:0] imm_out;

  wire [31:0] operand_b_mux;
  wire [31:0] regs [255:0];

  program_counter pc(
    .clk(clk),
    .rst(rst),
    .nxt_pc(next_pc),
    .pc_address(pc_address)
  );

  instruction_memory imem(
    .pc_address(pc_address),
    .instruction(instruction)
  );

  register_file rf(
    .clk(clk),
    .rst(rst),
    .rd_reg1(rd_reg1),
    .rd_reg2(rd_reg2),
    .reg_write(reg_write),
    .result(result),
    .write_data(write_data),
    .rd_data1(rd_data1),
    .rd_data2(rd_data2)
  );

  control_unit cu(
    .clk(clk),
    .rst(rst),
    .opcode(opcode),
    .reg_write(reg_write),
    .alu_src(alu_src),
    .pc_src(pc_src), 
    .mem_read(mem_read),
    .mem_write(mem_write),
    .mem_to_reg(mem_to_reg),
    .alu_op(alu_op)
  );


   immediate_generator ig(
    .instruction(instruction),
    .imm_out(imm_out),
    .opcode(opcode),
    .clk(clk),
    .rst(rst)
    );

    alu_control ac(
      .clk(clk),
      .rst(rst),
      .alu_op(alu_op),
      .funct3(funct3),
      .funct7(funct7),
      .alu_sel(alu_sel)
    );

    alu alu(
      .clk(clk),
      .rst(rst),
      .operand_a(operand_a),
      .operand_b(operand_b_mux),
      .alu_sel(alu_sel),
      .operand_c(operand_c),
      .zero(zero)
    );

    data_memory  dm(
      .clk(clk),
      .rst(rst),
      .mem_write(mem_write),
      .mem_read(mem_read),
      .address(operand_c),
      .data_write(data_write),
      .read_data(read_data)
    );

    wb_mux wbm(
      .alu_result(operand_c),
      .read_data(read_data),
      .mem_to_reg(mem_to_reg),
      .write_data(write_data)
    );

    pc_mux pcm(
      .branch(pc_src),
      .zero(zero),
      .next_pc(next_pc),
      .pc_plus4(pc_plus4),
      .branch_target(branch_target)
    );


    assign rd_reg1 = instruction[19:15];
    assign rd_reg2 = instruction[24:20];
    assign result = instruction[11:7];
    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];
    assign operand_b_mux = alu_src ? imm_out : operand_b;
    assign pc_plus4 = pc_address + 32'h4;

endmodule