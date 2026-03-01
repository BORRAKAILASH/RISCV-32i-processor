module data_memory(clk, rst, mem_write, mem_read, address, data_write, read_data);
   input clk,rst;
   input mem_write,mem_read;
   input [31:0] address;
   input [31:0] data_write;

   output reg [31:0] read_data;

   reg [31:0]mem[0:255];
   integer i;
   
   initial begin
      for (i=0; i<32; i++)
       mem[i] = 32'b0;
   end

   always @(posedge clk) begin
     // sw
     if (mem_write) begin
       mem[address[9:2]] <= data_write;
     end
   end

   always @(*) begin
     //lw
     if (mem_read) begin
       read_data = mem[address[9:2]];
     end
     
     else begin
       read_data = 32'b0;
     end

   end



endmodule