`timescale 1ns/1ns
module ALU(in1, in2, carry, command, out, status);
  input[31:0] in1, in2;
  input carry;
  input[3:0] command;
  output[31:0] out;
  output[3:0] status;
  
  wire Z, N, C, V, tc;
  assign status = {N, Z, C, V};
  
  assign out = (command == 4'b0001) ? in2 : 32'bz;
  assign out = (command == 4'b1001) ? ~in2 : 32'bz;
  assign {tc, out} = (command == 4'b0010) ? in1+in2 : 33'bz;
  assign {tc, out} = (command == 4'b0011) ? in1+in2+carry : 33'bz;
  assign {tc, out} = (command == 4'b0100) ? in1-in2 : 33'bz;
  assign {tc, out} = (command == 4'b0101) ? in1-in2-!carry : 33'bz;
  assign out = (command == 4'b0110) ? in1&in2 : 32'bz;
  assign out = (command == 4'b0111) ? in1|in2 : 32'bz;
  assign out = (command == 4'b1000) ? in1^in2 : 32'bz;
  assign out = (command == 4'b0100) ? in1-in2 : 32'bz;
  assign out = (command == 4'b0110) ? in1&in2 : 32'bz;
  assign out = (command == 4'b0010) ? in1+in2 : 32'bz;
  
  assign Z = (out == 32'b0) ? 1 : 0;
  assign N = out[31];
  assign V = ((command==4'b0010 || command==4'b0011) && (in1[31] == in2[31] && in1[31] != out[31])) ||
        ((command==4'b0100 || command==4'b0101) && (in1[31]!=in2[31] && in2[31]==out[31]));
  assign C = ((command==4'b0010 || command==4'b0011) || (command==4'b0100 || command==4'b0101)) ? tc : 0;
endmodule