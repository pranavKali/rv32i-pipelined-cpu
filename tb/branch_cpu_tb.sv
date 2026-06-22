module branch_cpu_tb;

    logic clk;
    logic reset;

    pipelined_cpu dut (
        .clk(clk),
        .reset(reset)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        // Program:
        // x1 = 5
        // x2 = 5
        // beq x1, x2, +8
        // x3 = 99   should be skipped
        // x4 = 7    should execute

        dut.imem_inst.memory[0] = 32'h00500093; // addi x1, x0, 5
        dut.imem_inst.memory[1] = 32'h00500113; // addi x2, x0, 5
        dut.imem_inst.memory[2] = 32'h00208463; // beq x1, x2, +8
        dut.imem_inst.memory[3] = 32'h06300193; // addi x3, x0, 99
        dut.imem_inst.memory[4] = 32'h00700213; // addi x4, x0, 7

        #10;
        reset = 0;

        #250;

        if (dut.reg_file_inst.regs[3] == 32'd0 &&
            dut.reg_file_inst.regs[4] == 32'd7) begin

            $display("====================================");
            $display("BRANCH CPU TEST PASSED");
            $display("x3 = %0d", dut.reg_file_inst.regs[3]);
            $display("x4 = %0d", dut.reg_file_inst.regs[4]);
            $display("====================================");

        end else begin

            $display("====================================");
            $display("BRANCH CPU TEST FAILED");
            $display("x3 = %0d", dut.reg_file_inst.regs[3]);
            $display("x4 = %0d", dut.reg_file_inst.regs[4]);
            $display("====================================");

        end

        $stop;
    end

endmodule