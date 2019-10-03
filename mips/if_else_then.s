    ########################################
    # @brief 条件分岐のテストプログラム
    # @date  作成日     : 2015/12/15
    # @date  最終更新日 : 2015/12/15
    #
    # C言語における
    #     if (i == j) f = g + h;
    #     else f = g - h;
    # をMipsアセンブリ言語によって記述する
    ########################################



    # Data Segment
    .data



    # Text Segment
    .text
    .globl main

main:
    li $s3, 100         # レジスタ$s3に定数100を転送
    li $s4, 100         # レジスタ$s4に定数100を転送
    li $s1, 5           # レジスタ$s1に定数5を転送
    li $s2, 6           # レジスタ$s2に定数6を転送

    bne $s3, $s4, Else  # i != jならば、Elseへ分岐
    add $s0, $s1, $s2   # f = g + h (i != jならばスキップ)
    j Exit              # Exitへジャンプ

Else:
    sub $s0, $s1, $s2   # f = g - h (i = jならばスキップ)

Exit:
    move $a0, $s0       # $a0 := $s0
    li $v0, 1           # 整数を印字するために$v0に1を代入
    syscall             # $a0を印字

    jr $ra              # プログラムの終了
