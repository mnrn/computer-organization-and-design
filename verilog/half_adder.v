/**
 * @brief 継続的代入文を使って半加算器を定義する
 * @date  作成日     : 2015/12/31
 * @date  最終更新日 : 2015/12/31
 */



module half_adder (A, B, Sum, Carry);
   input A, B;            // 2つの1ビット入力
   output Sum, Carray;    // 2つの1ビット出力
   assign Sum   = A ^ B;  // A xor B をSumに代入
   assign Carry = A & B;  // A and B をCarryに代入
endmodule // half_adder
