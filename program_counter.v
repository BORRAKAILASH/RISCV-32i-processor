module program_counter( clk, rst, nxt_pc, pc_address );
    input clk;
    input rst;
    input [31:0] nxt_pc;
    output reg [31:0] pc_address;

    always @(posedge clk or posedge rst) begin
      if (rst)
         pc_address<=32'b0;
      else
         pc_address<= nxt_pc;
    end    
endmodule
