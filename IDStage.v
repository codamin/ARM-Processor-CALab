
`timescale 1ns/1ns

module IDStage(rst, clk, flush, freeze, PCIn, instructionReg, writeBackEn, destWB, valueWB, hazard, statusReg,
  S_UpdateSig, branch, memWriteEn, memReadEn, writeBackEnOut, exeCMD, res1, res2, PC, signedImm24, R_d, isImmidiate, shiftOperand);
  //inputs from IF Stage 
  input rst, clk, freeze, flush, hazard;
  input[31:0] PCIn, instructionReg;
  //inputs from WB stage
  input writeBackEn;
  input[3:0] destWB, statusReg;
  input[31:0] valueWB;

  // outputs wires
  output S_UpdateSig, branch, memWriteEn, memReadEn, writeBackEnOut;
  output[3:0] exeCMD;
  output[31:0] res1, res2;
  output[31:0] PC;
  output[23:0] signedImm24;
  output R_d;
  output isImmidiate;
  output shiftOperand;
 
  // internal wires
  wire[3:0] src1, src2, destWB;
  wire conditionOut;
  wire[2:0] mode;
  wire[3:0] opcode, cond;
  wire S;
  wire R_m;
  wire zeroSignalsEn;

  assign PC = PCIn;
  assign src1 = instructionReg[19:16];
  assign mode = instructionReg[27:26];
  assign isImmidiate = instructionReg[25];
  assign opcode = instructionReg[24:21];
  assign S = instructionReg[20];
  assign R_d = instructionReg[15:12];
  assign shiftOperand = instructionReg[23:0];
  assign R_m = instructionReg[3:0];
  assign zeroSignalsEn = hazard || !conditionOut;

  // components
  MUX2to1#(4) mux1(, R_d, memWriteEn, src2);
  RegisterFile registerFile(rst, clk, src1, src2, res1, res2, writeBackEn, destWB, valueWB);
  ControlUnit cu(rst, clk, mode, opcode, S, S_UpdateSig, branch, exeCMD, memWriteEn, memReadEn, writeBackEnOut);
  ConditionCheck conditionCheck(cond, statusReg, conditionOut);
  MUX2to1#(9) mux2({S_UpdateSig, branch, exeCMD, memWriteEn, memReadEn, writeBackEnOut}, 9'b0, zeroSignalsEn,
                  {S_UpdateSig, branch, exeCMD, memWriteEn, memReadEn, writeBackEnOut});
endmodule
