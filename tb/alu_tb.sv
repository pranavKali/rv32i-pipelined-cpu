module alu_tb;

    logic [31:0] a;
    logic [31:0] b;
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

    initial begin

        // ADD
        a = 10;
        b = 5;
        alu_sel = 4'b0000;
        #10;

        // SUB
        alu_sel = 4'b0001;
        #10;

        // AND
        alu_sel = 4'b0010;
        #10;

        // OR
        alu_sel = 4'b0011;
        #10;

        // XOR
        alu_sel = 4'b0100;
        #10;

        // SLL
        alu_sel = 4'b0101;
        #10;

        // SRL
        alu_sel = 4'b0110;
        #10;

        $finish;

    end

endmodule