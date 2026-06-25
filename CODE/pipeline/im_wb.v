module im_wb( 
input clk, RegWrite_out,
input [31:0]Result_out,
output reg  RegWrite_out2,
output reg [31:0] Result_out2
); 

always@(posedge clk) begin 

Result_out2   <= Result_out ; 
RegWrite_out2 <= RegWrite_out; 
end 
endmodule 