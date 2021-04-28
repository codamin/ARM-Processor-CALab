`timescale 1ns/1ns

module MUX2to1(in1, in2, sel, out);
  parameter Length = 32;
  input[Length-1:0] in1, in2;
  input sel;
  output[Length-1:0] out;
  assign out = (sel==1'b0) ? in1 : in2;
endmodule