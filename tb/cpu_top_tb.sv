module cpu_top_tb;

    logic clk;
    logic rst_n;
    logic [31:0] instruction;

    cpu_top dut (
        .clk(clk),
        .rst_n(rst_n),
        .instruction(instruction)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst_n = 0;

        #10;
        rst_n = 1;

        repeat(10) begin
            #10;
            $display("Instruction: %h", instruction);
        end

        $display("x1 = %0d", dut.datapath_inst.regfile_inst.regs[1]);
        $display("x2 = %0d", dut.datapath_inst.regfile_inst.regs[2]);
        $display("x3 = %0d", dut.datapath_inst.regfile_inst.regs[3]);
        $display("x4 = %0d", dut.datapath_inst.regfile_inst.regs[4]);

        $display("Memory[0] = %0d",
            dut.datapath_inst.dmem_inst.memory[0]);

        $finish;

    end

endmodule