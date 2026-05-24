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

    logic [31:0] pc, pc_next, pc_plus_4;
    logic [31:0] rd1, rd2, imm;
    logic [31:0] alu_in2, alu_result;
    logic [31:0] mem_read_data, write_back_data;
    logic [31:0] branch_target;

    assign pc_plus_4 = pc + 32'd4;
    assign branch_target = pc + imm;

    assign pc_next =
        (branch && zero) ?
        branch_target :
        pc_plus_4;

    assign alu_in2 =
        (alu_src) ?
        imm :
        rd2;

    assign write_back_data =
        (mem_to_reg) ?
        mem_read_data :
        alu_result;

    program_counter pc_inst (
        .clk(clk),
        .rst_n(rst_n),
        .pc_next(pc_next),
        .pc(pc)
    );

    instruction_memory imem_inst (
        .address(pc),
        .instruction(instruction)
    );

    reg_file regfile_inst (
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

    imm_gen imm_inst (
        .instr(instruction),
        .imm(imm)
    );

    alu alu_inst (
        .a(rd1),
        .b(alu_in2),
        .alu_sel(alu_sel),
        .result(alu_result),
        .zero(zero)
    );

    data_memory dmem_inst (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .address(alu_result),
        .write_data(rd2),
        .read_data(mem_read_data)
    );

endmodule