`timescale 1ns/1ns

module IFStageReg(clk, rst, freeze, flush, PCIn, instructionIn, PC, instruction);
  input clk, rst, freeze, flush;
  input[31:0] PCIn, instructionIn;
  output reg[31:0] PC, instruction;
  
  always@(posedge clk, posedge rst) begin
    if(rst) begin
      PC <= 32'b0;
      instruction <= 32'b0;
    end
    else if(flush) begin
      PC <= 32'b0;
      instruction <= 32'b0;
    end
    else if(freeze == 1'b0) begin
      PC <= PCIn;
      instruction <= instructionIn;
    end
  end
endmodule