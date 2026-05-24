module instruction_memory_tb;

    logic [31:0] address;
    logic [31:0] instruction;

    instruction_memory dut (
        .address(address),
        .instruction(instruction)
    );

    task check;
        input [31:0] expected;
        begin
            #10;
            if (instruction !== expected)
                $display("FAIL: address=%0d expected=%h got=%h",
                         address, expected, instruction);
            else
                $display("PASS: address=%0d instruction=%h",
                         address, instruction);
        end
    endtask

    initial begin

        address = 32'd0;
        check(32'h00500093); // addi x1,x0,5

        address = 32'd4;
        check(32'h00A00113); // addi x2,x0,10

        address = 32'd8;
        check(32'h002081B3); // add x3,x1,x2

        $finish;

    end

endmodule