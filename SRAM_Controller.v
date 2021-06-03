`timescale 1ns/1ns

module SRAM_Controller(clk, rst, write_en, read_en, address, writeData, readData, ready, SRAM_DQ, SRAM_ADDR, SRAM_WE_N);
  input clk, rst, write_en, read_en;
  input[31:0] address, writeData;
  output[31:0] readData;
  output reg ready;
  inout [31:0] SRAM_DQ;
  output reg[16:0] SRAM_ADDR;
  // output SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N;
  output reg SRAM_WE_N;
  // assign ready = write_en | read_en;
  reg[31:0] SRAM_DQ_TMP;
  
  wire[31:0] addr;
  assign addr = (address - 11'b10000000000) >> 2;
  assign readData = SRAM_DQ;
  // assign {SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N} = 4'b0000;
  
  reg[2:0] ps, ns;
  integer waitStep = 0;
  parameter[2:0] idle=0, read=1, write=2, waitW=3, waitW2=4, waitR=5, waitR2=6, en=7;

  assign SRAM_DQ = (ps==write | ps == waitW | ps == waitW2) ? SRAM_DQ_TMP : 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;

  always@(*) begin
		case(ps)
      idle: ns = read_en ? read : write_en ? write : idle;
      write: begin
        ns = waitW;
        waitStep = 0;
      end
      read: begin
        ns = waitR;
        waitStep = 0;
      end
      waitW: begin
        if(waitStep == 4) begin
          ns = en;
        end
        else begin
          ns = waitW2;
          waitStep = waitStep + 1;
        end
      end
      waitW2: begin
        if(waitStep == 4) begin
          ns = en;
        end
        else begin
          ns = waitW;
          waitStep = waitStep + 1;
        end
      end

      waitR: begin
        if(waitStep == 4) begin
          ns = en;
        end
        else begin
          ns = waitR2;
          waitStep = waitStep + 1;
        end
      end
      waitR2: begin
        if(waitStep == 4) begin
          ns = en;
        end
        else begin
          ns = waitR;
          waitStep = waitStep + 1;
        end
      end

      en: ns = idle;
			default: ns = idle;
		endcase
  end

  always@(ps, write_en, read_en) begin
    ready = 1'b0;
    SRAM_WE_N = 1'b1;
    SRAM_ADDR = addr;
    case(ps)
      idle: begin
        if(read_en | write_en) begin
          ready = 1'b0;
        end
        else begin
          ready = 1'b1;
        end
        // readData = SRAM_DQ;
      end
      write: begin
        SRAM_WE_N = 1'b0;
        // SRAM_ADDR = addr;
        SRAM_DQ_TMP = writeData;
      end
      waitW: SRAM_WE_N = 1'b0;
      waitW2: SRAM_WE_N = 1'b0;
      en: begin
        // readData = SRAM_DQ;
        ready = 1'b1;
      end
      // read: SRAM_ADDR = addr;
		endcase
  end

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