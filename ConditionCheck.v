`timescale 1ns/1ns

module ConditionCheck(cond, statusReg, conditionOut);
input[3:0] cond;
input[3:0] statusReg;
output reg conditionOut;

wire N, Z, C, V;
assign {N, Z, C, V} = statusReg;

always @(*)
    case(cond)
        4'b0000: conditionOut <= Z  ;
        4'b0001: conditionOut <= !Z ;
        4'b0010: conditionOut <= C  ;
        4'b0011: conditionOut <= !C ;
        4'b0100: conditionOut <= N  ;
        4'b0101: conditionOut <= !N ;
        4'b0110: conditionOut <= V  ;   
        4'b0111: conditionOut <= !V ;
        4'b1000: conditionOut <= C && !Z ;
        4'b1001: conditionOut <= !C || Z ;
        4'b1010: conditionOut <= N==V ;
        4'b1011: conditionOut <= N!=V ;
        4'b1100: conditionOut <= !Z && (N==V) ;
        4'b1101: conditionOut <= Z || N!=V ;
        4'b1110: conditionOut <= 1 ;
	default:
		conditionOut <= 1'bz ;
    endcase
endmodule