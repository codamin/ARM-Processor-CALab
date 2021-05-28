`timescale 1ns/1ns

module MUX3to1(in1, in2, in3, sel, out);
  parameter Length = 32;
  input[Length-1:0] in1, in2, in3;
  input[1:0] sel;
  
  output[Length-1:0] out;
  assign out =
    (sel==2'b00) ? in1 :
    (sel==2'b01) ? in2 :
    (sel==2'b10) ? in3 : 0;
endmodule