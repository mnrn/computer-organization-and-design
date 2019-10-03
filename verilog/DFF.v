/**
 * @brief 立ち上がりエッジ方式のDフリップフロップのVerilogによる記述
 * @date 作成日     : 2016/01/03
 * @date 最終更新日 : 2016/01/03
 */



module DFF (clock, D, Q, Qbar);
   input clock, D;
   output reg Q;     // alwaysブロック内で代入されているため、Qはレジスタ
   output     Qbar;

   assign Qbar = ~Q;        // Qbarは常にQを反転したもの
   always @(posedge clock)  // クロックの立ち上がりで動作を実行
     Q = D;
endmodule // DFF
