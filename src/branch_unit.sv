module branch_unit (
    input logic branch,
    input logic zero,

    output logic branch_taken
);

always_comb begin
    branch_taken = branch && zero;
end

endmodule