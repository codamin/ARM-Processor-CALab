`timescale 1ns/1ns

module MainTB();
  reg rst=0, clk=0, FW_EN=1;
  reg[15:0] counter=7'b0;
  Main UUT(rst, clk, FW_EN);
  always #10 begin
    clk=~clk;
  end

  always@(posedge clk)
    counter = counter + 1;

  initial begin
    rst = 1;
    #5 rst = 0;
    #6500 $stop;
  end
endmodule
