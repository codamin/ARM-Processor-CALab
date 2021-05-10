`timescale 1ns/1ns

module ControlUnit(mode, opcode, S, S_UpdateSig, branch, exeCMD, memWriteEn, memReadEn, WB_EN);
    input[1:0] mode;
    input[3:0] opcode;
    input S;

    output reg[3:0] exeCMD;
    output reg S_UpdateSig, branch, memWriteEn, memReadEn, WB_EN;

    always@(*) begin
        case(mode)
            // Operational Commands
            2'b00: begin
                {exeCMD, S_UpdateSig, branch, memWriteEn, memReadEn, WB_EN} =
                (opcode == 4'b1101) ? {4'b0001, S   , 1'b0, 1'b0, 1'b0, 1'b1} :
                (opcode == 4'b1111) ? {4'b1001, S   , 1'b0, 1'b0, 1'b0, 1'b1} :
                (opcode == 4'b0100) ? {4'b0010, S   , 1'b0, 1'b0, 1'b0, 1'b1} :
                (opcode == 4'b0101) ? {4'b0011, S   , 1'b0, 1'b0, 1'b0, 1'b1} :
                (opcode == 4'b0010) ? {4'b0100, S   , 1'b0, 1'b0, 1'b0, 1'b1} :
                (opcode == 4'b0110) ? {4'b0101, S   , 1'b0, 1'b0, 1'b0, 1'b1} :
                (opcode == 4'b0000) ? {4'b0110, S   , 1'b0, 1'b0, 1'b0, 1'b1} :
                (opcode == 4'b1100) ? {4'b0111, S   , 1'b0, 1'b0, 1'b0, 1'b1} :
                (opcode == 4'b0001) ? {4'b1000, S   , 1'b0, 1'b0, 1'b0, 1'b1} :
                (opcode == 4'b1010) ? {4'b0100, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0} :
                (opcode == 4'b1000) ? {4'b0110, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0} : 10'bz;
            end
            // Load & Store
            2'b01: begin
                {exeCMD, S_UpdateSig, branch, memWriteEn, memReadEn, WB_EN} =
                (S == 1'b1) ? {4'b0010, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1} :
                (S == 1'b0) ? {4'b0010, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0} : 10'bz;
            end
            // Branch
            2'b10: begin
                {exeCMD, S_UpdateSig, branch, memWriteEn, memReadEn, WB_EN} =
                {4'b0000, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0};
            end
        default
            {exeCMD, S_UpdateSig, branch, memWriteEn, memReadEn, WB_EN} <= 10'bz;
        endcase
    end
endmodule