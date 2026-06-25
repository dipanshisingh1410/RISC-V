
// main_decoder.v - logic for main decoder

module main_decoder (
    input stall,
    input  [6:0] op,
    output       Branch, 
    output [1:0] ALUOp, 
	 output [7:0] Controls,
	 output Jump
);

reg [11:0] controls;

always @(*) begin 
if (stall) controls = 12'bx ; else begin
case (op)
    // RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_Jump
    
    7'b0000011: controls = 12'b1_000_1_0_01_0_00_0; // op=3,Itype
    
    7'b0100011: controls = 12'b0_001_1_1_00_0_00_0; // op=35,Stype
    
    7'b0110011: controls = 12'b1_xxx_0_0_00_0_10_0; // op=51,Rtype 
    
    7'b1100011: controls = 12'b0_010_0_0_00_1_01_0; // op=99,Btype 
    
    7'b0010011: controls = 12'b1_000_1_0_00_0_10_0; // op=19,fi
    
    7'b1101111: controls = 12'b1_011_1_0_10_0_00_1; // op=111,jal
    
    7'b1100111: controls = 12'b1_000_1_0_10_0_00_1; // op=103,jalr
    
    7'b0110111: controls = 12'b1_100_1_0_00_0_00_0; // op=55,lui
    
    7'b0010111: controls = 12'b1_100_1_0_00_0_00_0; // op=23,auipc 
	 
	 default : controls = 12'bx; 
endcase end 

end

assign {Controls,Branch,ALUOp,Jump} = controls;

endmodule

