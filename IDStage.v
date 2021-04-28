
`timescale 1ns/1ns

module IDStage(rst, clk, flush, freez, PCR, instructionR);
  input rst, clk, freeze, flush, freez;
  input[31:0] PCR, instructionR;
  
  MUX2to1#(32) mux(PC, branchAddress, branchTaken, muxOut);
  RegisterFile registerFile(rst, clk, src1, src2, res1, res2, writeBackEn, destWB, resultWB);
endmodule
