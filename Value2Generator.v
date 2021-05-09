`timescale 1ns/1ns
module Value2Generator(LoS, Val_Rm, imm, shift_operand, out);
  input LoS, imm;
  input[31:0] Val_Rm;
  input[11:0] shift_operand;
  output[31:0] out;
  
  wire[31:0] rotated_value;
  RotateImmShift rotateImmShift(shift_operand, rotated_value);
  
  wire[31:0] immShiftValue;
  ImmediateShift immShift(shift_operand, Val_Rm, immShiftValue);
  
  assign out = LoS ? {20'b0, shift_operand} : imm ? rotated_value : immShiftValue;
endmodule

module RotateImmShift(in, out);
  input[11:0] in;
  output[31:0] out;
  
  wire[63:0] tmp;
  assign tmp = {24'b0, in[7:0], 24'b0, in[7:0]} >> (2*in[11:8]);
  assign out = tmp[31:0];
endmodule

module ImmediateShift(shift_operand, Val_Rm, out);
  input[11:0] shift_operand;
  input[31:0] Val_Rm;
  output[31:0] out;
  
  assign out = (shift_operand[6:5]==2'b00) ? Val_Rm << shift_operand[11:7] :
               (shift_operand[6:5]==2'b01) ? Val_Rm >> shift_operand[11:7] :
               (shift_operand[6:5]==2'b10) ? Val_Rm >>> shift_operand[11:7] :
               (shift_operand[6:5]==2'b11) ? {Val_Rm, Val_Rm} >> shift_operand[11:7] :
               32'b0;
endmodule
  
