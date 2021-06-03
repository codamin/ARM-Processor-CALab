`timescale 1ns/1ns

module SRAM_Controller(clk, rst, write_en, read_en, address, writeData, readData, ready, SRAM_DQ, SRAM_ADDR, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N);
  input clk, rst, write_en, read_en;
  input[31:0] address, writeData;
  output[31:0] readData;
  output ready;
  inout[31:0] SRAM_DQ;
  output[16:0] SRAM_ADDR;
  output SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N;
  
endmodule