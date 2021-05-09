`timescale 1ns/1ns

module WBStage(ALU_result, MEM_result, MEM_R_en, out);
  input[31:0] ALU_result, MEM_result;
  input MEM_R_en;
  output[31:0] out;
  
  MUX2to1#(32) mux2to1(ALU_result, MEM_result, MEM_R_en, out);
endmodule