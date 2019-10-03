/**
 * @brief MIPSのALU制御 : 組み合わせ制御論理の簡単な例
 * @date 作成日     : 2016/01/01
 * @date 最終更新日 : 2016/01/01
 */



module ALUControl (ALUOp, FuncCode, ALUCtl);
   input [1:0] ALUOp;
   input [5:0] FuncCode;
   output [3:0] reg ALUCtl;

   always
     case (FuncCode)
       32: ALUOp <= 2;        // 加算
       34: ALUOp <= 6;        // 減算
       36: ALUOp <= 0;        // AND
       37: ALUOp <= 1;        // OR
       39: ALUOp <= 12;       // NOR
       42: ALUOp <= 7;        // slt
       default: ALUOp <= 15;  // 発生してはいけない
     endcase // case (FuncCode)
endmodule // ALUControl

