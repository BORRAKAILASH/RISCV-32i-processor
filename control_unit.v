module control_unit(clk, rst,opcode, reg_write, alu_src, pc_src, mem_read,
                     mem_write, mem_to_reg, alu_op);
  input [6:0] opcode;
  input clk,rst;

  output reg reg_write;
  output reg alu_src;
  output reg pc_src; //for consider of pc_address
  output reg mem_read;
  output reg mem_write;
  output reg mem_to_reg;
  output reg [0:1] alu_op;

  always @(*) begin
    // default values
    reg_write  = 1'b0;
    alu_src    = 1'b0;
    pc_src     = 1'b0;
    mem_read   = 1'b0;
    mem_write  = 1'b0;
    mem_to_reg = 1'b0;
    alu_op     = 2'b11;

    case (opcode)
       // I-type arthimetic(addi)
       7'b0010011: begin
         reg_write = 1'b1;
         alu_src   = 1'b1;
         alu_op    = 2'b10;
       end

       // R-type
       7'b0110011: begin
         reg_write = 1'b1;
         alu_src   = 1'b0;
         alu_op    = 2'b10;
       end

       // Load (lw)
       7'b0000011: begin
          reg_write  = 1'b1;
          alu_src    = 1'b1;
          mem_read   = 1'b1;
          mem_to_reg = 1'b1;
          alu_op     = 2'b00;
       end

       // store (sw)
       7'b0100011: begin
         alu_src   = 1'b1;
         mem_write = 1'b1;
         alu_op    = 2'b00;
       end

       // branch(pc_src)
       7'b1100011: begin
         pc_src = 1'b1;
         alu_op = 2'b01;
       end
    endcase
  end

endmodule