module datapath (

    input logic clk,
    input logic rst_n,

    // Control signals
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

    // Internal signals
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

endmodule