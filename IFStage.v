`timescale 1ns/1ns
module IFStage(rst, clk, freeze, branchTaken, branchAddress, PC, instruction);
  input rst, clk, freeze, branchTaken, branchAddress;
  input[31:0] branchAddress;
  output[31:0] PC, instruction;
  
  MUX#(32) mux(PC, branchAddress, branchTaken, muxOut);
  PC pc(rst, clk, freeze, muxOut, pcOut);
  
  
endmodule
