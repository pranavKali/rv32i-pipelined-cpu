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

        #1;
        $display("Instruction 1: %h", instruction);

        #10;
        $display("Instruction 2: %h", instruction);

        #10;
        $display("Instruction 3: %h", instruction);

        #10;
        $display("Instruction 4: %h", instruction);

        $finish;
    end

endmodule