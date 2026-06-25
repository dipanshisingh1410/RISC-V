// data_mem.v - data memory

module data_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 50) (
    input       clk, wr_en,
    input       [ADDR_WIDTH-1:0] wr_addr, wr_data,
    output      reg [DATA_WIDTH-1:0] rd_data_mem,
	 input       [31:0] Instr 
);

wire s_type ; 
wire load_type; 
wire [2:0] funct3; 

assign s_type= (Instr[6:0]==7'b0100011); 
assign load_type= (Instr[6:0]==7'b0000011); 
assign funct3= Instr[14:12]; 

// array of 64 32-bit words or data
reg [DATA_WIDTH-1:0] data_ram [0:MEM_SIZE-1];

// combinational read logic
// word-aligned memory access
always @(*) begin
   if (load_type) begin
 
   case(funct3)
   3'b000: rd_data_mem = {{24{data_ram[wr_addr% 64][7]}},data_ram[wr_addr% 64][7:0]}; //[DATA_WIDTH-1:2] divides the address by 4
	
   3'b001: rd_data_mem = {{16{data_ram[wr_addr % 64][15]}},data_ram[wr_addr[DATA_WIDTH-1:1] % 64]};   
	
   3'b010: rd_data_mem = data_ram[wr_addr[DATA_WIDTH-1:2] % 64];
	
	3'b100: rd_data_mem = {24'b0,data_ram[wr_addr % 64][7:0]}; 
	
	3'b101: rd_data_mem = {16'b0,data_ram[wr_addr[DATA_WIDTH-1:1] % 64][15:0]}; 
	
	default: rd_data_mem = 32'bx ;
	endcase 
end 
end 
	
// synchronous write logic
always @(posedge clk) begin
    if (wr_en & s_type) begin  
	 
	 case (funct3) 
	 3'b000: data_ram[wr_addr%64] <= wr_data;
	 3'b001: data_ram[wr_addr[DATA_WIDTH-1:1] % 64] <= wr_data;
	 3'b010: data_ram[wr_addr[DATA_WIDTH-1:2] % 64] <= wr_data;
	 endcase
end 

end 

endmodule
