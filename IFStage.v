`timescale 1ns/1ns

module IFStage(rst, clk, freeze, branchTaken, branchAddress, PCR, instructionR);
  input rst, clk, freeze, branchTaken;
  input[31:0] branchAddress;
  output[31:0] PCR, instructionR;
  
  wire[31:0] muxOut, pcOut;
  wire[31:0] PC, instruction;
  
  MUX2to1#(32) mux(PC, branchAddress, branchTaken, muxOut);
  PC pc(rst, clk, freeze, muxOut, pcOut);
  Adder#(32) adder(32'b00000000000000000000000000000100, pcOut, PC);
  InstructionMemory instructionMemory(pcOut, instruction);
  IFStageReg ifStageReg(clk, rst, freeze, branchTaken, PC, instruction, PCR, instructionR);
endmodule
