`timescale 1ns/1ns
module EXEStage(rst, clk, carry, EXE_CMD, MEM_R_EN, MEM_W_EN, PC, Val_Rn, Val_Rm, imm, Shift_operand, Signed_imm_24, SR, ALU_result, Br_addr, status);
  input rst, clk, carry;
  input[3:0] EXE_CMD;
  input MEM_R_EN, MEM_W_EN;
  input[31:0] PC;
  input[31:0] Val_Rn, Val_Rm;
  input imm;
  input[11:0] Shift_operand;
  input[23:0] Signed_imm_24;
  input[3:0] SR;
  output[31:0] ALU_result, Br_addr;
  output[3:0] status;
  output[3:0]
  
  wire LoS;
  wire[31:0] val2;
  wire[3:0] ALU_tatus;
  
  assign OR_result = OR(MEM_R_EN, MEM_W_EN);
  ALU aLU(Val_Rn, val2, carry, EXE_CMD, ALU_result, ALU_status);
  Value2Generator value2Generator(LoS, Val_Rm, imm, Shift_operand, val2);
  assign Br_addr = PC + Signed_imm_24;
  StatusRegister statusRegister(rst, clk, S?, ALU_status, status);
endmodule