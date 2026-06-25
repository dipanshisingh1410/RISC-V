module mux(
input stall, 
input [31:0] prev_PC,PCTarget,PCPlus4,ALUResult,
input PCSrc,Jump,
output reg [31:0] PC
);  

always@(*) begin 
case({stall,Jump,PCSrc})

3'b000:begin PC<=PCPlus4; end 
3'b001:begin PC<=PCTarget; end  
3'b010:begin PC<=ALUResult; end 
3'b1xx:begin PC<=prev_PC; end 

default: PC<= PCPlus4;

endcase
end  


endmodule 