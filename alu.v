module alu(clk, rst, operand_a, operand_b, alu_sel, operand_c, zero);
   input clk,rst;
   input [31:0] operand_a;
   input [31:0] operand_b;
   input [3:0] alu_sel;

   output reg [31:0] operand_c;
   output zero;

   always @(*) begin
     case (alu_sel)
       4'b0000: operand_c = operand_a + operand_b; // add
       4'b0001: operand_c = operand_a - operand_b; // subtract
       4'b0010: operand_c = operand_a & operand_b; // and
       4'b0011: operand_c = operand_a | operand_b; // or
       4'b0100: operand_c = operand_a ^ operand_b; // xor
       4'b0101: operand_c = operand_a << operand_b[4:0]; // sll
       4'b0110: operand_c = operand_a >> operand_b[4:0]; // srl
       4'b0111: operand_c = $signed(operand_a) >>> operand_b[4:0]; // sra
       default: operand_c = 32'h0;
     endcase

     
   end

    assign zero = (operand_c == 32'h0); // for branch


endmodule