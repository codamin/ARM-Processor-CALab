`timescale 1ns/1ns
module DataMemoryTB();
  reg rst, clk=0, readSig, writeSig;
  reg[31:0] address;
  reg[31:0] dataIn;
  wire[31:0] dataOut;
  
  DataMemory UUT(rst, clk, readSig, writeSig, address, dataIn, dataOut);
  
  always #8 clk = ~clk;
  initial begin
    clk=0;
    rst=1;
    #28 rst=0;
    readSig=0;
    writeSig=0;
    address=32'b0;
    dataIn=32'b0;
    
    #25 dataIn = 32'b01010101010101010101010101010101;
    address = 32'b000000010000000000;
    writeSig = 1;
    #35 dataIn = 32'b10101010101010101010101010101010;
    address = 32'b000000010000000110;
    #48 dataIn = 32'b11111111111111110000000000000000;
    address = 32'b000000010000001001;
    #39 $stop;
  end
endmodule
