module HazardDetectionUnit(two_src, src1, src2, EXE_Dest, EXE_WB_EN, MEM_Dest, MEM_WB_EN, hazard_detected);

input[3:0] src1, src2, EXE_Dest, MEM_Dest;
input two_src, EXE_WB_EN, MEM_WB_EN;
output hazard_detected;

wire type1, type2, type3, type4;

assign type1 = (src1==EXE_Dest) & EXE_WB_EN;
assign type2 = (src1==MEM_Dest) & MEM_WB_EN;
assign type3 = (src2==EXE_Dest) & EXE_WB_EN & two_src;
assign type4 = (src2==MEM_Dest) & MEM_WB_EN & two_src;

assign hazard_detected = type1 || type2 || type3 || type4;
endmodule