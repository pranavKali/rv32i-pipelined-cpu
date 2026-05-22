module reg_file (
    input  logic        clk,
    input  logic        rst_n,

    input  logic [4:0]  rs1,
    input  logic [4:0]  rs2,
    input  logic [4:0]  rd,

    input  logic [31:0] wd,
    input  logic        reg_write,

    output logic [31:0] rd1,
    output logic [31:0] rd2
);

    logic [31:0] regs [31:0];

    integer i;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 32; i = i + 1)
                regs[i] <= 32'b0;
        end
        else if (reg_write && rd != 5'd0) begin
            regs[rd] <= wd;
        end
    end

    assign rd1 = (rs1 == 5'd0) ? 32'b0 : regs[rs1];
    assign rd2 = (rs2 == 5'd0) ? 32'b0 : regs[rs2];

endmodule