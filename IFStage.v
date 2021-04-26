`timescale 1ns/1ns
module IFStage(rst, clk, freeze, branchTaken, branchAddress, PC, instruction);
  input rst, clk, freeze, branchTaken, branchAddress;
  input[31:0] branchAddress;
  output[31:0] PC, instruction;
  
  wire[31:0] muxOut, pcOut;
  
  MUX2to1#(32) mux(PC, branchAddress, branchTaken, muxOut);
  PC pc(rst, clk, freeze, muxOut, pcOut);
  Adder#(32) adder(32'b00000000000000000000000000000100, pcOut, PC);
  InstructionMemory instructionMemory(pcOut, instruction);
endmodule
