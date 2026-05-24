module datapath (

    input logic clk,
    input logic rst_n,

    input logic reg_write,
    input logic alu_src,
    input logic mem_read,
    input logic mem_write,
    input logic mem_to_reg,
    input logic branch,
    input logic [3:0] alu_sel,

    output logic [31:0] instruction,
    output logic zero

);

    logic [31:0] pc;
    logic [31:0] pc_next;
    logic [31:0] pc_plus_4;

    logic [31:0] rd1;
    logic [31:0] rd2;
    logic [31:0] imm;

    logic [31:0] alu_in2;
    logic [31:0] alu_result;

    logic [31:0] mem_read_data;
    logic [31:0] write_back_data;

    assign pc_plus_4 = pc + 32'd4;
    assign pc_next = pc_plus_4;

    program_counter pc_inst(
        .clk(clk),
        .rst_n(rst_n),
        .pc_next(pc_next),
        .pc(pc)
    );

    instruction_memory imem_inst(
        .address(pc),
        .instruction(instruction)
    );

    reg_file regfile_inst(
        .clk(clk),
        .rst_n(rst_n),
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),
        .wd(write_back_data),
        .reg_write(reg_write),
        .rd1(rd1),
        .rd2(rd2)
    );

    imm_gen imm_inst(
        .instr(instruction),
        .imm(imm)
    );

endmodule