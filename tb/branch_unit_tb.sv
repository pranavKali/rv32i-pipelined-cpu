module branch_unit_tb;

    logic branch;
    logic zero;
    logic branch_taken;

    branch_unit dut (
        .branch(branch),
        .zero(zero),
        .branch_taken(branch_taken)
    );

    initial begin
        branch = 0;
        zero = 0;
        #10;

        branch = 1;
        zero = 0;
        #10;

        branch = 1;
        zero = 1;
        #10;

        if (branch_taken) begin
            $display("====================================");
            $display("BRANCH UNIT TEST PASSED");
            $display("====================================");
        end else begin
            $display("====================================");
            $display("BRANCH UNIT TEST FAILED");
            $display("====================================");
        end

        $stop;
    end

endmodule