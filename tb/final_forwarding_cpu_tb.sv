module final_forwarding_cpu_tb;

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

        dut.imem_inst.memory[0] = 32'h00500093; // addi x1, x0, 5
        dut.imem_inst.memory[1] = 32'h00108133; // add x2, x1, x1
        dut.imem_inst.memory[2] = 32'h001101B3; // add x3, x2, x1
        dut.imem_inst.memory[3] = 32'h00218233; // add x4, x3, x2

        // NOPs to drain pipeline
        dut.imem_inst.memory[4] = 32'h00000013;
        dut.imem_inst.memory[5] = 32'h00000013;
        dut.imem_inst.memory[6] = 32'h00000013;
        dut.imem_inst.memory[7] = 32'h00000013;

        #10;
        reset = 0;

        #400;

        if (dut.reg_file_inst.regs[1] == 32'd5  &&
            dut.reg_file_inst.regs[2] == 32'd10 &&
            dut.reg_file_inst.regs[3] == 32'd15 &&
            dut.reg_file_inst.regs[4] == 32'd25) begin

            $display("====================================");
            $display("FINAL FORWARDING CPU TEST PASSED");
            $display("x1 = %0d", dut.reg_file_inst.regs[1]);
            $display("x2 = %0d", dut.reg_file_inst.regs[2]);
            $display("x3 = %0d", dut.reg_file_inst.regs[3]);
            $display("x4 = %0d", dut.reg_file_inst.regs[4]);
            $display("====================================");

        end else begin

            $display("====================================");
            $display("FINAL FORWARDING CPU TEST FAILED");
            $display("x1 = %0d", dut.reg_file_inst.regs[1]);
            $display("x2 = %0d", dut.reg_file_inst.regs[2]);
            $display("x3 = %0d", dut.reg_file_inst.regs[3]);
            $display("x4 = %0d", dut.reg_file_inst.regs[4]);
            $display("====================================");

        end

        $stop;
    end

endmodule