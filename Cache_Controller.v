`timescale 1ns/1ns
module CacheController(
    input rst,
    input clk,

    // memory stage unit
    input[31:0] addr,
    input[31:0] wdata,
    input MEM_R_EN,
    input MEM_W_EN,
    output [31:0] rdata,
    ouput ready,
    
    // SRAM controller
    output [31:0] sram_address,
    output [31:0] sram_wdata,
    output write,
    input [63:0] sram_rdata,
    input sram_ready);


    

endmodule