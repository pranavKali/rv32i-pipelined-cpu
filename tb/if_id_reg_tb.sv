module if_id_reg_tb;

    logic clk;
    logic reset;

    logic [31:0] pc_in;
    logic [31:0] instruction_in;

    logic [31:0] pc_out;
    logic [31:0] instruction_out;

    if_id_reg dut (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .instruction_in(instruction_in),
        .pc_out(pc_out),
        .instruction_out(instruction_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        pc_in = 0;
        instruction_in = 0;

        #10;
        reset = 0;

        pc_in = 32'h00000004;
        instruction_in = 32'h00A00093;

        #10;

        pc_in = 32'h00000008;
        instruction_in = 32'h00100113;

        #10;

        $stop;
    end

endmodule