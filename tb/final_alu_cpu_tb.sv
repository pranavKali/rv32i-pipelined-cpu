module final_alu_cpu_tb;

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
        // x1 = 12
        // x2 = 5
        // x3 = x1 + x2 = 17
        // x4 = x1 - x2 = 7
        // x5 = x1 & x2 = 4
        // x6 = x1 | x2 = 13
        // x7 = x1 ^ x2 = 9

        dut.imem_inst.memory[0] = 32'h00C00093; // addi x1, x0, 12
        dut.imem_inst.memory[1] = 32'h00500113; // addi x2, x0, 5
        dut.imem_inst.memory[2] = 32'h002081B3; // add x3, x1, x2
        dut.imem_inst.memory[3] = 32'h40208233; // sub x4, x1, x2
        dut.imem_inst.memory[4] = 32'h0020F2B3; // and x5, x1, x2
        dut.imem_inst.memory[5] = 32'h0020E333; // or  x6, x1, x2
        dut.imem_inst.memory[6] = 32'h0020C3B3; // xor x7, x1, x2

        #10;
        reset = 0;

        #300;

        if (dut.reg_file_inst.regs[3] == 32'd17 &&
            dut.reg_file_inst.regs[4] == 32'd7  &&
            dut.reg_file_inst.regs[5] == 32'd4  &&
            dut.reg_file_inst.regs[6] == 32'd13 &&
            dut.reg_file_inst.regs[7] == 32'd9) begin

            $display("====================================");
            $display("FINAL ALU CPU TEST PASSED");
            $display("x3 = %0d", dut.reg_file_inst.regs[3]);
            $display("x4 = %0d", dut.reg_file_inst.regs[4]);
            $display("x5 = %0d", dut.reg_file_inst.regs[5]);
            $display("x6 = %0d", dut.reg_file_inst.regs[6]);
            $display("x7 = %0d", dut.reg_file_inst.regs[7]);
            $display("====================================");

        end else begin

            $display("====================================");
            $display("FINAL ALU CPU TEST FAILED");
            $display("x3 = %0d", dut.reg_file_inst.regs[3]);
            $display("x4 = %0d", dut.reg_file_inst.regs[4]);
            $display("x5 = %0d", dut.reg_file_inst.regs[5]);
            $display("x6 = %0d", dut.reg_file_inst.regs[6]);
            $display("x7 = %0d", dut.reg_file_inst.regs[7]);
            $display("====================================");

        end

        $stop;
    end

endmodule