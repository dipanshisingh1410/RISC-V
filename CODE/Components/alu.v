module alu #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a, b,       // operands
    input       [6:0] op,
    input       [2:0] funct3,
    input       [3:0] alu_ctrl,         // ALU control
    output reg  [WIDTH-1:0] alu_out,    // ALU output
    output reg  [31:0] label            // flags (changed to reg)
);

always @(*) begin
    case (alu_ctrl)
        4'b0000: alu_out = a + b;                         // add
        4'b0001: alu_out = a << b[4:0];                   // sll
        4'b0010: alu_out = ($signed(a) < $signed(b)) ? 1 : 0;  // slt
        4'b0011: alu_out = (a < b) ? 1 : 0;               // sltu
        4'b0100: alu_out = a ^ b;                          // xor
        4'b0101: alu_out = a >> b[4:0];                    // srl
        4'b0110: alu_out = a | b;                          // or
        4'b0111: alu_out = a & b;                          // and
        4'b1000: alu_out = a - b;                          // sub
        4'b1001: alu_out = (a >> b[4:0]) | ((32'hFFFFFFFF << (32 - b[4:0])) & {32{a[31]}});  // sra
        default: alu_out = 0;
    endcase

 if (op == 7'b1100011) begin
        label = a - b;  // Use subtraction result for branch comparisons
    end else begin
        label = 32'bx;
    end
end 

endmodule
