`timescale 1ns/1ns
module ALUTB();
  reg[31:0] in1, in2;
  reg[3:0] carry, command;
  wire[31:0] out;
  wire[3:0] status;
  ALU alu(in1, in2, carry, command, out, status);
  
  initial begin
    #10 command = 4'b1001;
    carry = 4'b0101;
    #10 in1 = 32'b00001111000011110000111100001111;
    #10 in2 = 32'b10101101110111001010100100011101;
    #20 command = 4'b0001;
    #10 command = 4'b0010;
    #10 command = 4'b0011;
    #10 command = 4'b0100;
    #10 command = 4'b0101;
    #10 command = 4'b0110;
    #10 command = 4'b0111;
    #10 command = 4'b1000;
    #10 command = 4'b0100;
    #10 command = 4'b0110;
    #10 command = 4'b0010;
    #50 $stop;
  end
endmodule