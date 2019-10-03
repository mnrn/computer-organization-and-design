/**
 * @brief MIPSのALUをVerilogによって動作定義.
 * @date 2015/12/31
 */



module MIPSALU (ALUctl, A, B, ALUOut, Zero);
   input [3:0] ALUctl;
   input [31:0] A, B;
   output reg [31:0] ALUOut;
   output            Zero;

   assign Zero = (ALUOut == 0);  // ALUOutが0であるならば、Zeroは真

   always @(ALUctl, A, B)        // これらが変わった時に再評価
     case (ALUctl)
       0:  ALUOut <= A & B;
       1:  ALUOut <= A | B;
       2:  ALUOut <= A + B;
       6:  ALUOut <= A - B;
       7:  ALUOut <= A < B ? 1 : 0;
       12: ALUOut <= ~(A | B);   // 結果はNOR
       default: ALUOut <= 0;     // デフォルトは0. 発生してはならない
     endcase // case (ALUctl)
endmodule // MIPSALU
