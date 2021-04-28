`timescale 1ns/1ns
module IFStageRegTB();
  reg clk=0, rst=0, freeze=0, flush=0;
  reg[31:0] PCIn, instructionIn;
  wire[31:0] PC, instruction;
  
  IFStageReg ifStageReg(clk, rst, freeze, flush, PCIn, instructionIn, PC, instruction);
  always #10 clk = ~clk;
  initial begin
    #3 rst=1;
    #30 rst=0;
    #30 PCIn = 32'b00001111000011110000111100001111;
    #30 instructionIn = 32'b00110011001100110011001100110011;
    #30 freeze=1;
    #30 PCIn = 32'b01010101001011010110101010101001;
    #30 instructionIn = 32'b10101010100100011010101010010101;
    #30 freeze=0;
    #30 flush=1;
    #30 PCIn = 32'b00000111010101110101111010000000;
    #30 $stop;
  end
  
endmodule