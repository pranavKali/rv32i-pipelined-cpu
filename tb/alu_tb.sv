module alu_tb;

    logic [31:0] a, b;
    logic [3:0] alu_sel;
    logic [31:0] result;
    logic zero;

    alu dut (
        .a(a),
        .b(b),
        .alu_sel(alu_sel),
        .result(result),
        .zero(zero)
    );

    task check;
        input [31:0] expected;
        begin
            #10;
            if (result !== expected)
                $display("FAIL: alu_sel=%b expected=%0d got=%0d", alu_sel, expected, result);
            else
                $display("PASS: alu_sel=%b result=%0d", alu_sel, result);
        end
    endtask

    initial begin
        a = 10; b = 5;

        alu_sel = 4'b0000; check(15);          // ADD
        alu_sel = 4'b0001; check(5);           // SUB
        alu_sel = 4'b0010; check(10 & 5);      // AND
        alu_sel = 4'b0011; check(10 | 5);      // OR
        alu_sel = 4'b0100; check(10 ^ 5);      // XOR
        alu_sel = 4'b0101; check(10 << 5);     // SLL
        alu_sel = 4'b0110; check(10 >> 5);     // SRL

        a = 5; b = 5;
        alu_sel = 4'b0001; check(0);           // zero test

        if (zero !== 1'b1)
            $display("FAIL: zero flag expected 1 got %b", zero);
        else
            $display("PASS: zero flag works");

        $finish;
    end

endmodule