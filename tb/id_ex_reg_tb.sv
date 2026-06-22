module id_ex_reg_tb;

    logic clk;
    logic reset;

    logic [31:0] pc_in, rs1_data_in, rs2_data_in, imm_in;
    logic [4:0] rs1_in, rs2_in, rd_in;
    logic reg_write_in, mem_read_in, mem_write_in, mem_to_reg_in;
    logic alu_src_in, branch_in;
    logic [1:0] alu_op_in;

    logic [31:0] pc_out, rs1_data_out, rs2_data_out, imm_out;
    logic [4:0] rs1_out, rs2_out, rd_out;
    logic reg_write_out, mem_read_out, mem_write_out, mem_to_reg_out;
    logic alu_src_out, branch_out;
    logic [1:0] alu_op_out;

    id_ex_reg dut (
        .clk(clk),
        .reset(reset),

        .pc_in(pc_in),
        .rs1_data_in(rs1_data_in),
        .rs2_data_in(rs2_data_in),
        .imm_in(imm_in),

        .rs1_in(rs1_in),
        .rs2_in(rs2_in),
        .rd_in(rd_in),

        .reg_write_in(reg_write_in),
        .mem_read_in(mem_read_in),
        .mem_write_in(mem_write_in),
        .mem_to_reg_in(mem_to_reg_in),
        .alu_src_in(alu_src_in),
        .branch_in(branch_in),
        .alu_op_in(alu_op_in),

        .pc_out(pc_out),
        .rs1_data_out(rs1_data_out),
        .rs2_data_out(rs2_data_out),
        .imm_out(imm_out),

        .rs1_out(rs1_out),
        .rs2_out(rs2_out),
        .rd_out(rd_out),

        .reg_write_out(reg_write_out),
        .mem_read_out(mem_read_out),
        .mem_write_out(mem_write_out),
        .mem_to_reg_out(mem_to_reg_out),
        .alu_src_out(alu_src_out),
        .branch_out(branch_out),
        .alu_op_out(alu_op_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        pc_in = 0;
        rs1_data_in = 0;
        rs2_data_in = 0;
        imm_in = 0;
        rs1_in = 0;
        rs2_in = 0;
        rd_in = 0;
        reg_write_in = 0;
        mem_read_in = 0;
        mem_write_in = 0;
        mem_to_reg_in = 0;
        alu_src_in = 0;
        branch_in = 0;
        alu_op_in = 0;

        #10;
        reset = 0;

        pc_in = 32'h00000004;
        rs1_data_in = 32'h0000000A;
        rs2_data_in = 32'h00000014;
        imm_in = 32'h00000005;
        rs1_in = 5'd1;
        rs2_in = 5'd2;
        rd_in = 5'd3;

        reg_write_in = 1;
        mem_read_in = 0;
        mem_write_in = 0;
        mem_to_reg_in = 0;
        alu_src_in = 1;
        branch_in = 0;
        alu_op_in = 2'b10;

        #10;

        if (
            pc_out === 32'h00000004 &&
            rs1_data_out === 32'h0000000A &&
            rs2_data_out === 32'h00000014 &&
            imm_out === 32'h00000005 &&
            rs1_out === 5'd1 &&
            rs2_out === 5'd2 &&
            rd_out === 5'd3 &&
            reg_write_out === 1 &&
            alu_src_out === 1 &&
            alu_op_out === 2'b10
        ) begin
            $display("====================================");
            $display("ID/EX PIPELINE REGISTER TEST PASSED");
            $display("====================================");
        end
        else begin
            $display("====================================");
            $display("ID/EX PIPELINE REGISTER TEST FAILED");
            $display("====================================");
        end

        $stop;
    end

endmodule