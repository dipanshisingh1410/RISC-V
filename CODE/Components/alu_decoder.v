
// alu_decoder.v - logic for ALU decoder

module alu_decoder (
    input            stall,
    input            opb5,
    input [2:0]      funct3,
    input            funct7b5,
    input [1:0]      ALUOp,
    output reg [3:0] ALUControl
);

always @(*) begin
    case ({stall,ALUOp})
        3'b000: ALUControl = 4'b0000;             // addition
        3'b001: ALUControl = 4'b1000;             // subtraction,,,,,B-TYPE
		  3'b1xx: ALUControl = 4'bxxxx; 
        default:
            case (funct3) // R-type or I-type ALU
                3'b000: begin
                    // True for R-type subtract
                    if   (funct7b5 & opb5) ALUControl = 4'b1000; //sub
                    else ALUControl = 4'b0000; // add, addi
                end
					 3'b001:  ALUControl = 4'b0001; // sll
					 3'b011:  ALUControl = 4'b0011; // sltu
					 3'b100:  ALUControl = 4'b0100; // xor
					 3'b101:  begin
                    if   (funct7b5) ALUControl = 4'b1001; //sra
                    else ALUControl = 4'b0101; // srl
					 end 
                3'b010:  ALUControl = 4'b0010; // slt, slti
                3'b110:  ALUControl = 4'b0110; // or, ori
                3'b111:  ALUControl = 4'b0111; // and, andi
                default: ALUControl = 4'b1111; // default 
            endcase
    endcase
end

endmodule

