module alu_control (
    input  logic [1:0] alu_op,
    input  logic [2:0] funct3,
    input  logic       funct7_5,

    output logic [3:0] alu_sel
);

always_comb begin
    case (alu_op)

        2'b00: alu_sel = 4'b0000; // ADD for load/store
        2'b01: alu_sel = 4'b0001; // SUB for branch compare

        2'b10: begin // R-type
            case ({funct7_5, funct3})
                4'b0000: alu_sel = 4'b0000; // ADD
                4'b1000: alu_sel = 4'b0001; // SUB
                4'b0111: alu_sel = 4'b0010; // AND
                4'b0110: alu_sel = 4'b0011; // OR
                4'b0100: alu_sel = 4'b0100; // XOR
                4'b0001: alu_sel = 4'b0101; // SLL
                4'b0101: alu_sel = 4'b0110; // SRL
                default: alu_sel = 4'b0000;
            endcase
        end

        2'b11: begin // I-type
            case (funct3)
                3'b000: alu_sel = 4'b0000; // ADDI
                3'b111: alu_sel = 4'b0010; // ANDI
                3'b110: alu_sel = 4'b0011; // ORI
                3'b100: alu_sel = 4'b0100; // XORI
                3'b001: alu_sel = 4'b0101; // SLLI
                3'b101: alu_sel = 4'b0110; // SRLI
                default: alu_sel = 4'b0000;
            endcase
        end

        default: alu_sel = 4'b0000;

    endcase
end

endmodule