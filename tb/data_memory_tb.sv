module data_memory_tb;

    logic clk;
    logic mem_write;
    logic mem_read;
    logic [31:0] address;
    logic [31:0] write_data;
    logic [31:0] read_data;

    data_memory dut (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    always #5 clk = ~clk;

    task check;
        input [31:0] expected;
        begin
            #1;
            if (read_data !== expected)
                $display("FAIL: expected=%0d got=%0d", expected, read_data);
            else
                $display("PASS: read_data=%0d", read_data);
        end
    endtask

    initial begin
        clk = 0;
        mem_write = 0;
        mem_read = 0;
        address = 32'd0;
        write_data = 32'd0;

        // Write 123 to address 0
        address = 32'd0;
        write_data = 32'd123;
        mem_write = 1;
        #10;
        mem_write = 0;

        // Read address 0
        mem_read = 1;
        check(32'd123);

        // Write 999 to address 4
        mem_read = 0;
        address = 32'd4;
        write_data = 32'd999;
        mem_write = 1;
        #10;
        mem_write = 0;

        // Read address 4
        mem_read = 1;
        check(32'd999);

        // If mem_read is off, output should be 0
        mem_read = 0;
        #1;
        check(32'd0);

        $finish;
    end

endmodule