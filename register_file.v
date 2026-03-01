module register_file(clk, rst, rd_reg1, rd_reg2, result, write_data, reg_write, rd_data1, rd_data2, );
    input clk,rst,reg_write;
    input [4:0]rd_reg1, rd_reg2, result;
    input  [31:0] write_data;

    output  [31:0] rd_data1, rd_data2;

    reg [31:0]regs[0:31];
    integer i;

    always @(posedge clk or posedge rst) begin
       if (rst) begin
            for (i=0; i<32; i++)
                regs[i] <= 32'b0;
        end
        else if (reg_write && result != 5'd0) begin
            regs[result] <= write_data;
        end
    end

    
    assign  rd_data1= regs[rd_reg1];
    assign  rd_data2= regs[rd_reg2];

endmodule