/**
 * @brief case構文を使用して記述した、
 *        32ビット入力の4対1マルチプレクサの
 *        Verilogによる定義
 * @date  作成日     : 2015/12/31
 * @date  最終更新日 : 2015/12/31
 */



module Mult4to1 (In1, In2, In3, In4, Sel, Out);
   input [31:0] In1, In2, In3, In4;  // 32ビット入力が4つ
   input [1:0]  Sel;                 // セレクタ信号
   output reg [31:0] Out;            // 32ビット出力

   always @(In1, In2, In3, In4, Sel)
     case (Sel)                      // 4対1マルチプレクサ
       0: Out <= In1;
       1: Out <= In2;
       2: Out <= In3;
       default: Out <= In4;
     endcase // case (Sel)
endmodule // Mult4to1

