module imm_gen_tb;

    logic [31:0] instr;
    logic [31:0] imm;

    imm_gen dut (
        .instr(instr),
        .imm(imm)
    );

    task check;
        input [31:0] expected;
        begin
            #10;
            if (imm !== expected)
                $display("FAIL: expected %0d got %0d", expected, imm);
            else
                $display("PASS: imm = %0d", imm);
        end
    endtask

    initial begin
        // I-type: imm = 5
        instr = {12'd5, 5'd0, 3'b000, 5'd1, 7'b0010011};
        check(32'd5);

        // I-type: imm = -1
        instr = {12'hFFF, 5'd0, 3'b000, 5'd1, 7'b0010011};
        check(32'hFFFFFFFF);

        // Store: imm = 8
        instr = {7'b0000000, 5'd2, 5'd1, 3'b010, 5'b01000, 7'b0100011};
        check(32'd8);

        // Branch: imm = 4
        instr = {1'b0, 6'b000000, 5'd2, 5'd1, 3'b000, 4'b0010, 1'b0, 7'b1100011};
        check(32'd4);

        $finish;
    end

endmodule