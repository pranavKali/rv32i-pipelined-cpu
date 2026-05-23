module control_unit (

    input  logic [6:0] opcode,

    output logic reg_write,
    output logic alu_src,
    output logic mem_read,
    output logic mem_write,
    output logic branch,
    output logic [1:0] alu_op

);

always_comb begin

    reg_write = 0;
    alu_src   = 0;
    mem_read  = 0;
    mem_write = 0;
    branch    = 0;
    alu_op    = 2'b00;

    case(opcode)

        7'b0110011: begin // R-type
            reg_write = 1;
            alu_op = 2'b10;
        end

        7'b0010011: begin // I-type
            reg_write = 1;
            alu_src = 1;
            alu_op = 2'b11;
        end

        7'b0000011: begin // Load
            reg_write = 1;
            alu_src = 1;
            mem_read = 1;
        end

        7'b0100011: begin // Store
            alu_src = 1;
            mem_write = 1;
        end

        7'b1100011: begin // Branch
            branch = 1;
            alu_op = 2'b01;
        end

    endcase

end

endmodule