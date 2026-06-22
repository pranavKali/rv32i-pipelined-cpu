module hazard_detection_unit_tb;

    logic id_ex_mem_read;
    logic [4:0] id_ex_rd;

    logic [4:0] if_id_rs1;
    logic [4:0] if_id_rs2;

    logic stall;

    hazard_detection_unit dut (
        .id_ex_mem_read(id_ex_mem_read),
        .id_ex_rd(id_ex_rd),
        .if_id_rs1(if_id_rs1),
        .if_id_rs2(if_id_rs2),
        .stall(stall)
    );

    initial begin

        id_ex_mem_read = 1;
        id_ex_rd = 5'd1;

        if_id_rs1 = 5'd1;
        if_id_rs2 = 5'd3;

        #10;

        if (stall)
            $display("HAZARD DETECTION TEST PASSED");
        else
            $display("HAZARD DETECTION TEST FAILED");

        $stop;
    end

endmodule