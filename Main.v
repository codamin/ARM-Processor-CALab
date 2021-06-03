`timescale 1ns/1ns
module Main(rst, clk, FW_EN, SRAM_DQ, SRAM_ADDR, SRAM_WE_N);

  input rst, clk, FW_EN;
  inout[31:0] SRAM_DQ;
  output[16:0] SRAM_ADDR;
  output SRAM_WE_N;

  // wire[31:0] branchAddress_EXE_OUT;
  wire flush, hazard;
  wire[31:0] PC_IF_OUT, instructionReg_IF_OUT;
  wire[3:0] destWB_EXE_OUT, statusReg_EXE_OUT;
  wire[3:0] exeCMD_ID_OUT, Dest_ID_R_OUT;
  wire[31:0] valueWB_EXE_OUT;
  wire S_UpdateSig_ID_OUT, branch_ID_OUT, memWriteEn_ID_OUT, memReadEn_ID_OUT, WB_EN_ID_OUT;
  wire[3:0] exeCMD_ID_R_OUT;
  wire[31:0] res1_ID_OUT, res2_ID_OUT, res1_ID_R_OUT, res2_ID_R_OUT, PC_ID_R_OUT;
  wire[31:0] PC_ID_OUT, ALU_result_EXE_OUT, Br_addr_EXE_OUT;
  wire[23:0] Signed_imm_24_ID_R_OUT, SignedImm24_ID_OUT;
  wire[11:0] shiftOperand_ID_R_OUT;
  wire[3:0] Dest_ID_OUT, status_EXE_OUT;
  wire isImmidiate_ID_OUT;
  wire[11:0] shiftOperand_ID_OUT;
  wire branchTaken_EXE_OUT;
  wire carry;
  wire two_src;
  wire [3:0] src1_ID_OUT, src2_ID_OUT, src1_ID_R_OUT, src2_ID_R_OUT;
  
  wire WB_EN_EXE_R_OUT, MEM_R_EN_EXE_R_OUT, MEM_W_EN_EXE_R_OUT;
  wire[31:0] ALU_result_EXE_R_OUT, ST_val_EXE_OUT, ST_val_EXE_R_OUT;
  wire[3:0] Dest_EXE_R_OUT;
  
  wire[31:0] MEM_result_MEM;
  wire WB_EN_MEM_R_OUT, MEM_R_en_MEM_R_OUT;
  wire[31:0] ALU_result_MEM_R_OUT, Mem_read_value_MEM_R_OUT;
  wire[3:0] Dest_MEM_R_OUT;
  wire branch_ID_R_OUT;
  
  wire[31:0] WB_value;
  
  wire[1:0] sel1_FW_OUT, sel2_FW_OUT;
  assign flush = branch_ID_R_OUT;
  assign branchTaken_EXE_OUT = branch_ID_R_OUT;

  wire SRAM_Controller_Ready, memStageFreezeSig;
  wire iFStageFreezeSig;
  assign iFStageFreezeSig = hazard | memStageFreezeSig;

  IFStage iFStage(rst, clk, iFStageFreezeSig, branchTaken_EXE_OUT, Br_addr_EXE_OUT, PC_IF_OUT, instructionReg_IF_OUT);

  IDStage iDStage(.rst(rst), .clk(clk), .flush(flush), .PCIn(PC_IF_OUT), .instructionReg(instructionReg_IF_OUT),
    .WB_EN_IN(WB_EN_MEM_R_OUT), .destWB(Dest_MEM_R_OUT), .valueWB(WB_value), .hazard(hazard), .statusReg(status_EXE_OUT),
   .S_UpdateSig(S_UpdateSig_ID_OUT), .branch(branch_ID_OUT), .memWriteEn(memWriteEn_ID_OUT), .memReadEn(memReadEn_ID_OUT),
   .WB_EN(WB_EN_ID_OUT), .exeCMD(exeCMD_ID_OUT), .res1(res1_ID_OUT), .res2(res2_ID_OUT), .PC(PC_ID_OUT),
   .signedImm24(SignedImm24_ID_OUT), .Dest(Dest_ID_OUT), .isImmidiate(isImmidiate_ID_OUT), .shiftOperand(shiftOperand_ID_OUT),
   .two_src(two_src), .src1(src1_ID_OUT), .src2(src2_ID_OUT));

  IDStageReg iDStageReg(.rst(rst), .clk(clk),.freeze(memStageFreezeSig), .flush(flush), .S_UpdateSigIn(S_UpdateSig_ID_OUT), .branchIn(branch_ID_OUT),
    .memWriteEnIn(memWriteEn_ID_OUT), .memReadEnIn(memReadEn_ID_OUT), .WB_EN_IN(WB_EN_ID_OUT), .exeCMDIn(exeCMD_ID_OUT),
    .res1In(res1_ID_OUT), .res2In(res2_ID_OUT), .PCIn(PC_ID_OUT), .signedImm24In(SignedImm24_ID_OUT), .DestIn(Dest_ID_OUT),
    .isImmidiateIn(isImmidiate_ID_OUT), .shiftOperandIn(shiftOperand_ID_OUT), .carryIn(status_EXE_OUT[1]), .src1In(src1_ID_OUT), .src2In(src2_ID_OUT),
    .S_UpdateSig(S_UpdateSig_ID_R_OUT), .branch(branch_ID_R_OUT), .memWriteEn(memWriteEn_ID_R_OUT), .memReadEn(memReadEn_ID_R_OUT),
    .WB_EN(WB_EN_ID_R_OUT), .exeCMD(exeCMD_ID_R_OUT), .res1(res1_ID_R_OUT), .res2(res2_ID_R_OUT), .PC(PC_ID_R_OUT),
    .signedImm24(Signed_imm_24_ID_R_OUT), .Dest(Dest_ID_R_OUT), .isImmidiate(isImmidiate_ID_R_OUT), .shiftOperand(shiftOperand_ID_R_OUT),
    .carry(carry), .src1(src1_ID_R_OUT), .src2(src2_ID_R_OUT));
  
  HazardDetectionUnit hazardDetectionUnit(FW_EN, two_src, src1_ID_OUT, src2_ID_OUT, Dest_ID_R_OUT, WB_EN_ID_R_OUT, Dest_EXE_R_OUT,
   WB_EN_EXE_R_OUT, memReadEn_ID_R_OUT, hazard);

  ForwardingUnit forwardingUnit(FW_EN, src1_ID_R_OUT, src2_ID_R_OUT, Dest_EXE_R_OUT, WB_EN_EXE_R_OUT, Dest_MEM_R_OUT, WB_EN_MEM_R_OUT,
   sel1_FW_OUT, sel2_FW_OUT);

  EXEStage exeStage(rst, clk, S_UpdateSig_ID_R_OUT, carry, exeCMD_ID_R_OUT, memReadEn_ID_R_OUT, memWriteEn_ID_R_OUT, PC_ID_R_OUT,
   res1_ID_R_OUT, res2_ID_R_OUT, isImmidiate_ID_R_OUT, shiftOperand_ID_R_OUT, Signed_imm_24_ID_R_OUT, ALU_result_EXE_R_OUT,
    WB_value, sel1_FW_OUT, sel2_FW_OUT, ST_val_EXE_OUT, ALU_result_EXE_OUT, Br_addr_EXE_OUT, status_EXE_OUT);

  EXEStageReg exeStageReg(rst, clk, memStageFreezeSig, WB_EN_ID_R_OUT, memReadEn_ID_R_OUT, memWriteEn_ID_R_OUT, ALU_result_EXE_OUT, ST_val_EXE_OUT,
   Dest_ID_R_OUT, WB_EN_EXE_R_OUT, MEM_R_EN_EXE_R_OUT, MEM_W_EN_EXE_R_OUT, ALU_result_EXE_R_OUT, ST_val_EXE_R_OUT, Dest_EXE_R_OUT);
  
  // DataMemory memStage(rst, clk, MEM_R_EN_EXE_R_OUT, MEM_W_EN_EXE_R_OUT, ALU_result_EXE_R_OUT, ST_val_EXE_R_OUT, MEM_result_MEM);
  
  SRAM_Controller memStage(.clk(clk), .rst(rst), .write_en(MEM_W_EN_EXE_R_OUT), .read_en(MEM_R_EN_EXE_R_OUT), .address(ALU_result_EXE_R_OUT),
                            .writeData(ST_val_EXE_R_OUT), .readData(MEM_result_MEM), .ready(SRAM_Controller_Ready), .SRAM_DQ(SRAM_DQ), .SRAM_ADDR(SRAM_ADDR), .SRAM_WE_N(SRAM_WE_N));
  assign memStageFreezeSig = ~SRAM_Controller_Ready;

  MemStageReg memStageReg(rst, clk, memStageFreezeSig, WB_EN_EXE_R_OUT, MEM_R_EN_EXE_R_OUT, ALU_result_EXE_R_OUT, MEM_result_MEM, Dest_EXE_R_OUT,
   WB_EN_MEM_R_OUT, MEM_R_en_MEM_R_OUT, ALU_result_MEM_R_OUT, Mem_read_value_MEM_R_OUT, Dest_MEM_R_OUT);
    
  WBStage wbStage(ALU_result_MEM_R_OUT, Mem_read_value_MEM_R_OUT, MEM_R_en_MEM_R_OUT, WB_value);

endmodule