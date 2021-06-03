`timescale 1ns/1ns

module MainTB();
  reg rst=0, clkMain=0, clkSRAM=0, FW_EN=1;
  reg[15:0] counter=16'b0;

  wire[31:0] SRAM_DQ;
  wire[16:0] SRAM_ADDR;
  wire SRAM_WE_N;
  Main UUTMain(.rst(rst), .clk(clkMain), .FW_EN(FW_EN), .SRAM_DQ(SRAM_DQ), .SRAM_ADDR(SRAM_ADDR), .SRAM_WE_N(SRAM_WE_N));
  SRAM UUTSRAM(.clk(clkSRAM), .rst(rst), .SRAM_WE_N(SRAM_WE_N), .SRAM_ADDR(SRAM_ADDR), .SRAM_DQ(SRAM_DQ));

  always #10 begin
    clkMain=~clkMain;
  end
  always #20 begin
    clkSRAM=~clkSRAM;
  end

  always@(posedge clkMain)
    counter = counter + 1;

  initial begin
    rst = 1;
    #5 rst = 0;
    #11000 $stop;
  end
endmodule