`timescale 1ns/1ns

module IDStage(rst, clk, flush, PCIn, instructionReg, WB_EN_IN, destWB, valueWB, hazard, statusReg,
  S_UpdateSig, branch, memWriteEn, memReadEn, WB_EN, exeCMD, res1, res2, PC, signedImm24, Dest, isImmidiate, shiftOperand, two_src, src1, src2);
  //inputs from IF Stage 
  input rst, clk, flush, hazard;
  input[31:0] PCIn, instructionReg;
  //inputs from WB stage
  input WB_EN_IN;
  input[3:0] destWB, statusReg;
  input[31:0] valueWB;

  // outputs wires
  output S_UpdateSig, branch, memWriteEn, memReadEn, WB_EN;
  output[3:0] exeCMD;
  output[31:0] res1, res2;
  output[31:0] PC;
  output[23:0] signedImm24;
  output[3:0] Dest;
  output isImmidiate;
  output [11:0]shiftOperand;
  output two_src;
  output [3:0] src1, src2;

  // internal wires
  wire S_UpdateSig_internal, branch_internal, memWriteEn_internal, memReadEn_internal, WB_EN_internal;
  wire[3:0] exeCMD_internal;
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
  assign Dest = instructionReg[15:12];
  assign shiftOperand = instructionReg[11:0];
  assign R_m = instructionReg[3:0];
  assign zeroSignalsEn = hazard || !conditionOut;
  assign signedImm24 = instructionReg[23:0];
  assign two_src = ~instructionReg[25] | memWriteEn_internal;

  // components
  MUX2to1#(4) mux1(R_m, Dest, memWriteEn_internal, src2);
  RegisterFile registerFile(rst, clk, src1, src2, res1, res2, WB_EN_IN, destWB, valueWB);
  ControlUnit cu(mode, opcode, S, S_UpdateSig_internal, branch_internal, exeCMD_internal, memWriteEn_internal, memReadEn_internal, WB_EN_internal);
  ConditionCheck conditionCheck(cond, statusReg, conditionOut);
  MUX2to1#(9) mux2({S_UpdateSig_internal, branch_internal, exeCMD_internal, memWriteEn_internal, memReadEn_internal, WB_EN_internal}, 9'b0, zeroSignalsEn,
                  {S_UpdateSig, branch, exeCMD, memWriteEn, memReadEn, WB_EN});
endmodule
