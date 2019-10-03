    ########################################
    # @brief 符号なし加算のオーバフロートラップテストプログラム
    # @date  作成日     : 2015/12/23
    # @date  最終更新日 : 2015/12/23
    ########################################



    # Data Segment
    .data
msg01:  .asciiz "overflow will occur!"
msg02:  .asciiz "No overflow!"



    # Text Segment
    .text
    .globl main
main:
    li    $t1, 0xffffffff      # レジスタ$t1に0xffffffffを転送
    li    $t2, 1               # レジスタ$t2に0x00000001を転送

    addu  $t0, $t1, $t2        # 和をレジスタ$t0に代入

    nor   $t3, $t1, $zero      # $t3 = NOT $t1

    # (2の補数 - 1 : 2^32 - $t1 - 1)であることに注意
    sltu  $t3, $t3, $t2        # (2^32 - $t1 - 1) < $t2
                               # つまり、 2^32 - 1 < $t1 + $t2のとき、$t3 = 1
    bne   $t3, $zero, Overflow # 上記の条件を満たした場合、オーバーフローへ

    la    $a0, msg02           # システムコールの引数にmsg02を渡す
    li    $v0, 4               # 文字列を印字するために$v0に定数4を転送

    syscall                    # msg02を印字

    j     exit                 # exitへジャンプ 


Overflow:
    la    $a0, msg01           # システムコールの引数にmsg01を渡す
    li    $v0, 4               # 文字列を印字するために$v0に定数4を転送

    syscall

    j     exit                 # exitへジャンプ


exit:
    jr    $ra                  # プログラムの終了
