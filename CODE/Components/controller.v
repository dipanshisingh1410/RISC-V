
// controller.v - controller for RISC-V CPU

module controller (
    input        stall,
    input [6:0]  op,
    input [2:0]  funct3,
    input        funct7b5,
    input        Label_out,
    output[13:0] Controls
);

wire [1:0] ALUOp;
wire       Branch;

main_decoder    md (stall,op,Branch, ALUOp,Controls[13:6],Controls[5]);

alu_decoder     ad (stall,op[5], funct3, funct7b5, ALUOp, Controls[3:0]);

// for jump and branch
assign Controls[4] = (stall)?1'bx:(Branch & Label_out) | Controls[5];

endmodule

