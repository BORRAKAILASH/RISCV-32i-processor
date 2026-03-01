module alu_control(clk, rst, alu_op, funct3, funct7, alu_sel);
   input clk,rst;
   input [1:0] alu_op;
   input [2:0] funct3;
   input [6:0] funct7;
   output reg [3:0] alu_sel;

   always @(*) begin
     case (alu_op)
       2'b00: alu_sel = 4'b0000; //add(lw & sw)

       2'b01: alu_sel = 4'b0001; //sub(branch compare)

       2'b10: begin 
              case (funct3)
                3'b000: begin
                case (funct7)
                  7'b0000000: alu_sel = 4'b0000; //add
                  7'b0100000: alu_sel = 4'b0001; //subract
                endcase  
                end
                3'b111: alu_sel = 4'b0010; //and
                3'b110: alu_sel = 4'b0011; //or
                3'b100: alu_sel = 4'b0100; //xor
                3'b001: alu_sel = 4'b0101; //sll
                3'b101: begin
                  case(funct7)
                    7'b0000000: alu_sel = 4'b0110; //srl
                    7'b0100000: alu_sel = 4'b0111; //sra
                  endcase
                end

              endcase
              end
       default: alu_sel = 4'bzzzz;
     endcase
   end

endmodule