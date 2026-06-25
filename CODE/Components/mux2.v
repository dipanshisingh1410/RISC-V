
// mux2.v - logic for 2-to-1 multiplexer(pc_mux)

module mux2 #(parameter WIDTH = 8) (
    input       [WIDTH-1:0] d0, d1,
    input       sel,
    output      [WIDTH-1:0] y
); 

//d1 gets selected for branch---input coming from adder----y is going into resetff
//d0 normal pc sum 
assign y = sel ? d1 : d0;

endmodule

