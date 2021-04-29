`timescale 1ns/1ns
module EXEStageReg(rst, clk, WB_en_in, MEM_R_EN_in, MEM_W_EN_in, ALU_result_in, ST_val_in, Dest_in, WB_en, MEM_R_EN, MEM_W_EN, ALU_result, ST_val, Dest);
  input rst, clk, WB_en_in, MEM_R_EN_in, MEM_W_EN_in;
  input[31:0] ALU_result_in, ST_val_in;
  input[3:0] Dest_in;
  output reg WB_en, MEM_R_EN, MEM_W_EN;
  output reg[31:0] ALU_result, ST_val;
  output reg[3:0] Dest;
  
  always@(posedge clk, posedge rst) begin
    if(rst) begin
      {WB_en, MEM_R_EN, MEM_W_EN} <= 3'b0;
      {ALU_result, ST_val} <= 64'b0;
      Dest <= 4'b0;
    end
    else begin
      {WB_en, MEM_R_EN, MEM_W_EN} <= {WB_en_in, MEM_R_EN_in, MEM_W_EN_in};
      {ALU_result, ST_val} <= {ALU_result_in, ST_val_in};
      Dest <= Dest_in;
    end
  end
endmodule