module hazard_control(
input clk,
input [6:0] op_code,op_code_next, 
input [4:0] rd,
input [4:0] rs1_next,rs2_next,
output reg forward,
output reg stall,flush
);

reg flush_done; 
reg [1:0] counter=2'b00; 

always@(posedge clk) begin 

counter <= counter +1'b1; 

if(counter == 2'b10) begin 
flush_done <= 1'b1; 
counter <= 2'b00; end 
else flush_done <= 1'b0; 

end 

always@(*) begin
//forward stalling  

if((op_code == 7'd19 && (op_code_next == 7'd19||op_code_next == 7'd51
                         ||op_code_next == 7'd99||op_code_next == 7'd103))|
   (op_code == 7'd51 && (op_code_next == 7'd19||op_code_next == 7'd51||
                         op_code_next == 7'd99||op_code_next == 7'd103)))begin 
if (rs1_next == rd)  
forward = 1'b0;
else if (rs2_next == rd)
forward = 1'b1; end 
else forward = 1'bx; 


//data stall 

if(op_code == 7'd3 && (op_code_next == 7'd19||op_code_next == 7'd51||
                         op_code_next == 7'd99||op_code_next == 7'd103))begin 
if (rd == rs1_next || rd == rs2_next) 
stall = 1'b1; end 
else stall = 1'b0; 

//flush  

if(op_code_next == 7'd99 || op_code_next == 7'd103 || op_code_next == 7'd111) 
flush= 1'b1; 
if (flush_done) flush = 1'b0; 

end 

endmodule  