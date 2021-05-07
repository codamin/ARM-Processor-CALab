`timescale 1ns/1ns

module IDStageReg(rst, clk, freeze, flush, S_UpdateSigIn, branchIn, memWriteEnIn, memReadEnIn,
 writeBackEnIn, exeCMDIn, res1In, res2In, PCIn, signedImm24In, R_dIn, isImmidiateIn, shiftOperandIn,
  S_UpdateSig, branch, memWriteEn, memReadEn, writeBackEn, exeCMD, res1, res2, PC, signedImm24, R_d,
   isImmidiate, shiftOperand);

  input clk, rst, freeze, flush;
  input S_UpdateSigIn, branchIn, memWriteEnIn, memReadEnIn, writeBackEnIn;
  input[3:0] exeCMDIn;
  input[31:0] res1In, res2In;
  input[31:0] PCIn;
  input[23:0] signedImm24In;
  input[3:0] R_dIn;
  input isImmidiateIn;
  input shiftOperandIn;

  output reg S_UpdateSig, branch, memWriteEn, memReadEn, writeBackEn;
  output reg[3:0] exeCMD;
  output reg[31:0] res1, res2;
  output reg[31:0] PC;
  output reg[23:0] signedImm24;
  output reg[3:0] R_d;
  output reg isImmidiate;
  output reg shiftOperand;
  

  always@(posedge clk, posedge rst) begin
    if(rst || flush) begin
        {S_UpdateSig, branch, memWriteEn, memReadEn, writeBackEn, exeCMD, res1, res2, PC, signedImm24, R_d,
        isImmidiate, shiftOperand} <= 0;
    end

    else begin
        S_UpdateSig  <= S_UpdateSigIn;
        branch       <= branchIn;
        memWriteEn   <= memWriteEnIn;
        memReadEn    <= memReadEnIn;
        writeBackEn  <= writeBackEnIn;
        exeCMD       <= exeCMDIn;
        res1         <= res1In;
        res2         <= res2In;
        PC           <= PCIn;
        signedImm24  <= signedImm24In;
        R_d          <= R_dIn;
        isImmidiate  <= isImmidiateIn;
        shiftOperand <= shiftOperandIn;
    end

  end
endmodule