`timescale 1ns/1ns
module RegisterFileTB();
  reg rst=0, clk=0, WB_EN=0;
  reg[3:0] src1=4'b0, src2=4'b0, destWB=4'b0;
  reg[31:0] valueWB=32'b0;
  wire[31:0] res1, res2;
  RegisterFile registerFile(rst, clk, src1, src2, res1, res2, WB_EN, destWB, valueWB);
  
  always #8 clk = ~clk;
  initial begin
    rst=1;
    #35 rst=0;
    valueWB = 32'b00000000000000000000000000000001;
    WB_EN=1'b1;
    #10 WB_EN=1'b0;
    valueWB = 32'b00000000000000000000000000000010;
    destWB = 4'b0001;
    WB_EN=1'b1;
    #10 WB_EN=1'b0;
    src1 = 4'b0001;
    src2 = 4'b0010;
    valueWB = 32'b00000000000000000000000000000100;
    destWB = 4'b0010;
    WB_EN=1'b1;
    #10 WB_EN=1'b0;
    #43 $stop;
  end
endmodule