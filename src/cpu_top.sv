module cpu_top (
    input  logic clk,
    input  logic rst_n,

    output logic [31:0] instruction
);

    logic reg_write;
    logic alu_src;
    logic mem_read;
    logic mem_write;
    logic mem_to_reg;
    logic branch;
    logic [1:0] alu_op;
    logic [3:0] alu_sel;
    logic zero;

    control_unit control_inst (
        .opcode(instruction[6:0]),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .alu_op(alu_op)
    );

    alu_control alu_control_inst (
        .alu_op(alu_op),
        .funct3(instruction[14:12]),
        .funct7_5(instruction[30]),
        .alu_sel(alu_sel)
    );

    datapath datapath_inst (
        .clk(clk),
        .rst_n(rst_n),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .alu_sel(alu_sel),
        .instruction(instruction),
        .zero(zero)
    );

endmodule