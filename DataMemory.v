`timescale 1ns/1ns
module DataMemory(rst, clk, readSig, writeSig, address, dataIn, dataOut);
  input rst, clk, readSig, writeSig;
  input[31:0] address;
  input[31:0] dataIn;
  output[31:0] dataOut;
  reg[31:0] memory[0:64535];
  integer i;
  
  wire[31:0] addr;
  assign addr = (address - 11'b10000000000) >> 2;
  assign dataOut = memory[addr];
  
  always@(posedge clk, posedge rst) begin
    if(rst) begin
      for(i=0; i<65536; i=i+1) begin
        memory[i] = 32'b0;
      end
    end
    else if(writeSig) begin
      memory[addr] <= dataIn;
    end
  end
endmodule