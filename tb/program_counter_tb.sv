module program_counter_tb;

    logic clk;
    logic rst_n;
    logic [31:0] pc_next;
    logic [31:0] pc;

    program_counter dut (
        .clk(clk),
        .rst_n(rst_n),
        .pc_next(pc_next),
        .pc(pc)
    );

    always #5 clk = ~clk;

    task check;
        input [31:0] expected;
        begin
            #1;
            if (pc !== expected)
                $display("FAIL: expected pc=%0d got pc=%0d", expected, pc);
            else
                $display("PASS: pc=%0d", pc);
        end
    endtask

    initial begin
        clk = 0;
        rst_n = 0;
        pc_next = 32'd0;

        #10;
        check(32'd0);

        rst_n = 1;

        pc_next = 32'd4;
        #10;
        check(32'd4);

        pc_next = 32'd8;
        #10;
        check(32'd8);

        pc_next = 32'd100;
        #10;
        check(32'd100);

        rst_n = 0;
        #10;
        check(32'd0);

        $finish;
    end

endmodule