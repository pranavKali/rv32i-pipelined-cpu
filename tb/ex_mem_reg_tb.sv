module ex_mem_reg_tb;

    logic clk;
    logic reset;

    logic [31:0] alu_result_in;
    logic [31:0] rs2_data_in;
    logic [4:0] rd_in;

    logic reg_write_in;
    logic mem_read_in;
    logic mem_write_in;
    logic mem_to_reg_in;

    logic [31:0] alu_result_out;
    logic [31:0] rs2_data_out;
    logic [4:0] rd_out;

    logic reg_write_out;
    logic mem_read_out;
    logic mem_write_out;
    logic mem_to_reg_out;

    ex_mem_reg dut (
        .clk(clk),
        .reset(reset),

        .alu_result_in(alu_result_in),
        .rs2_data_in(rs2_data_in),
        .rd_in(rd_in),

        .reg_write_in(reg_write_in),
        .mem_read_in(mem_read_in),
        .mem_write_in(mem_write_in),
        .mem_to_reg_in(mem_to_reg_in),

        .alu_result_out(alu_result_out),
        .rs2_data_out(rs2_data_out),
        .rd_out(rd_out),

        .reg_write_out(reg_write_out),
        .mem_read_out(mem_read_out),
        .mem_write_out(mem_write_out),
        .mem_to_reg_out(mem_to_reg_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        alu_result_in = 0;
        rs2_data_in = 0;
        rd_in = 0;

        reg_write_in = 0;
        mem_read_in = 0;
        mem_write_in = 0;
        mem_to_reg_in = 0;

        #10;
        reset = 0;

        alu_result_in = 32'h0000001E;
        rs2_data_in = 32'h00000014;
        rd_in = 5'd5;

        reg_write_in = 1;
        mem_read_in = 1;
        mem_write_in = 0;
        mem_to_reg_in = 1;

        #10;

        if (
            alu_result_out == 32'h0000001E &&
            rs2_data_out == 32'h00000014 &&
            rd_out == 5'd5 &&
            reg_write_out == 1 &&
            mem_read_out == 1 &&
            mem_write_out == 0 &&
            mem_to_reg_out == 1
        )
        begin
            $display("====================================");
            $display("EX/MEM PIPELINE REGISTER TEST PASSED");
            $display("====================================");
        end
        else begin
            $display("====================================");
            $display("EX/MEM PIPELINE REGISTER TEST FAILED");
            $display("====================================");
        end

        $stop;
    end

endmodule