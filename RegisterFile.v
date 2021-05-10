`timescale 1ns/1ns
module RegisterFile(rst, clk, src1, src2, res1, res2, WB_EN, destWB, valueWB);
  input rst, clk, WB_EN;
  input[3:0] src1, src2, destWB;
  input[31:0] valueWB;
  output[31:0] res1, res2;
  reg[31:0] memory[0:15];
  
  assign res1 = memory[src1];
  assign res2 = memory[src2];
  
  integer i;
  always@(negedge clk, posedge rst) begin
    if(rst) begin
      for(i=0; i<16; i=i+1)
        memory[i] = 32'b0;
    end
    else if(WB_EN) begin
      memory[destWB] <= valueWB;
    end
  end
endmodule