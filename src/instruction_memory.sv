module instruction_memory (

    input  logic [31:0] address,
    output logic [31:0] instruction

);

    logic [31:0] memory [0:255];

    initial begin

        // Example instructions
        memory[0] = 32'h00500093; // addi x1,x0,5
        memory[1] = 32'h00A00113; // addi x2,x0,10
        memory[2] = 32'h002081B3; // add x3,x1,x2

    end

    assign instruction = memory[address[31:2]];

endmodule