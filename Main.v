`timescale 1ns/1ns
module Main(rst, clk);

  input rst, clk;

  wire[31:0] branchAddress_EXE_OUT;
  wire freeze, flush, hazard;
  wire[31:0] PC_IF_OUT, instructionReg_IF_OUT;
  wire[3:0] destWB_EXE_OUT, statusReg_EXE_OUT;
  wire[3:0] exeCMD_ID_OUT, R_d_ID_R_OUT;
  wire[31:0] valueWB_EXE_OUT;
  wire S_UpdateSig_ID_OUT, branch_ID_OUT, memWriteEn_ID_OUT, memReadEn_ID_OUT, writeBackEn_ID_OUT;
  wire[3:0] exeCMD_ID_R_OUT;
  wire[31:0] res1_ID_OUT, res2_ID_OUT, res1_ID_R_OUT, res2_ID_R_OUT, PC_ID_R_OUT;
  wire[31:0] PC_ID_OUT, ALU_result_EXE_OUT, Br_addr_EXE_OUT;
  wire[23:0] Signed_imm_24_ID_R_OUT, SignedImm24_ID_OUT;
  wire[11:0] shiftOperand_ID_R_OUT;
  wire[3:0] R_d_ID_OUT, status_EXE_OUT;
  wire isImmidiate_ID_OUT;
  wire[11:0] shiftOperand_ID_OUT;
  wire branchTaken_EXE_OUT;
  wire carry;
  
  wire WB_en_EXE_R_OUT, MEM_R_EN_EXE_R_OUT, MEM_W_EN_EXE_R_OUT;
  wire[31:0] ALU_result_EXE_R_OUT, ST_val_EXE_R_OUT;
  wire[3:0] Dest_EXE_R_OUT;
  
  wire[31:0] MEM_result_MEM;
  wire WB_en_MEM_R_OUT, MEM_R_en_MEM_R_OUT;
  wire[31:0] ALU_result_MEM_R_OUT, Mem_read_value_MEM_R_OUT;
  wire[3:0] Dest_R_OUT;
  
  wire[31:0] WB_value;
 //*****************************************************************************************************temp
  assign hazard = 1'b0; 
  assign statusReg_EXE_OUT = 4'b0;
  assign flush = 1'b0;
  assign freeze = 1'b0;
  assign branchTaken_EXE_OUT = 1'b0;
 //*****************************************************************************************************temp

  IFStage iFStage(rst, clk, freeze, branchTaken_EXE_OUT, branchAddress_EXE_OUT, PC_IF_OUT, instructionReg_IF_OUT);

  IDStage iDStage(.rst(rst), .clk(clk), .flush(flush), .PCIn(PC_IF_OUT), .instructionReg(instructionReg_IF_OUT),
    .writeBackEnIn(WB_en_MEM_R_OUT), .destWB(Dest_R_OUT), .valueWB(WB_value), .hazard(hazard), .statusReg(statusReg_EXE_OUT),
   .S_UpdateSig(S_UpdateSig_ID_OUT), .branch(branch_ID_OUT), .memWriteEn(memWriteEn_ID_OUT), .memReadEn(memReadEn_ID_OUT),
   .writeBackEn(writeBackEn_ID_OUT), .exeCMD(exeCMD_ID_OUT), .res1(res1_ID_OUT), .res2(res2_ID_OUT), .PC(PC_ID_OUT),
   .signedImm24(SignedImm24_ID_OUT), .R_d(R_d_ID_OUT), .isImmidiate(isImmidiate_ID_OUT), .shiftOperand(shiftOperand_ID_OUT));

  IDStageReg iDStageReg(.rst(rst), .clk(clk), .flush(flush), .S_UpdateSigIn(S_UpdateSig_ID_OUT), .branchIn(branch_ID_OUT),
    .memWriteEnIn(memWriteEn_ID_OUT), .memReadEnIn(memReadEn_ID_OUT), .writeBackEnIn(writeBackEn_ID_OUT), .exeCMDIn(exeCMD_ID_OUT),
    .res1In(res1_ID_OUT), .res2In(res2_ID_OUT), .PCIn(PC_ID_OUT), .signedImm24In(SignedImm24_ID_OUT), .R_dIn(R_d_ID_OUT),
    .isImmidiateIn(isImmidiate_ID_OUT), .shiftOperandIn(shiftOperand_ID_OUT), .carryIn(status_EXE_OUT[1]), .S_UpdateSig(S_UpdateSig_ID_R_OUT),
    .branch(branch_ID_R_OUT), .memWriteEn(memWriteEn_ID_R_OUT), .memReadEn(memReadEn_ID_R_OUT), .writeBackEn(writeBackEn_ID_R_OUT),
    .exeCMD(exeCMD_ID_R_OUT), .res1(res1_ID_R_OUT), .res2(res2_ID_R_OUT), .PC(PC_ID_R_OUT), .signedImm24(Signed_imm_24_ID_R_OUT),
    .R_d(R_d_ID_R_OUT), .isImmidiate(isImmidiate_ID_R_OUT), .shiftOperand(shiftOperand_ID_R_OUT), .carry(carry));
  
  EXEStage exeStage(rst, clk, carry, exeCMD_ID_R_OUT, memReadEn_ID_OUT, memWrite_en_ID_R_OUT, PC_ID_R_OUT, res1_ID_OUT, res2_ID_OUT, isImmidiate_ID_R_OUT, shiftOperand_ID_R_OUT,
    Signed_imm_24_ID_R_OUT, ALU_result_EXE_OUT, Br_addr_EXE_OUT, status_EXE_OUT);
  
  EXEStageReg exeStageReg(rst, clk, wirteBackEn_ID_OUT, memReadEn_ID_OUT, memWriteEn_ID_OUT, ALU_result_EXE_OUT, res2_ID_R_OUT, R_d_ID_OUT, WB_en_EXE_R_OUT,
    MEM_R_EN_EXE_R_OUT, MEM_W_EN_EXE_R_OUT, ALU_result_EXE_R_OUT, ST_val_EXE_R_OUT, Dest_EXE_R_OUT);
  
  DataMemory memStage(rst, clk, MEM_R_EN_EXE_R_OUT, MEM_W_EN_EXE_R_OUT, ALU_result_EXE_OUT, ST_val_EXE_R_OUT, MEM_result_MEM);
  
  MemStageReg memStageReg(rst, clk, WB_en_EXE_R_OUT, MEM_R_EN_EXE_R_OUT, ALU_result_EXE_OUT, MEM_result_MEM, Dest_EXE_R_OUT, WB_en_MEM_R_OUT, MEM_R_en_MEM_R_OUT,
    ALU_result_MEM_R_OUT, Mem_read_value_MEM_R_OUT, Dest_R_OUT);
    
  WBStage wbStage(ALU_result_MEM_R_OUT, Mem_read_value_MEM_R_OUT, MEM_R_en_MEM_R_OUT, WB_value);
endmodule