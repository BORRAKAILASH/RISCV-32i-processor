module pc_mux(branch, zero, pc_plus4, branch_target, next_pc);
  input branch;
  input zero;
  input [31:0] pc_plus4;
  input [31:0] branch_target;

  output [31:0] next_pc;

  assign next_pc =(branch && zero)
                   ? branch_target
                   : pc_plus4;

endmodule