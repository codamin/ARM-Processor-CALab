
`timescale 1ns/1ns

module IDStage(rst, clk, flush, PCIn, instructionReg, writeBackEnIn, destWB, valueWB, hazard, statusReg,
  S_UpdateSig, branch, memWriteEn, memReadEn, writeBackEn, exeCMD, res1, res2, PC, signedImm24, R_d, isImmidiate, shiftOperand, carry);
  //inputs from IF Stage 
  input rst, clk, flush, hazard;
  input[31:0] PCIn, instructionReg;
  //inputs from WB stage
  input writeBackEnIn;
  input[3:0] destWB, statusReg;
  input[31:0] valueWB;

  // outputs wires
  output S_UpdateSig, branch, memWriteEn, memReadEn, writeBackEn;
  output[3:0] exeCMD;
  output[31:0] res1, res2;
  output[31:0] PC;
  output[23:0] signedImm24;
  output[3:0] R_d;
  output isImmidiate;
  output shiftOperand;
  output carry;
 
  // internal wires
  wire S_UpdateSig_internal, branch_internal, memWriteEn_internal, memReadEn_internal, writeBackEn_internal;
  wire[3:0] exeCMD_internal;
  wire[3:0] src1, src2, destWB;
  wire conditionOut;
  wire[1:0] mode;
  wire[3:0] opcode, cond;
  wire S;
  wire[3:0] R_m;
  wire zeroSignalsEn;

  assign PC = PCIn;
  assign cond = instructionReg[31:28];
  assign src1 = instructionReg[19:16];
  assign mode = instructionReg[27:26];
  assign isImmidiate = instructionReg[25];
  assign opcode = instructionReg[24:21];
  assign S = instructionReg[20];
  assign R_d = instructionReg[15:12];
  assign shiftOperand = instructionReg[23:0];
  assign R_m = instructionReg[3:0];
  assign zeroSignalsEn = hazard || !conditionOut;
  assign signedImm24 = instructionReg[23:0];
  assign carry = statusReg[2];

  // components
  MUX2to1#(4) mux1(R_m, R_d, memWriteEn, src2);
  RegisterFile registerFile(rst, clk, src1, src2, res1, res2, writeBackEnIn, destWB, valueWB);
  ControlUnit cu(mode, opcode, S, S_UpdateSig_internal, branch_internal, exeCMD_internal, memWriteEn_internal, memReadEn_internal, writeBackEn_internal);
  ConditionCheck conditionCheck(cond, statusReg, conditionOut);
  MUX2to1#(9) mux2({S_UpdateSig_internal, branch_internal, exeCMD_internal, memWriteEn_internal, memReadEn_internal, writeBackEn_internal}, 9'b0, zeroSignalsEn,
                  {S_UpdateSig, branch, exeCMD, memWriteEn, memReadEn, writeBackEn});
endmodule
