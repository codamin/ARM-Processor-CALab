`timescale 1ns/1ns
module MUX2to1TB();
  reg[31:0] ina, inb;
  reg sel;
  wire[31:0] out;
  
  MUX2to1#(32) UUT(ina, inb, sel, out);
  initial begin
    #2 ina = 32'b0;
    #3 inb = 32'b1;
    #2 sel = 1'b0;
    #85 sel = 1'b1;
    #85 sel = 1'b0;
    #3 ina = 32'b0101010101010101010101010101010101;
    #85 $stop;
  end
endmodule