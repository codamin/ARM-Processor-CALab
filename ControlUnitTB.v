`timescale 1ns/1ns

module ControlUnitTB();
    reg[1:0] mode;
    reg[3:0] opcode;
    reg S;
    wire [3:0] exeCMD;
    wire S_UpdateSig, branch, memWriteEn, memReadEn, WB_EN;

  ControlUnit UUT(mode, opcode, S, S_UpdateSig, branch, exeCMD, memWriteEn, memReadEn, WB_EN);
  
  initial begin
        mode=2'b11; opcode=4'b0000; S=1'b0; //10'bz
    #5  mode=2'b00; opcode=4'b1101; S=1'b1; //{4'b0001, S   , 1'b0, 1'b0, 1'b0, 1'b1}
    #13 mode=2'b00; opcode=4'b0010; S=1'b0; //{4'b0100, S   , 1'b0, 1'b0, 1'b0, 1'b1}
    #17 mode=2'b00; opcode=4'b1010; S=1'b0; //{4'b0100, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0}
    #19 mode=2'b00; opcode=4'b0011; S=1'b0; //10'bz
    #23 mode=2'b01; opcode=4'b0100; S=1'b1; //{4'b0010, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1}
    #29 mode=2'b01; opcode=4'b0100; S=1'b0; //{4'b0010, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0}
    #31 mode=2'b10; opcode=4'b0000; S=1'b0; //{4'b0000, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0};
    #51 $stop;
  end
endmodule