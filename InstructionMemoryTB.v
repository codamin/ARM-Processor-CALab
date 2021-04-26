`timescale 1ns/1ns
module InstructionMemoryTB();
  reg[31:0] address=32'b0;
  wire[31:0] instruction;
  InstructionMemory UUT(address, instruction);

  initial begin
    #3 address = 32'b0000000000000000000000000000000;
    #8 address = 32'b0000000000000000000000000000001;
    #9 address = 32'b0000000000000000000000000000010;
    #9 address = 32'b0000000000000000000000000000011;
    #85 $stop;
  end

endmodule