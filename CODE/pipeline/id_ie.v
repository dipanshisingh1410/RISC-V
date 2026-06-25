module id_ie(
input clk,forward, 
input [13:0] Controls, 
input [31:0] PC,
input [31:0] Instr, 
output reg RegWrite,
output reg [2:0] ImmSrc,
output reg ALUSrc,MemWrite,
output reg [1:0] ResultSrc,
output reg Jump,PCSrc,
output reg [3:0]ALUCtrl,
output reg [31:0] PC_prev,
output reg [31:0] Instr_out,
output reg forward_out //data_bypassing
); 

always@(posedge clk) begin 
{RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Jump,PCSrc,ALUCtrl}<= Controls; 
PC_prev <= PC;
Instr_out <= Instr;  
forward_out<=forward; 
end 
endmodule 