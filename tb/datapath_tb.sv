module datapath_tb;

    logic clk;
    logic rst_n;

    logic reg_write;
    logic alu_src;
    logic mem_read;
    logic mem_write;
    logic mem_to_reg;
    logic branch;
    logic [3:0] alu_sel;

    logic [31:0] instruction;
    logic zero;

    datapath dut (
        .clk(clk),
        .rst_n(rst_n),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .alu_sel(alu_sel),
        .instruction(instruction),
        .zero(zero)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;

        reg_write = 0;
        alu_src = 0;
        mem_read = 0;
        mem_write = 0;
        mem_to_reg = 0;
        branch = 0;
        alu_sel = 4'b0000;

        #10;
        rst_n = 1;

        #1;
        $display("Instruction 1: %h", instruction);

        #10;
        $display("Instruction 2: %h", instruction);

        #10;
        $display("Instruction 3: %h", instruction);

        $finish;
    end

endmodule