// file which work as a register and chooses pc/0/rd for a of alu 

module reg_U (
input [6:0] op, 
input [31:0] pc, 
input [31:0] rd1,
output reg [31:0] reg_Uout
); 

always @(*) begin 
case(op) 
   7'b0110111: reg_Uout= 32'b0 ;     //lui 
	7'b0010111: reg_Uout= pc;         //auipc
	7'b1101111: reg_Uout=pc;          //jalr 
   default : reg_Uout= rd1;          //otherwise 
	
	endcase 
end 

endmodule 