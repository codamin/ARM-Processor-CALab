`timescale 1ns/1ns
module MainTB();
  reg clk=0, rst=0;

  Main UUT(rst, clk);
  
  always #10 clk = ~clk;
  initial begin
    #5 rst = 1;
    #5 rst = 0;
    #2000 $stop;
  end
  
endmodule