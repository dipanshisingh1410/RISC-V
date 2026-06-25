module if_id(
input clk,stall,flush,
input [31:0] PC,Instr,
output reg [31:0] Instr_out,PC_prev,
output reg stall_out
); 

always@(posedge clk) begin 
if(flush) Instr_out <= 32'd0; 
else Instr_out <= Instr; 
PC_prev <= PC; 
stall_out <= stall; 
end 


endmodule  
