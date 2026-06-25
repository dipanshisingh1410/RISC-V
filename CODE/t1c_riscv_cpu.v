
// t1c_riscv_cpu.v - Top Module to test riscv_cpu

module t1c_riscv_cpu (
    input         clk, reset,
    input         Ext_MemWrite,
    input  [31:0] Ext_WriteData, Ext_DataAdr,
    output        MemWrite,data_forward,
    output [31:0] WriteData, DataAdr, ReadData,
    output [31:0] PC, Result,Instr,Instr_out,
    output [13:0] Controls
);

//wire [31:0] Instr;
wire [31:0] DataAdr_rv32, WriteData_rv32;
wire        MemWrite_rv32;
wire        stall,flush; 
//wire data_forward;

// instantiate processor and memories
riscv_cpu rvcpu    (clk, reset, data_forward,stall,flush, PC, Instr,
                    MemWrite_rv32, DataAdr_rv32,
                    WriteData_rv32, ReadData, Result, Instr_out, Controls);
						  
instr_mem instrmem (PC, Instr);

data_mem  datamem  (clk, MemWrite, DataAdr, WriteData, ReadData,Instr); 

hazard_control     hc(clk,Instr[6:0],Instr_out[6:0], Instr_out[11:7], 
                    Instr[19:15],Instr[24:20], data_forward,stall,flush);


assign MemWrite  = (Ext_MemWrite && reset) ? 1'b1 : MemWrite_rv32;
assign WriteData = (Ext_MemWrite && reset) ? Ext_WriteData : WriteData_rv32;
assign DataAdr   = reset ? Ext_DataAdr : DataAdr_rv32;

endmodule

