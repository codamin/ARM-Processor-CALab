`timescale 1ns/1ns
module Adder(in1, in2, out);
  parameter Length = 32;
  input[Length-1:0] in1, in2;
  output[Length-1:0] out;
  
  assign out = in1+in2;
endmodule
