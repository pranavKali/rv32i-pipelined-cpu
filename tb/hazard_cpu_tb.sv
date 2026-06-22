module hazard_cpu_tb;

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

        // Put test data directly into data memory
        dut.data_memory_inst.memory[0] = 32'd7;

        // Override instruction memory for load-use hazard test
        dut.imem_inst.memory[0] = 32'h00002083; // lw x1, 0(x0)
        dut.imem_inst.memory[1] = 32'h00108133; // add x2, x1, x1

        #10;
        reset = 0;

        #200;

        if (dut.reg_file_inst.regs[1] == 32'd7 &&
            dut.reg_file_inst.regs[2] == 32'd14) begin

            $display("====================================");
            $display("LOAD-USE HAZARD TEST PASSED");
            $display("x1 = %0d", dut.reg_file_inst.regs[1]);
            $display("x2 = %0d", dut.reg_file_inst.regs[2]);
            $display("====================================");

        end else begin

            $display("====================================");
            $display("LOAD-USE HAZARD TEST FAILED");
            $display("x1 = %0d", dut.reg_file_inst.regs[1]);
            $display("x2 = %0d", dut.reg_file_inst.regs[2]);
            $display("====================================");

        end

        $stop;
    end

endmodule