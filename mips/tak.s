    ########################################
    # @brief 再帰的なテストプログラム
    # @date  作成日    : 2016/07/02
    #
    # C言語における再帰ルーチン
    #     int tak (int x, int y, int z)
    #     {
    #          if (y < x)
    #              return 1 + tak(tak(x - 1, y, z),
    #                             tak(y - 1, z, x),
    #                             tak(z - 1, x, y));
    #          else
    #              return z;
    #     }
    #     int main()
    #     {
    #         tak(18, 12, 6);
    #     }
    # をMipsアセンブリ言語によって記述する
    ########################################


    # Text Segment
    .text
    .globl main
main:
    subu   $sp, $sp, 24  # スタックフレームは40バイト長
    sw     $ra, 16($sp)  # 戻りアドレスを退避

    li     $a0, 18       # レジスタ$a0に18を転送
    li     $a1, 12       # レジスタ$a1に12を転送
    li     $a2, 6        # レジスタ$a2に6を転送

    jal    tak           # tak(18, 12, 6)を呼び出す

    move   $a0, $v0      # tak(18, 12, 6)の戻り値を$aに転送
    li     $v0, 1        # 整数を印字するために$v0に1を代入する
    syscall              # tak(18, 12, 6)の印字

    lw     $ra, 16($sp)  # 戻りアドレスを復元
    addiu  $sp, $sp, 24  # スタックフレームをポップ

    jr     $ra           # プログラムの終了



################################################################################
# @brief 有意な計算を行うものではないが非常に再帰的なプログラム
################################################################################
    .text
    .globl tak
tak:
    subu   $sp, $sp, 40  # スタックフレームは40バイト長
    sw     $ra, 32($sp)  # 戻りアドレスを退避

    sw     $s0, 16($sp)  # callee-savedレジスタ中の引数を退避する
    move   $s0, $a0      # $s0に引数xを転送
    sw     $s1, 20($sp)  # callee-savedレジスタ中の引数を退避する
    move   $s1, $a1      # $s1に引数yを転送
    sw     $s2, 24($sp)  # callee-savedレジスタ中の引数を退避する
    move   $s2, $a2      # $s2に引数zを転送
    sw     $s3, 28($sp)  # 一時変数の退避


    # 分岐判定
    bge    $s1, $s0, L1  # y < xか否か判定

    # y < xのとき、
    # まず、最初の再帰呼び出しを行う
    addiu  $a0, $a0, -1  # $a0 := x - 1
    move   $a1, $s1      # $a1 := y
    move   $a2, $s2      # $a2 := z
    jal    tak           # tak(x - 1, y, z)を呼び出す
    move   $s3, $v0      # $s3 := tak(x - 1, y, z)

    # 次に、2番目の再帰呼び出しを行う
    addiu  $a0, $s1, -1  # $a0 := y - 1
    move   $a1, $s2      # $a1 := z
    move   $a2, $s0      # $a2 := x
    jal    tak           # tak(y - 1, z, x)を呼び出す

    # 3番目の再帰呼び出しを行う
    addiu  $a0, $s2, -1  # $a0 := z - 1
    move   $a1, $s0      # $a1 := x
    move   $a2, $s1      # $a2 := y
    move   $s0, $v0      # $s0 := tak(y - 1, z, x)
    jal    tak           # tak(z - 1, x, y)を呼び出す

    # 以上3つの再帰呼び出しを終えたら、最後の再帰呼び出しを行う
    move   $a0, $s3      # $a0 := tak(x - 1, y, z)
    move   $a1, $s0      # $a1 := tak(y - 1, z, x)
    move   $a2, $v0      # $a2 := tak(z - 1, x, y)
    jal    tak           # tak(tak(x-1,y,z),tak(y-1,z,x),tak(z-1,x,y))を計算
    addiu  $v0, $v0, 1   # $v0 := 1 + tak(tak(x-1,y,z),tak(y-1,z,x),tak(z-1,x,y))
    j      L2            # 関数の後処理を行う



L1:                      # ラベルL1は再帰の基底部分の処理にあたる
    move   $v0, $s2      # 引数zの値を戻りレジスタに移送し、L2を行う



L2:                      # ラベルL2は関数の後処理にあたる
    lw     $ra, 32($sp)  # 戻りアドレスを復元
    lw     $s0, 16($sp)  # 引数1:x の復元
    lw     $s1, 20($sp)  # 引数2:y の復元
    lw     $s2, 24($sp)  # 引数3:z の復元
    lw     $s3, 28($sp)  # 一時変数の復元
    addiu  $sp, $sp, 40  # スタックフレームのポップ
    jr     $ra           # 呼び出し元に戻る




