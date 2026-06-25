//mux_jump  
// select == jump ; if select=1 then value from alu_out else pc_mux.
//the output will go into reset_ff 

module mux_jump #(parameter WIDTH = 32) (
 input select, 
 input [WIDTH-1:0] d0, d1, 
 output [WIDTH-1:0] mux_jump_out
 ); 
 
 assign mux_jump_out= select?d1:d0; 
 
endmodule 

 