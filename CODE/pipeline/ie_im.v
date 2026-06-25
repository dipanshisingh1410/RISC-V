module ie_im( 
input clk,RegWrite,
input [31:0] Result,ALUResult,WriteData,
output reg [31:0] Mem_WrAddr,Mem_WrData,ALUResult_out,RegWrite_out,Result_out
); 
always@(posedge clk) begin 
Mem_WrData    <= WriteData;
Mem_WrAddr    <= ALUResult; 
ALUResult_out <= ALUResult; 
RegWrite_out  <= RegWrite ;
Result_out    <= Result   ;  

end 

endmodule 