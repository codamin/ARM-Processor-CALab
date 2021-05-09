`timescale 1ns/1ns
module Main(rst, clk);

  input rst, clk;

  wire[31:0] branchAddress_EXE_OUT;
  wire freeze, flush, hazard;
  wire[31:0] PC_IF_OUT, instructionReg_IF_OUT;
  wire writeBackEn_EXE_OUT;
  wire[3:0] destWB_EXE_OUT, statusReg_EXE_OUT;
  wire[31:0] valueWB_EXE_OUT;
  wire S_UpdateSig_ID_OUT, branch_ID_OUT, memWriteEn_ID_OUT, memReadEn_ID_OUT, writeBackEn_ID_OUT;
  wire[3:0] exeCMD_ID_OUT;
  wire[31:0] res1_ID_OUT, res2_ID_OUT;
  wire[31:0] PC_ID_OUT;
  wire[23:0] signedImm24_ID_OUT;
  wire[3:0] R_d_ID_OUT;
  wire isImmidiate_ID_OUT;
  wire shiftOperand_ID_OUT;
  wire branchTaken_EXE_OUT;
 //*****************************************************************************************************temp
  assign hazard = 1'b0; 
  assign statusReg_EXE_OUT = 4'b0;
  assign flush = 1'b0;
  assign freeze = 1'b0;
  assign branchTaken_EXE_OUT = 1'b0;
 //*****************************************************************************************************temp

  IFStage iFStage(rst, clk, freeze, branchTaken_EXE_OUT, branchAddress_EXE_OUT, PC_IF_OUT, instructionReg_IF_OUT);

  IDStage iDStage(rst, clk, flush, freeze, PC_IF_OUT, instructionReg_IF_OUT, writeBackEn_EXE_OUT, destWB_EXE_OUT, valueWB_EXE_OUT, hazard, statusReg_EXE_OUT,
   S_UpdateSig_ID_OUT, branch_ID_OUT, memWriteEn_ID_OUT, memReadEn_ID_OUT, writeBackEn_ID_OUT, exeCMD_ID_OUT, res1_ID_OUT, res2_ID_OUT, PC_ID_OUT, signedImm24_ID_OUT,
    R_d_ID_OUT, isImmidiate_ID_OUT, shiftOperand_ID_OUT);

  IDStageReg iDStageReg(rst, clk, freeze, flush, S_UpdateSig_ID_OUT, branch_ID_OUT, memWriteEn_ID_OUT, memReadEn_ID_OUT,
 writeBackEn_ID_OUT, exeCMD_ID_OUT, res1_ID_OUT, res2_ID_OUT, PC_ID_OUT, signedImm24_ID_OUT, R_d_ID_OUT, isImmidiate_ID_OUT, shiftOperand_ID_OUT,
  S_UpdateSig_ID_R_OUT, branch_ID_R_OUT, memWriteEn_ID_R_OUT, memReadEn_ID_R_OUT, writeBackEn_ID_R_OUT, exeCMD_ID_R_OUT, res1_ID_R_OUT, res2_ID_R_OUT,
   PC_ID_R_OUT, signedImm24_ID_R_OUT, R_d_ID_R_OUT, isImmidiate_ID_R_OUT, shiftOperand_ID_R_OUT);
   
   module EXEStage(rst, clk, carry, EXE_CMD, MEM_R_EN, MEM_W_EN, PC, Val_Rn, Val_Rm, imm, Shift_operand, Signed_imm_24, SR, ALU_result, Br_addr, status);
  EXEStage eXEStage(rst, clk, 
endmodule