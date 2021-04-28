
`timescale 1ns/1ns

module IDStage(rst, clk, flush, freez, PCR, instructionR, writeBackEn, destWB, valueWB);
  //inputs from IF Stage 
  input rst, clk, freeze, flush, freez;
  input[31:0] PCR, instructionR;
  //inputs from WB stage
  input writeBackEn;
  input[3:0] destWB;
  input[31:0] valueWB;

  // outputs wires
  output S_UpdateSig, branch, memWriteEn, memReadEn, writeBackEn;
  output[3:0] exeCMD;
  output[31:0] res1, res2;
 
  // internal wires
  wire[3:0] src1, src2, destWB;
  assign src1 = instructionR[19:16];

  wire[2:0] mode;
  wire[3:0] opcode;
  wire S;
  assign mode = instructionR[27:26];
  assign opcode = instructionR[24:21];
  assign S = instructionR[20];

  // components
  MUX2to1#(32) mux(instructionR[3:0], instructionR[12:0], memWriteEn, src2);
  RegisterFile registerFile(rst, clk, src1, src2, res1, res2, writeBackEn, destWB, valueWB);
  ControlUnit cu(rst, clk, mode, opcode, S, S_UpdateSig, branch, exeCMD, memWriteEn, memReadEn, writeBackEn);
endmodule
