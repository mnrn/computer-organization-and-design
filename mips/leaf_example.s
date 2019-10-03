    ########################################
    # @brief 他の手続きを呼び出さない手続きのテストプログラム
    # @date  作成日     : 2015/12/16
    # @date  最終更新日 : 2015/12/16
    #
    # C言語における
    #     int leaf_example(int g, int h, int i, int j)
    #     {
    #         int f;
    #         f = (g + h) - (i + j);
    #         return f;
    #     }
    # をMipsアセンブリ言語によって記述する
    ########################################



    # Data Segment
    .data



    # Text Segment
    .text
    .globl main

main:
    li $s1, 4             # $s1 := 4
    li $s2, 5             # $s2 := 5
    li $s3, 6             # $s3 := 6
    li $s4, 7             # $s4 := 7

    addi $sp, $sp, -4     # スタックに1word分のスペースを取る
    sw   $ra, 0($sp)      # $raをスタックに退避

    move $a0, $s1         # g = 4
    move $a1, $s2         # h = 5
    move $a2, $s3         # i = 6
    move $a3, $s4         # j = 7

    jal  leaf_example     # leaf_example(g, h, i, j)を呼び出す

    lw   $ra, 0($sp)      # スタックに退避した$raを元に戻す
    addi $sp, $sp, 4      # スタック上に1word分のスペースを戻す

    move $s7, $v0         # leaf_exampleの戻り値をレジスタ$s7へ代入

    move $a0, $s7         # $a0 := $s7
    li   $v0, 1           # 整数を印字するために$v0に1を代入

    syscall               # 整数を印字

    jr $ra                # プログラムの終了



leaf_example:
    addi $sp, $sp, -12    # スタックに3word分のスペースを取る
    sw   $t1, 8($sp)      # レジスタ$t1を後の使用に備えて退避
    sw   $t0, 4($sp)      # レジスタ$t0を後の使用に備えて退避
    sw   $s0, 0($sp)      # レジスタ$s0を後の使用に備えて退避

    add  $t0, $a0, $a1     # g + hがレジスタ$t0に代入される
    add  $t1, $a2, $a3     # i + jがレジスタ$t1に代入される
    sub  $s0, $t0, $t1     # f = (g + h) - (i + j)

    add  $v0, $s0, $zero   # fを返す($v0 = $s0 + 0)

    lw   $s0, 0($sp)       # 呼び出し側のためにレジスタ$s0を復元
    lw   $t0, 4($sp)       # 呼び出し側のためにレジスタ$t0を復元
    lw   $t1, 8($sp)       # 呼び出し側のためにレジスタ$t1を復元
    addi $sp, $sp, 12      # スタックから3word分のスペースを除く

    jr   $ra               # 手続きの終了 
    
