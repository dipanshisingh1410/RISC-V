`timescale 1 ns/1 ns 

module test; 

// registers to send data
reg clk;
reg reset;
reg Ext_MemWrite;
reg [31:0] Ext_WriteData, Ext_DataAdr;

// Wire Ouputs from Instantiated Modules
wire [31:0] WriteData, DataAdr, ReadData;
wire MemWrite,data_forward;
wire [31:0] PC, Result,Instr_out_out, Instr;
wire [13:0] Controls;

t1c_riscv_cpu uut (clk, reset, Ext_MemWrite, Ext_WriteData,
                   Ext_DataAdr, MemWrite,data_forward, WriteData, DataAdr,
                   ReadData, PC, Result,Instr,Instr_out_out,Controls); 						 
initial begin 
    reset = 1; 
    Ext_MemWrite = 0; Ext_DataAdr = 32'b0; Ext_WriteData = 32'b0; #10; 
    reset = 0;   
end 
						 
always begin
    clk <= 1; # 5; clk <= 0; # 5;
end
 
endmodule 