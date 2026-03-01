`timescale 1ns/1ps

module tb_riscv();

    wire [31:0] pc_address;
    reg [31:0] operand_a, operand_b, data_write;
    reg clk,rst;
    reg [31:0] branch_target;
    wire [31:0] instruction;
    
    riscv  rv (
        .pc_address(pc_address),
        .instruction(instruction),
        .operand_a(operand_a),
        .operand_b(operand_b),
        .clk(clk),
        .rst(rst),
        .branch_target(branch_target),
        .reg_write(reg_write),
        .data_write(data_write)
    );
    
    initial begin
      clk=1'b0;
      forever #5 clk= ~clk;
    end
    

    initial begin
        
        $display("------ RV32I Processor Simulation Started ------");

        rst=1'b1;
        operand_a = 32'h34568a5c;
        operand_b = 32'h256879bd;
        #10;

        $display("Reset Released");

        rst=1'b0;
        operand_a = 32'h34568a5c;
        operand_b = 32'h34568a5c;
        branch_target = 32'h10;
        #20;

        rst =1'b0;
        branch_target = 32'h10;
        operand_a = 32'h34568a5c;
        operand_b = 32'h256879bd;
        #10;

        rst=1'b0;
        operand_a = 32'h34568a5c;
        operand_b = 32'h34568a5c;
        branch_target = 32'h10;
        #20;

        rst=1'b0;
        operand_a = 32'h34568a5c;
        operand_b = 32'h256879bd;
        branch_target = 32'h10;
        #20;

        rst=1'b0;
        operand_a = 32'h34568a5c;
        operand_b = 32'h256879bd;
        branch_target = 32'h2c;
        #20;

        rst=1'b0;
        operand_a = 32'h34568a5c;
        operand_b = 32'h256879bd;
        branch_target = 32'h10;
        #20;

        #500;

        $display("------ Simulation Finished ------");

        $finish;
    end

    always @(posedge clk)

      begin

        $display("TIME=%0t  PC=%h",$time,
          rv.pc_address);   // change if PC name differs

       end

    initial begin
     $dumpfile("dump.vcd");
     $dumpvars(0);
   end

endmodule
