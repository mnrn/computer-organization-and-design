    ########################################
    # @brief ループのテストプログラム
    # @date  作成日     : 2015/12/16
    # @date  最終更新日 : 2015/12/16
    #
    # C言語におけるループ
    #     while (save[i] == k)
    #         i += 1;
    # をMipsアセンブリ言語によって記述する
    ########################################



    # Data Segment
    .data
save:
    .word 0, 1, 2, 3, 4, 4, 4, 4, 4, 9, 10, 11


    # Text Segment
    .text
    .globl main

main:
    la   $s6, save       # レジスタ$s6にsaveのアドレスを転送
    li   $s3, 5          # レジスタ$s3に定数5を代入
    li   $s5, 4          # レジスタ$s5に定数4を代入

Loop:
    sll  $t1, $s3, 2     # (4 * i)を一時レジスタ$t1に代入
    add  $t1, $t1, $s6   # save[i]のアドレスを一時レジスタ$t1に代入
    lw   $t0, 0($t1)     # save[i]を一時レジスタ$t0に代入

    bne  $t0, $s5, Exit  # save[i] != kならば、Exitへ
    addi $s3, $s3, 1     # i = i + 1
    j    Loop            # Loopへジャンプする

Exit:
    move $a0, $s3        # システムコールの引数に$s3を渡す
    li   $v0, 1          # 整数を印字するために$v0に1を代入
    syscall              # $s3を印字

    jr   $ra             # プログラムの終了
    
