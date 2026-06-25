// label reg 

module reg_Label(
input [2:0] funct3, 
input [31:0] label,
output reg Label_out
); 

wire zero = (label == 0);
wire negative = label[31];
wire signed [31:0] label_signed = label;

always @(*) begin
    case(funct3)
        3'b000: Label_out = zero;                    // beq
        3'b001: Label_out = ~zero;                   // bne
        3'b100: Label_out = (label_signed < 0);      // blt (signed)
        3'b101: Label_out = (label_signed >= 0);     // bge (signed)
        3'b110: Label_out = negative && !zero;       // bltu (unsigned)
        3'b111: Label_out = !negative || zero;       // bgeu (unsigned)
        default: Label_out = 0; 
		  
		  endcase 
end 
endmodule

    