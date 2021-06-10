`timescale 1ns/1ns
module Cache(rst, clk, addr, R_EN, W_EN, data_in, invalidate, WB_EN, hit, data_out);
  input rst, clk;
  input[18:0] addr;
  input R_EN, W_EN, invalidate, WB_EN;
  input [63:0] data_in;
  output hit;
  output[31:0] data_out;
/////////////////////////////////////////////////
// decoding address
  reg[5:0] index;
  reg[9:0] tag;
  assign index = addr[18:13];
  assign tag = addr[12:3];  
/////////////////////////////////////////////////
// way1 blocks
  reg[31:0] way_0_data_0[0:63];
  reg[31:0] way_0_data_1[0:63];
  reg[9:0] tag_way_0[0:63];
  reg valid_way_0[0:63];  
// way2 blocks
  reg[31:0] way_1_data_0[0:63];
  reg[31:0] way_1_data_1[0:63];
  reg[9:0] tag_way_1[0:63];
  reg valid_way_1[0:63];
// lru bit 
  reg used_block[0:63];
/////////////////////////////////////////////////
wire[31:0] way_0_out;
wire[31:0] way_1_out;
assign way_0_out = addr[2] ? way_0_data_0[index] : way_0_data_1[index];
assign way_1_out = addr[2] ? way_1_data_0[index] : way_1_data_1[index];

wire way_0_hit;
wire way_1_hit;
assign way_0_hit = (tag == tag_way_0[index]) & valid_way_0[index];
assign way_1_hit = (tag == tag_way_1[index]) & valid_way_1[index];

assign data_out = way_0_hit ? way_0_out : way_1_hit ? way_1_out : 32'bx;


always@(posedge clk) begin
  if(W_EN) begin
    case(used_block[index])
      0: begin
        if(addr[2]) begin
          way_1_data_1[index] <= data_in;
        end
        else begin
          way_1_data_0[index] <= data_in;
        end
        tag_way_1[index] <= tag;
        valid_way_1[index] <= 1;
      end
      1: begin
        if(addr[2]) begin
          way_0_data_1[index] <= data_in;
        end
        else begin
          way_0_data_0[index] <= data_in;
        end
        tag_way_0[index] <= tag;
        valid_way_0[index] <= 1;
      end
    endcase
    used_block[index] <= ~used_block[index];
  end
  else if(R_EN) begin
    used_block[index] <= way_0_hit ? 0 : way_1_hit ? 1 : used_block[index];
  end
end
endmodule