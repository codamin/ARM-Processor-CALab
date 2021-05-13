`timescale 1ns/1ns

module MainTB();
  reg rst=0, clk=0;
  Main UUT(rst, clk);
  always #10 clk=~clk;
  initial begin
    rst = 1;
    #5 rst = 0;
    #6500 $stop;
  end
endmodule
