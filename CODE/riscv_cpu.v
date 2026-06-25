
// riscv_cpu.v - single-cycle RISC-V CPU Processor

module riscv_cpu (
    input         clk, reset, forward,stall,flush,
    output [31:0] PC,
    input  [31:0] Instr,
    output        MemWrite,
    output [31:0] Mem_WrAddr, Mem_WrData,
    input  [31:0] ReadData,
    output [31:0] Result,Instr_out,
	 output [13:0] Controls
);

wire        ALUSrc, RegWrite,Jump, Label_out,PCSrc,forward_out;
wire [1:0]  ResultSrc;
wire [2:0]  ImmSrc ;
wire [3:0]  ALUControl;
wire [31:0] PC_prev,PC_prev_prev;
wire [31:0] Instr_out_out; 
wire        stall_out; 
//Instr_out
//wire [13:0] Controls; 

if_id       fd  (clk,stall,flush,PC,Instr,Instr_out,PC_prev,stall_out); 

controller  c   (stall_out,Instr_out[6:0], Instr_out[14:12], Instr_out[30], 
                 Label_out,Controls);  
				
id_ie       de  (clk,forward,Controls,PC_prev,Instr_out,RegWrite,ImmSrc,
                 ALUSrc,MemWrite,ResultSrc,Jump,PCSrc,ALUControl,
			     PC_prev_prev,Instr_out_out,forward_out); 

datapath    dp  (clk,forward_out,Jump,reset,stall,Instr_out[24:20],Instr_out[19:15],
                 ResultSrc, PCSrc,ALUSrc, RegWrite, ImmSrc, ALUControl,
                 Label_out,PC,PC_prev_prev,Instr_out_out, Mem_WrAddr, Mem_WrData, 
			     ReadData, Result);

endmodule

