`timescale 1ns/1ns

module ConditionCheckTB();
    reg[3:0] cond;
    reg N, Z, C, V;
    wire conditionOut;

  ConditionCheck UUT(cond, N, Z, C, V, conditionOut);
  
  initial begin 
    #1 cond = 0;  {N, Z, C, V} = 4'b0100; //1
    #5 cond = 1;  {N, Z, C, V} = 4'b0100; //0
    #5 cond = 2;  {N, Z, C, V} = 4'b0010; //1
    #5 cond = 3;  {N, Z, C, V} = 4'b0010; //0
    #5 cond = 4;  {N, Z, C, V} = 4'b1000; //1
    #5 cond = 5;  {N, Z, C, V} = 4'b1000; //0
    #5 cond = 6;  {N, Z, C, V} = 4'b0001; //1
    #5 cond = 7;  {N, Z, C, V} = 4'b0001; //0
    #5 cond = 8;  {N, Z, C, V} = 4'b0010; //1
    #5 cond = 9;  {N, Z, C, V} = 4'b0100; //1
    #5 cond = 10; {N, Z, C, V} = 4'b1000; //0
    #5 cond = 10; {N, Z, C, V} = 4'b1001; //1
    #5 cond = 11; {N, Z, C, V} = 4'b1001; //0
    #5 cond = 11; {N, Z, C, V} = 4'b1000; //1
    #5 cond = 12; {N, Z, C, V} = 4'b1001; //1
    #5 cond = 13; {N, Z, C, V} = 4'b0000; //0
    #7 $stop;
  end
endmodule