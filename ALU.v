`timescale 1ns/1ns
module ALU(in1, in2, carry, command, out, status);
  input[31:0] in1, in2;
  input[3:0] carry, command;
  output[31:0] out;
  output status;
  
  assign out = (command == 4'b0001) ? in2 : 32'bz;
  assign out = (command == 4'b1001) ? ~in2 : 32'bz;
  assign out = (command == 4'b0010) ? in1+in2 : 32'bz;
  assign out = (command == 4'b0011) ? in1+in2+carry : 32'bz;
  assign out = (command == 4'b0100) ? in1-in2 : 32'bz;
  assign out = (command == 4'b0101) ? in1-in2-!carry : 32'bz;
  assign out = (command == 4'b0110) ? in1&in2 : 32'bz;
  assign out = (command == 4'b0111) ? in1|in2 : 32'bz;
  assign out = (command == 4'b1000) ? in1^in2 : 32'bz;
  assign out = (command == 4'b0100) ? in1-in2 : 32'bz;
  assign out = (command == 4'b0110) ? in1&in2 : 32'bz;
  assign out = (command == 4'b0010) ? in1+in2 : 32'bz;
  //assign out = (command == 4'b0010) ?  : 32'bz;
endmodule