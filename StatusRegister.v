`timescale 1ns/1ns
module StatusRegister(rst, clk, S, Status_bits, out);
  input rst, clk, S;
  input[3:0] Status_bits;
  output reg[3:0] out;
  
  always@(posedge rst)
    out <= 4'b0;
  always@(negedge clk) begin
    if(S)
      out <= Status_bits;
  end
endmodule