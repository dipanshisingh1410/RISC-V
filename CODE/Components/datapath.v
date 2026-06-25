
// datapath.v
module datapath (
    input         clk,forward,Jump,reset,stall,
	input [4:0]   destination2,destination1,
    input [1:0]   ResultSrc,
    input         PCSrc, ALUSrc,
    input         RegWrite,
    input [2:0]   ImmSrc,
    input [3:0]   ALUControl,
    output        Label_out,
    output [31:0] PC,
    input  [31:0] PC_prev,Instr,
    output [31:0] Mem_WrAddr, Mem_WrData,
    input  [31:0] ReadData,
    output [31:0] Result
	
);

wire [31:0] PCNext, PCPlus4, PCTarget,Label,mux_jump_out;
wire [31:0] ImmExt,SrcA, reg_Uout, SrcB, WriteData, ALUResult,
             ALUResult_out,Result_out,Result_out2;
wire RegWrite_out , RegWrite_out2; 

// next PC logic
reset_ff #(32) pcreg(clk, reset, mux_jump_out, PC);       //reset
adder          pcadd4(PC, 32'd4, PCPlus4);                //normal pc increamentation
adder          pcaddbranch(PC_prev, ImmExt, PCTarget);         //B type 
mux            newmux(stall,PC,PCTarget,PCPlus4,ALUResult,PCSrc,Jump,mux_jump_out); 

// register file logic
reg_file       rf (clk,forward,RegWrite_out2,ALUResult,Instr[19:15], 
                   Instr[24:20], Instr[11:7],destination1,destination2,
                   Result_out, SrcA, WriteData);
imm_extend     ext (Instr[31:7], ImmSrc, ImmExt);

//register after rd1 and before SrcA 
reg_U          reg_U( Instr[6:0],PC_prev,SrcA,reg_Uout); 

//register for label 
reg_Label      reg_Label(Instr[14:12] ,Label, Label_out); 

// ALU logic
mux2 #(32)     srcbmux(WriteData, ImmExt, ALUSrc, SrcB);  // chooses between pc+4 and pc+rs(b)
alu            alu (reg_Uout, SrcB, Instr[6:0],Instr[14:12], ALUControl, 
                    ALUResult, Label);
mux3 #(32)     resultmux(ALUResult, ReadData, PCPlus4, ResultSrc, Result);  // to send the value from diff sorces to regarray or save it in memory  

ie_im          em(clk,RegWrite,Result,ALUResult,WriteData,Mem_WrAddr,
                   Mem_WrData,ALUResult_out,RegWrite_out,Result_out); 

im_wb          wb(clk,RegWrite_out,Result_out,RegWrite_out2,Result_out2 );  

endmodule

