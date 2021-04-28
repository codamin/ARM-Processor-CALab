`timescale 1ns/1ns

module IFStageTB();
  reg rst=0, clk=0, freeze=0, branchTaken=0;
  reg[31:0] branchAddress=32'b0;
  wire[31:0] PC, instruction;
  IFStage ifStage(rst, clk, freeze, branchTaken, branchAddress, PC, instruction);
  
  always #10 clk = ~clk;
  initial begin
    rst=1;
    #38 rst=0;
    #2000 branchTaken=1;
    #20 branchTaken=0;
    #2000 $stop;
  end
endmodule