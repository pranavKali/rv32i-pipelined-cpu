module id_ex_reg (
    input logic clk,
    input logic reset,
    input logic bubble,

    input logic [31:0] pc_in,
    input logic [31:0] rs1_data_in,
    input logic [31:0] rs2_data_in,
    input logic [31:0] imm_in,

    input logic [4:0] rs1_in,
    input logic [4:0] rs2_in,
    input logic [4:0] rd_in,

    input logic [2:0] funct3_in,
    input logic funct7_5_in,

    input logic reg_write_in,
    input logic mem_read_in,
    input logic mem_write_in,
    input logic mem_to_reg_in,
    input logic alu_src_in,
    input logic branch_in,
    input logic [1:0] alu_op_in,

    output logic [31:0] pc_out,
    output logic [31:0] rs1_data_out,
    output logic [31:0] rs2_data_out,
    output logic [31:0] imm_out,

    output logic [4:0] rs1_out,
    output logic [4:0] rs2_out,
    output logic [4:0] rd_out,

    output logic [2:0] funct3_out,
    output logic funct7_5_out,

    output logic reg_write_out,
    output logic mem_read_out,
    output logic mem_write_out,
    output logic mem_to_reg_out,
    output logic alu_src_out,
    output logic branch_out,
    output logic [1:0] alu_op_out
);

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        pc_out <= 0;
        rs1_data_out <= 0;
        rs2_data_out <= 0;
        imm_out <= 0;

        rs1_out <= 0;
        rs2_out <= 0;
        rd_out <= 0;

        funct3_out <= 0;
        funct7_5_out <= 0;

        reg_write_out <= 0;
        mem_read_out <= 0;
        mem_write_out <= 0;
        mem_to_reg_out <= 0;
        alu_src_out <= 0;
        branch_out <= 0;
        alu_op_out <= 0;
    end
    else if (bubble) begin
        pc_out <= 0;
        rs1_data_out <= 0;
        rs2_data_out <= 0;
        imm_out <= 0;

        rs1_out <= 0;
        rs2_out <= 0;
        rd_out <= 0;

        funct3_out <= 0;
        funct7_5_out <= 0;

        reg_write_out <= 0;
        mem_read_out <= 0;
        mem_write_out <= 0;
        mem_to_reg_out <= 0;
        alu_src_out <= 0;
        branch_out <= 0;
        alu_op_out <= 0;
    end
    else begin
        pc_out <= pc_in;
        rs1_data_out <= rs1_data_in;
        rs2_data_out <= rs2_data_in;
        imm_out <= imm_in;

        rs1_out <= rs1_in;
        rs2_out <= rs2_in;
        rd_out <= rd_in;

        funct3_out <= funct3_in;
        funct7_5_out <= funct7_5_in;

        reg_write_out <= reg_write_in;
        mem_read_out <= mem_read_in;
        mem_write_out <= mem_write_in;
        mem_to_reg_out <= mem_to_reg_in;
        alu_src_out <= alu_src_in;
        branch_out <= branch_in;
        alu_op_out <= alu_op_in;
    end
end

endmodule