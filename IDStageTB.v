`timescale 1ns/1ns

module IDStageTB();

  reg rst=0, clk=0, flush=0, freeze=0, hazard=0;
  reg [31:0] PCIn=43'b0, instructionReg;
  reg writeBackEnIn=0;
  reg[3:0] destWB=4'b0001, statusReg=4'b0;
  reg[31:0] valueWB=32'b0;

  wire S_UpdateSig, branch, memWriteEn, memReadEn, writeBackEn;
  wire[3:0] exeCMD;
  wire[31:0] res1, res2;
  wire[31:0] PC;
  wire[23:0] signedImm24;
  wire[3:0] R_d;
  wire isImmidiate;
  wire shiftOperand;

  IDStage idStage(rst, clk, flush, freeze, PCIn, instructionReg, writeBackEnIn, destWB, valueWB, hazard, statusReg,
  S_UpdateSig, branch, memWriteEn, memReadEn, writeBackEn, exeCMD, res1, res2, PC, signedImm24, R_d, isImmidiate, shiftOperand);

  always #10 clk = ~clk;
  initial begin
    rst=1;
    #5   rst=0;
    #5   instructionReg = 32'b1110_00_1_1101_0_0000_0000_000000010100; //MOV;
    #100 instructionReg = 32'b1110_00_1_1101_0_0000_0001_101000000001; //MOV;
    #100 instructionReg = 32'b1110_00_1_1101_0_0000_0001_101000000001; //MOV;
    #100 instructionReg = 32'b1110_00_1_1101_0_0000_0001_101000000001; //MOV;
    #100 instructionReg = 32'b1110_00_0_0101_0_0000_0100_000000000000; //ADC; 
    #5000 $stop;
  end
endmodule