`timescale 1ns/1ns
module CacheController(input rst, input clk, 
// memory stage unit
    input[31:0] addr,
    input[31:0] wdata,
    input MEM_R_EN,
    input MEM_W_EN,
    output [31:0] rdata,
    output ready,
// SRAM controller
    output [16:0] sram_address,
    output [31:0] sram_wdata,
    output reg sram_write,
    input [63:0] sram_rdata,
    input sram_ready,
// CACHE
    input hit,
    input[31:0] cache_rdata,
    output reg cache_R_EN,
    output reg cache_W_EN,
    output reg cache_invalidate,
    output[63:0] cache_miss_write_back);
/////////////////////////////////////////////////////////////////////
assign ready = (~MEM_R_EN & ~MEM_W_EN) | hit | sram_ready;
assign rdata = hit ? cache_rdata : sram_ready ? (sram_address[0] ? sram_rdata[63:32] : sram_rdata[31:0]) : 32'b0; 
assign sram_address = addr;
assign cache_miss_write_back = sram_rdata;

reg[2:0] ps, ns;
parameter[2:0] idle=0, Sread=1, Sread_Wait=2, Swrite=3, Swrite_Wait=4;

always@(*) begin
	case(ps)

      idle: begin
        ns = MEM_R_EN ? Sread : MEM_W_EN ? Swrite : idle;
      end 

      Swrite: begin
        ns = Swrite_Wait;
      end

      Swrite_Wait: begin
        ns = sram_ready ? idle : Swrite_Wait;
      end

      Sread: begin
        ns = Sread_Wait;
      end

      Sread_Wait: begin
        ns = sram_ready ? idle : Sread_Wait;
      end

      default: ns = idle;
    endcase
  end
/////////////////////////////////////////////////////////////
always@(ps, MEM_R_EN, MEM_W_EN) begin
    {cache_invalidate, cache_R_EN, sram_write, cache_W_EN} = 0;
	case(ps)
      Swrite: begin
        sram_write = 1'b1;
        cache_invalidate = 1'b1;
      end

      Sread: begin
        cache_R_EN = 1'b1;
      end

      Sread_Wait: begin
        cache_W_EN = sram_ready == 1'b1;
      end
      default: ns = idle;
    endcase
end
/////////////////////////////////////////////////////////////
always@(posedge clk, posedge rst) begin
    if(rst) begin
        ps <= idle;
        ns <= idle;
    end
    else begin
    ps <= ns;
    end
end
endmodule