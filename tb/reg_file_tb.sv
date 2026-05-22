module reg_file_tb;

    logic clk;
    logic rst_n;

    logic [4:0] rs1, rs2, rd;
    logic [31:0] wd;
    logic reg_write;

    logic [31:0] rd1, rd2;

    reg_file dut (
        .clk(clk),
        .rst_n(rst_n),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wd(wd),
        .reg_write(reg_write),
        .rd1(rd1),
        .rd2(rd2)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst_n = 0;
        reg_write = 0;

        #10;
        rst_n = 1;

        // Write 123 to x1
        rd = 5'd1;
        wd = 32'd123;
        reg_write = 1;

        #10;

        // Read x1
        rs1 = 5'd1;

        #1;
        if (rd1 !== 32'd123)
            $display("FAIL: x1 expected 123 got %0d", rd1);
        else
            $display("PASS: x1 correctly stores 123");

        // Try writing to x0
        rd = 5'd0;
        wd = 32'd999;

        #10;

        rs1 = 5'd0;

        #1;
        if (rd1 !== 32'd0)
            $display("FAIL: x0 changed value");
        else
            $display("PASS: x0 remains zero");

        $finish;

    end

endmodule