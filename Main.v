`timescale 1ns/1ns
module Main(rst, clk);
  input rst, clk;
  wire freeze, branchTaken;
  wire[31:0] branchAddress, PC_IF, instructionR_IF;
  IFStage ifStage(rst, clk, freeze, branchTaken, branchAddress, PC_IF, instructionR_IF);

endmodule