module immediate_generator(clk, rst, instruction, imm_out,opcode);
   input clk,rst;
   input [31:0] instruction;
   input [6:0] opcode;

   output reg [31:0] imm_out;

   always @(*) begin
     case (opcode)
       // I-type(addi , lw)
       7'b0000011,
         7'b0010011: begin
          imm_out = {{20{instruction[31]}},
                       {instruction[31:20]}};
       end

       // store (sw)
       7'b0100011: begin
          imm_out = {{20{instruction[31]}},
                      {instruction[11:7]},{instruction[31:25]}};
       end

       // branch(pc_src,beq)
       7'b1100011: begin
           imm_out ={{20{instruction[31]}}, {instruction[7]},
                      {instruction[11:8]}, {instruction[30:25]},{instruction[31]}};
       end

       default: begin
         imm_out = 32'b0;
       end
    endcase
   end



endmodule