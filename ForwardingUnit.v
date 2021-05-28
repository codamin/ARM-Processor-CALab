module ForwardingUnit(FW_EN, src1, src2, MEM_Dest, MEM_WB_EN, WB_Dest, WB_WB_EN, sel1, sel2);


input[3:0] src1, src2, MEM_Dest, WB_Dest;
input FW_EN, MEM_WB_EN, WB_WB_EN;
output[1:0] sel1, sel2;

wire type1, type2;

assign type1 = (src1==MEM_Dest) & MEM_WB_EN;
assign type2 = (src1==WB_Dest) & WB_WB_EN;
assign type3 = (src2==MEM_Dest) & MEM_WB_EN;
assign type4 = (src2==WB_Dest) & WB_WB_EN;

assign sel1 =
    ~FW_EN ? 2'b00 :
    type1  ? 2'b01 :
    type2  ? 2'b10 :
          2'b00;

assign sel2 =  
    ~FW_EN ? 2'b00 :
    type3  ? 2'b01 :
    type4  ? 2'b10 :
          2'b00;

endmodule