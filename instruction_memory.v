module instruction_memory(pc_address, instruction);
   input [31:0] pc_address;
   output reg [31:0] instruction;
  
   logic [31:0] mem [0:255];
   integer i;
   initial begin
     for (i=0; i<256; i=i+1)
       mem[i]= 32'b0;
    
       // core rv32i program
     mem[0] = 32'h00000013; // NOP
     mem[1] = 32'h00400093; // addi x1,x0,4
     mem[2] = 32'h00800113; // addi x2,x0,8
     mem[3] = 32'h002081B3; // add x3,x1,x2
     mem[4] = 32'h40208233; // sub x4,x1,x2
       // memory ops
     mem[5] = 32'h0000A303; // lw  x6,0(x1)
     mem[6] = 32'h0062A023; // sw  x6,0(x5)
      // logical
    mem[7] = 32'h0020F2B3; // and x5,x1,x2
    mem[8] = 32'h0020E333; // or  x6,x1,x2
    mem[9] = 32'h0020C3B3; // xor x7,x1,x2

    // shift
    mem[10] = 32'h00209333; // sll x6,x1,x2
    mem[11] = 32'h0020D3B3; // srl x7,x1,x2
    mem[12] = 32'h4020D433; // sra x8,x1,x2

    // branch
    mem[13] = 32'h00208463;


   end 
    always @(*) begin
        instruction = mem[pc_address[9:2]]; 
    end
endmodule