/**
 * @brief MIPSレジスタファイルのVerilogによる動作記述
 * @date 作成日     : 2016/01/03
 * @date 最終更新日 : 2016/01/03
 */



module registerfile(Read1, Read2, WriteReg, WriteData, RegWrite, Data1, Data2, clock);
   input [5:0] Read1, Read2, WriteReg;  // 読み出しおよび、書き込み用のレジスタ番号
   input [31:0] WriteData;              // 書き込むデータ
   input        RegWrite,               // 書き込みの制御
                clock;                  // 書き込みのトリガとなるクロック
   
   output [31:0] Data1, Data2;          // 読み出されたレジスタの値
   
   reg [31:0]    RF[31:0];              // 長さ32ビットの32本のレジスタ

   assign Data1 = RF[Read1];
   assign Data2 = RF[Read2];

   always
     begin
        // RegWriteが「高」のときに、新しい値をレジスタに書き込む
        @(posedge clock)
          if (RegWrite)
            RF[WriteReg] <= WriteData;
     end
endmodule // registerfile

   
