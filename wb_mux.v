module wb_mux(alu_result, read_data, mem_to_reg, write_data);
  input [31:0] alu_result;
  input [31:0] read_data;
  input mem_to_reg;

  output reg [31:0] write_data;

  always @(*) begin
    if(mem_to_reg)
      write_data = read_data;
    else
      write_data = alu_result;
  end



endmodule