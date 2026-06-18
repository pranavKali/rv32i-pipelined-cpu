module mem_wb_reg_tb;

    logic clk;
    logic reset;

    logic [31:0] alu_result_in;
    logic [31:0] mem_data_in;
    logic [4:0] rd_in;

    logic reg_write_in;
    logic mem_to_reg_in;

    logic [31:0] alu_result_out;
    logic [31:0] mem_data_out;
    logic [4:0] rd_out;

    logic reg_write_out;
    logic mem_to_reg_out;

    mem_wb_reg dut (
        .clk(clk),
        .reset(reset),

        .alu_result_in(alu_result_in),
        .mem_data_in(mem_data_in),
        .rd_in(rd_in),

        .reg_write_in(reg_write_in),
        .mem_to_reg_in(mem_to_reg_in),

        .alu_result_out(alu_result_out),
        .mem_data_out(mem_data_out),
        .rd_out(rd_out),

        .reg_write_out(reg_write_out),
        .mem_to_reg_out(mem_to_reg_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        alu_result_in = 0;
        mem_data_in = 0;
        rd_in = 0;
        reg_write_in = 0;
        mem_to_reg_in = 0;

        #10;
        reset = 0;

        alu_result_in = 32'h00000020;
        mem_data_in = 32'h00000099;
        rd_in = 5'd6;
        reg_write_in = 1;
        mem_to_reg_in = 1;

        #10;

        if (
            alu_result_out == 32'h00000020 &&
            mem_data_out == 32'h00000099 &&
            rd_out == 5'd6 &&
            reg_write_out == 1 &&
            mem_to_reg_out == 1
        ) begin
            $display("====================================");
            $display("MEM/WB PIPELINE REGISTER TEST PASSED");
            $display("====================================");
        end
        else begin
            $display("====================================");
            $display("MEM/WB PIPELINE REGISTER TEST FAILED");
            $display("====================================");
        end

        $stop;
    end

endmodule