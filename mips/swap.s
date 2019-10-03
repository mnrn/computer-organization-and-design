    ########################################
    # @brief swap手続きのテストプログラム
    # @date  作成日     : 2015/12/20
    # @date  最終更新日 : 2015/12/20
    #
    # C言語における
    #     void swap(int v[], int k)
    #     {
    #         int temp;
    #         temp   = v[k];
    #         v[k]   = v[k+1];
    #         v[k+1] = temp;
    #     }
    # をMipsアセンブリ言語によって記述する
    ########################################



    # Data Segment
    .data
items:
    .word 1, 2, 3, 4, 5, 4, 3, 2, 1



    # Text Segment
    .text
    .globl main
main:
    la   $a0, items    # レジスタ$a0にitemsのアドレスを転送
    li   $a1, 2        # レジスタ$a1に定数2を転送

    addi $sp, $sp, -4  # スタックに1word分のスペースをプッシュする
    sw   $ra, 0($sp)   # スタックに戻りアドレス$raを退避

    jal  swap          # swap(items, 2)を呼び出す

    lw   $ra, 0($sp)   # スタックに退避した戻りアドレス$raを元に戻す
    addi $sp, $sp, 4   # スタックへ1word分のスペースをポップする

    li   $v0, 1        # 整数を印字するために$v0に1を代入
    lw   $a0, 8($a0)   # システムコールの引数にitems[3]を渡す

    syscall            # items[3]の印字

    jr   $ra           # プログラムの終了

swap:   
    sll   $t1, $a1, 2     # (k * 4)をレジスタ$t1に代入
    add   $t1, $a0, $t1   # v + (k * 4)をレジスタ$t1に代入

    # NOTE: ここまでの操作でレジスタ$t1はv[k]のアドレスを表す

    lw    $t0, 0($t1)     # レジスタ$t0(temp)にv[k]を転送
    lw    $t2, 4($t1)     # レジスタ$t2にv[k+1]を転送

    sw    $t2, 0($t1)     # v[k]   = レジスタ$t2
    sw    $t0, 4($t1)     # v[k+1] = レジスタ$t0(temp)

    jr    $ra             # 呼び出し元に戻る
