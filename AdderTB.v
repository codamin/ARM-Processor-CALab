`timescale 1ns/1ns
module AdderTB();
  reg[31:0] in1, in2;
  wire[31:0] out;
  
  Adder#(32) adder(in1, in2, out);
  initial begin
    in1 = 32'b0;
    in2 = 32'b0;
    #32 in1 = 32'b00110011001100110011001100110011;
    #32 in2 = 32'b00000000000000000000000000001100;
    #32 in1 = 23'b00000000000000000000000000101001;
    #32 $stop;
  end
endmodule
