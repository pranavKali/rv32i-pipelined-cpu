module alu_control_tb;

    logic [1:0] alu_op;
    logic [2:0] funct3;
    logic       funct7_5;
    logic [3:0] alu_sel;

    alu_control dut (
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7_5(funct7_5),
        .alu_sel(alu_sel)
    );

    task check;
        input [3:0] expected;
        begin
            #10;
            if (alu_sel !== expected)
                $display("FAIL: alu_op=%b funct3=%b funct7_5=%b expected=%b got=%b",
                         alu_op, funct3, funct7_5, expected, alu_sel);
            else
                $display("PASS: alu_sel=%b", alu_sel);
        end
    endtask

    initial begin
        alu_op = 2'b00; funct3 = 3'b000; funct7_5 = 0; check(4'b0000); // load/store ADD
        alu_op = 2'b01; funct3 = 3'b000; funct7_5 = 0; check(4'b0001); // branch SUB

        alu_op = 2'b10; funct3 = 3'b000; funct7_5 = 0; check(4'b0000); // ADD
        alu_op = 2'b10; funct3 = 3'b000; funct7_5 = 1; check(4'b0001); // SUB
        alu_op = 2'b10; funct3 = 3'b111; funct7_5 = 0; check(4'b0010); // AND
        alu_op = 2'b10; funct3 = 3'b110; funct7_5 = 0; check(4'b0011); // OR
        alu_op = 2'b10; funct3 = 3'b100; funct7_5 = 0; check(4'b0100); // XOR
        alu_op = 2'b10; funct3 = 3'b001; funct7_5 = 0; check(4'b0101); // SLL
        alu_op = 2'b10; funct3 = 3'b101; funct7_5 = 0; check(4'b0110); // SRL

        alu_op = 2'b11; funct3 = 3'b000; funct7_5 = 0; check(4'b0000); // ADDI
        alu_op = 2'b11; funct3 = 3'b111; funct7_5 = 0; check(4'b0010); // ANDI
        alu_op = 2'b11; funct3 = 3'b110; funct7_5 = 0; check(4'b0011); // ORI

        $finish;
    end

endmodule