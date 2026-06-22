module final_memory_cpu_tb;

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
        // x1 = 42
        // sw x1, 0(x0)
        // lw x2, 0(x0)

        dut.imem_inst.memory[0] = 32'h02A00093; // addi x1, x0, 42
        dut.imem_inst.memory[1] = 32'h00102023; // sw x1, 0(x0)
        dut.imem_inst.memory[2] = 32'h00002103; // lw x2, 0(x0)

        #10;
        reset = 0;

        #250;

        if (dut.reg_file_inst.regs[2] == 32'd42) begin

            $display("====================================");
            $display("FINAL MEMORY CPU TEST PASSED");
            $display("memory[0] = %0d", dut.data_memory_inst.memory[0]);
            $display("x2 = %0d", dut.reg_file_inst.regs[2]);
            $display("====================================");

        end
        else begin

            $display("====================================");
            $display("FINAL MEMORY CPU TEST FAILED");
            $display("memory[0] = %0d", dut.data_memory_inst.memory[0]);
            $display("x2 = %0d", dut.reg_file_inst.regs[2]);
            $display("====================================");

        end

        $stop;
    end

endmodule