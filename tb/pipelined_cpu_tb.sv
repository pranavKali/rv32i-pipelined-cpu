module pipelined_cpu_tb;

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

        #10;
        reset = 0;

        #100;

        if (dut.reg_file_inst.regs[1] == 32'd5 &&
            dut.reg_file_inst.regs[2] == 32'd10 &&
            dut.reg_file_inst.regs[3] == 32'd15) begin

            $display("====================================");
            $display("PIPELINED CPU DEPENDENCY TEST PASSED");
            $display("x1 = %0d", dut.reg_file_inst.regs[1]);
            $display("x2 = %0d", dut.reg_file_inst.regs[2]);
            $display("x3 = %0d", dut.reg_file_inst.regs[3]);
            $display("====================================");

        end else begin

            $display("====================================");
            $display("PIPELINED CPU DEPENDENCY TEST FAILED");
            $display("x1 = %0d", dut.reg_file_inst.regs[1]);
            $display("x2 = %0d", dut.reg_file_inst.regs[2]);
            $display("x3 = %0d", dut.reg_file_inst.regs[3]);
            $display("====================================");

        end

        $stop;
    end

endmodule