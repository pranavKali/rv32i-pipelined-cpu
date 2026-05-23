module control_unit_tb;

    logic [6:0] opcode;

    logic reg_write;
    logic alu_src;
    logic mem_read;
    logic mem_write;
    logic branch;
    logic [1:0] alu_op;

    control_unit dut (
        .opcode(opcode),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .alu_op(alu_op)
    );

    task check;
        input expected_reg_write;
        input expected_alu_src;
        input expected_mem_read;
        input expected_mem_write;
        input expected_branch;
        input [1:0] expected_alu_op;

        begin
            #10;

            if (
                reg_write !== expected_reg_write ||
                alu_src   !== expected_alu_src   ||
                mem_read  !== expected_mem_read  ||
                mem_write !== expected_mem_write ||
                branch    !== expected_branch    ||
                alu_op    !== expected_alu_op
            )
                $display("FAIL: opcode=%b", opcode);
            else
                $display("PASS: opcode=%b", opcode);
        end
    endtask

    initial begin

        // R-type
        opcode = 7'b0110011;
        check(1, 0, 0, 0, 0, 2'b10);

        // I-type
        opcode = 7'b0010011;
        check(1, 1, 0, 0, 0, 2'b11);

        // Load
        opcode = 7'b0000011;
        check(1, 1, 1, 0, 0, 2'b00);

        // Store
        opcode = 7'b0100011;
        check(0, 1, 0, 1, 0, 2'b00);

        // Branch
        opcode = 7'b1100011;
        check(0, 0, 0, 0, 1, 2'b01);

        // Unknown opcode
        opcode = 7'b1111111;
        check(0, 0, 0, 0, 0, 2'b00);

        $finish;

    end

endmodule