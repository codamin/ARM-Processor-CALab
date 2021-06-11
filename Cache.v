`timescale 1ns/1ns
module Cache(rst, clk, addr, R_EN, W_EN, data_in, invalidate, hit, data_out);
  input rst, clk;
  input[18:0] addr;
  input R_EN, W_EN, invalidate;
  input [63:0] data_in;
  output hit;
  output[31:0] data_out;
/////////////////////////////////////////////////
// decoding address
  wire[5:0] index;
  wire[9:0] tag;
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

assign hit = way_0_hit | way_1_hit;
assign data_out = way_0_hit ? way_0_out : way_1_hit ? way_1_out : 32'b0;


always@(posedge clk) begin
  if(W_EN) begin
    case(used_block[index])
      0: begin
        way_1_data_1[index] <= data_in[63:32];
        way_1_data_0[index] <= data_in[31:0];
        tag_way_1[index] <= tag;
        valid_way_1[index] <= 1;
      end
      1: begin
        way_0_data_1[index] <= data_in[63:32];
        way_0_data_0[index] <= data_in[31:0];
        tag_way_0[index] <= tag;
        valid_way_0[index] <= 1;
      end
    endcase
    used_block[index] <= ~used_block[index];
  end
  else if(R_EN) begin
    used_block[index] <= way_0_hit ? 0 : way_1_hit ? 1 : used_block[index];
  end
  else if(invalidate) begin
    if(way_0_hit) begin
      valid_way_0[index] = 0;
    end
    else if(way_1_hit) begin
      valid_way_1[index] = 0;
    end
  end
end
endmodule