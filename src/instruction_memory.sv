module instruction_memory (

    input  logic [31:0] address,
    output logic [31:0] instruction

);

    logic [31:0] memory [0:255];

    initial begin

        // x1 = 5
        memory[0] = 32'h00500093; // addi x1, x0, 5

        // x2 = 10
        memory[1] = 32'h00A00113; // addi x2, x0, 10

        // x3 = x1 + x2 = 15
        memory[2] = 32'h002081B3; // add x3, x1, x2

        // memory[0] = x3
        memory[3] = 32'h00302023; // sw x3, 0(x0)

        // x4 = memory[0]
        memory[4] = 32'h00002203; // lw x4, 0(x0)

    end

    assign instruction = memory[address[31:2]];

endmodule