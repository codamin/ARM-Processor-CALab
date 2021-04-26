`timescale 1ns/1ns
module PC(rst, clk, freeze, in, out);
  input rst, clk, freeze;
  input[31:0] in;
  output reg[31:0] out;
  
  always@(posedge clk) begin
    if(rst)
      out <= 32'b00000000000000000000000000000000;
    else if(freeze == 1'b0)
      out <= in;
  end
endmodule