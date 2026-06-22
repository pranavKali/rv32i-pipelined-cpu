module forwarding_unit_tb;

    logic [4:0] id_ex_rs1, id_ex_rs2;
    logic [4:0] ex_mem_rd, mem_wb_rd;
    logic ex_mem_reg_write, mem_wb_reg_write;
    logic [1:0] forward_a, forward_b;

    forwarding_unit dut (
        .id_ex_rs1(id_ex_rs1),
        .id_ex_rs2(id_ex_rs2),
        .ex_mem_rd(ex_mem_rd),
        .ex_mem_reg_write(ex_mem_reg_write),
        .mem_wb_rd(mem_wb_rd),
        .mem_wb_reg_write(mem_wb_reg_write),
        .forward_a(forward_a),
        .forward_b(forward_b)
    );

    initial begin
        id_ex_rs1 = 5'd1;
        id_ex_rs2 = 5'd2;
        ex_mem_rd = 5'd1;
        mem_wb_rd = 5'd2;
        ex_mem_reg_write = 1;
        mem_wb_reg_write = 1;

        #10;

        if (forward_a == 2'b10 && forward_b == 2'b01) begin
            $display("====================================");
            $display("FORWARDING UNIT TEST PASSED");
            $display("====================================");
        end else begin
            $display("====================================");
            $display("FORWARDING UNIT TEST FAILED");
            $display("forward_a = %b", forward_a);
            $display("forward_b = %b", forward_b);
            $display("====================================");
        end

        $stop;
    end

endmodule