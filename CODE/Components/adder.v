
// adder.v - logic for adder

module adder #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a, b,
    output      [WIDTH-1:0] sum
);
//for branch a- PC and b- imm  
assign sum = a + b;

endmodule

