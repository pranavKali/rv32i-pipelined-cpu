module pipelined_cpu (
    input logic clk,
    input logic reset
);

    // =========================
    // IF Stage
    // =========================
    logic [31:0] pc_current;
    logic [31:0] pc_next;
    logic [31:0] instruction;

    logic stall;
    logic branch_taken;
    logic [31:0] branch_target;

    always_comb begin
        if (stall)
            pc_next = pc_current;
        else if (branch_taken)
            pc_next = branch_target;
        else
            pc_next = pc_current + 32'd4;
    end

    program_counter pc_inst (
        .clk(clk),
        .rst_n(~reset),
        .pc_next(pc_next),
        .pc(pc_current)
    );

    instruction_memory imem_inst (
        .address(pc_current),
        .instruction(instruction)
    );

    // =========================
    // IF/ID Register
    // =========================
    logic [31:0] if_id_pc;
    logic [31:0] if_id_instruction;

    if_id_reg if_id_inst (
        .clk(clk),
        .reset(reset),
        .stall(stall),
        .flush(branch_taken),
        .pc_in(pc_current),
        .instruction_in(instruction),
        .pc_out(if_id_pc),
        .instruction_out(if_id_instruction)
    );

    // =========================
    // ID Stage
    // =========================
    logic [6:0] opcode;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
    logic [2:0] funct3;
    logic       funct7_5;

    logic [31:0] rs1_data;
    logic [31:0] rs2_data;
    logic [31:0] imm;

    logic        reg_write;
    logic        mem_read;
    logic        mem_write;
    logic        mem_to_reg;
    logic        alu_src;
    logic        branch;
    logic [1:0]  alu_op;

    assign opcode   = if_id_instruction[6:0];
    assign rd       = if_id_instruction[11:7];
    assign funct3   = if_id_instruction[14:12];
    assign rs1      = if_id_instruction[19:15];
    assign rs2      = if_id_instruction[24:20];
    assign funct7_5 = if_id_instruction[30];

    control_unit control_inst (
        .opcode(opcode),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .alu_op(alu_op)
    );

    imm_gen imm_gen_inst (
        .instr(if_id_instruction),
        .imm(imm)
    );

    // =========================
    // WB Stage wires
    // (declared early so reg_file can reference wb_rd/wb_reg_write)
    // =========================
    logic [31:0] wb_data;
    logic [4:0]  wb_rd;
    logic        wb_reg_write;

    reg_file reg_file_inst (
        .clk(clk),
        .rst_n(~reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(wb_rd),
        .wd(wb_data),
        .reg_write(wb_reg_write),
        .rd1(rs1_data),
        .rd2(rs2_data)
    );

    // =========================
    // ID/EX Register
    // =========================
    logic [31:0] id_ex_pc;
    logic [31:0] id_ex_rs1_data;
    logic [31:0] id_ex_rs2_data;
    logic [31:0] id_ex_imm;

    logic [4:0]  id_ex_rs1;
    logic [4:0]  id_ex_rs2;
    logic [4:0]  id_ex_rd;

    logic [2:0]  id_ex_funct3;
    logic        id_ex_funct7_5;

    logic        id_ex_reg_write;
    logic        id_ex_mem_read;
    logic        id_ex_mem_write;
    logic        id_ex_mem_to_reg;
    logic        id_ex_alu_src;
    logic        id_ex_branch;
    logic [1:0]  id_ex_alu_op;

    id_ex_reg id_ex_inst (
        .clk(clk),
        .reset(reset),
        .bubble(stall || branch_taken),

        .pc_in(if_id_pc),
        .rs1_data_in(rs1_data),
        .rs2_data_in(rs2_data),
        .imm_in(imm),

        .rs1_in(rs1),
        .rs2_in(rs2),
        .rd_in(rd),

        .funct3_in(funct3),
        .funct7_5_in(funct7_5),

        .reg_write_in(reg_write),
        .mem_read_in(mem_read),
        .mem_write_in(mem_write),
        .mem_to_reg_in(mem_to_reg),
        .alu_src_in(alu_src),
        .branch_in(branch),
        .alu_op_in(alu_op),

        .pc_out(id_ex_pc),
        .rs1_data_out(id_ex_rs1_data),
        .rs2_data_out(id_ex_rs2_data),
        .imm_out(id_ex_imm),

        .rs1_out(id_ex_rs1),
        .rs2_out(id_ex_rs2),
        .rd_out(id_ex_rd),

        .funct3_out(id_ex_funct3),
        .funct7_5_out(id_ex_funct7_5),

        .reg_write_out(id_ex_reg_write),
        .mem_read_out(id_ex_mem_read),
        .mem_write_out(id_ex_mem_write),
        .mem_to_reg_out(id_ex_mem_to_reg),
        .alu_src_out(id_ex_alu_src),
        .branch_out(id_ex_branch),
        .alu_op_out(id_ex_alu_op)
    );

    // =========================
    // EX/MEM wire declarations
    // =========================
    logic [31:0] ex_mem_alu_result;
    logic [31:0] ex_mem_rs2_data;
    logic [4:0]  ex_mem_rd;
    logic        ex_mem_reg_write;
    logic        ex_mem_mem_read;
    logic        ex_mem_mem_write;
    logic        ex_mem_mem_to_reg;

    // =========================
    // MEM/WB wire declarations
    // =========================
    logic [31:0] mem_wb_alu_result;
    logic [31:0] mem_wb_mem_data;
    logic [4:0]  mem_wb_rd;
    logic        mem_wb_reg_write;
    logic        mem_wb_mem_to_reg;

    // =========================
    // Hazard Detection Unit
    // =========================
    hazard_detection_unit hazard_unit_inst (
        .id_ex_mem_read(id_ex_mem_read),
        .id_ex_rd(id_ex_rd),
        .if_id_rs1(rs1),
        .if_id_rs2(rs2),
        .stall(stall)
    );

    // =========================
    // EX Stage
    // =========================
    logic [31:0] alu_operand_a;
    logic [31:0] forwarded_rs2_data;
    logic [31:0] alu_operand_b;
    logic [1:0]  forward_a;
    logic [1:0]  forward_b;
    logic [3:0]  alu_sel;
    logic [31:0] alu_result;
    logic        alu_zero;

    assign branch_target = id_ex_pc + id_ex_imm;

    forwarding_unit forwarding_unit_inst (
        .id_ex_rs1(id_ex_rs1),
        .id_ex_rs2(id_ex_rs2),
        .ex_mem_rd(ex_mem_rd),
        .ex_mem_reg_write(ex_mem_reg_write),
        .mem_wb_rd(mem_wb_rd),
        .mem_wb_reg_write(mem_wb_reg_write),
        .forward_a(forward_a),
        .forward_b(forward_b)
    );

    always_comb begin
        // Operand A
        if (ex_mem_reg_write && ex_mem_rd != 5'd0 && ex_mem_rd == id_ex_rs1)
            alu_operand_a = ex_mem_alu_result;
        else if (mem_wb_reg_write && mem_wb_rd != 5'd0 && mem_wb_rd == id_ex_rs1)
            alu_operand_a = wb_data;
        else
            alu_operand_a = id_ex_rs1_data;

        // Operand B
        if (ex_mem_reg_write && ex_mem_rd != 5'd0 && ex_mem_rd == id_ex_rs2)
            forwarded_rs2_data = ex_mem_alu_result;
        else if (mem_wb_reg_write && mem_wb_rd != 5'd0 && mem_wb_rd == id_ex_rs2)
            forwarded_rs2_data = wb_data;
        else
            forwarded_rs2_data = id_ex_rs2_data;

        if (id_ex_alu_src)
            alu_operand_b = id_ex_imm;
        else
            alu_operand_b = forwarded_rs2_data;
    end

    alu_control alu_control_inst (
        .alu_op(id_ex_alu_op),
        .funct3(id_ex_funct3),
        .funct7_5(id_ex_funct7_5),
        .alu_sel(alu_sel)
    );

    alu alu_inst (
        .a(alu_operand_a),
        .b(alu_operand_b),
        .alu_sel(alu_sel),
        .result(alu_result),
        .zero(alu_zero)
    );

    // =========================
    // Branch Unit
    // =========================
    branch_unit branch_unit_inst (
        .branch(id_ex_branch),
        .zero(alu_zero),
        .branch_taken(branch_taken)
    );

    // =========================
    // EX/MEM Register
    // =========================
    ex_mem_reg ex_mem_inst (
        .clk(clk),
        .reset(reset),

        .alu_result_in(alu_result),
        .rs2_data_in(forwarded_rs2_data),
        .rd_in(id_ex_rd),

        .reg_write_in(id_ex_reg_write),
        .mem_read_in(id_ex_mem_read),
        .mem_write_in(id_ex_mem_write),
        .mem_to_reg_in(id_ex_mem_to_reg),

        .alu_result_out(ex_mem_alu_result),
        .rs2_data_out(ex_mem_rs2_data),
        .rd_out(ex_mem_rd),

        .reg_write_out(ex_mem_reg_write),
        .mem_read_out(ex_mem_mem_read),
        .mem_write_out(ex_mem_mem_write),
        .mem_to_reg_out(ex_mem_mem_to_reg)
    );

    // =========================
    // MEM Stage
    // =========================
    logic [31:0] mem_read_data;

    data_memory data_memory_inst (
        .clk(clk),
        .mem_write(ex_mem_mem_write),
        .mem_read(ex_mem_mem_read),
        .address(ex_mem_alu_result),
        .write_data(ex_mem_rs2_data),
        .read_data(mem_read_data)
    );

    // =========================
    // MEM/WB Register
    // =========================
    mem_wb_reg mem_wb_inst (
        .clk(clk),
        .reset(reset),

        .alu_result_in(ex_mem_alu_result),
        .mem_data_in(mem_read_data),
        .rd_in(ex_mem_rd),

        .reg_write_in(ex_mem_reg_write),
        .mem_to_reg_in(ex_mem_mem_to_reg),

        .alu_result_out(mem_wb_alu_result),
        .mem_data_out(mem_wb_mem_data),
        .rd_out(mem_wb_rd),

        .reg_write_out(mem_wb_reg_write),
        .mem_to_reg_out(mem_wb_mem_to_reg)
    );

    // =========================
    // WB Stage
    // =========================
    assign wb_data      = mem_wb_mem_to_reg ? mem_wb_mem_data : mem_wb_alu_result;
    assign wb_rd        = mem_wb_rd;
    assign wb_reg_write = mem_wb_reg_write;

endmodule