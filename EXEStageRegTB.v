`timescale 1ns/1ns
module EXEStageRegTB();
  reg rst=1, clk=0, WB_en_in=0, MEM_R_EN_in=0, MEM_W_EN_in=0;
  reg[31:0] ALU_result_in=32'b0, ST_val_in=32'b0;
  reg[3:0] Dest_in=4'b0;
  wire WB_en, MEM_R_EN, MEM_W_EN;
  wire[31:0] ALU_result, ST_val;
  wire[3:0] Dest;
  
  EXEStageReg UUT(rst, clk, WB_en_in, MEM_R_EN_in, MEM_W_EN_in, ALU_result_in, ST_val_in, Dest_in, WB_en, MEM_R_EN, MEM_W_EN, ALU_result, ST_val, Dest);
  always #10 clk=~clk;
  initial begin
    #20 rst=0;
    #40 WB_en_in = 1;
    #8 MEM_R_EN_in = 1;
    #8 MEM_W_EN_in = 1;
    #8 ALU_result_in = 32'b010101010101010111110;
    #8 ST_val_in = 32'b00111101010111011010101;
    #8 Dest_in = 4'b0111;
    #40 WB_en_in = 0;
    #8 MEM_R_EN_in = 0;
    #8 MEM_W_EN_in = 0;
    #8 ALU_result_in = 32'b00000011111101010111101;
    #8 ST_val_in = 32'b000111111111010111010101001;
    #40 $stop;
  end
endmodule