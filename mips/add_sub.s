    ########################################
    # @brief 加算減算プログラム
    # @date  作成日     : 2015/12/12
    # @date  最終更新日 : 2015/12/12
    #
    # C言語における
    #     f = (g + h) - (i + j)
    # をMipsアセンブリ言語によって記述する
    ########################################

    

    # Data Segment
    .data


    
    # Text Segment
    .text1

    .globl main

main:
    li $s1, 4          # レジスタ$s1に定数4を転送
    li $s2, 3          # レジスタ$s2に定数3を転送
    li $s3, 2          # レジスタ$s3に定数2を転送
    li $s4, 1          # レジスタ$s4に定数1を転送

    add $t0, $s1, $s2  # 一時レジスタ$t0にg + hを代入
    add $t1, $s3, $s4  # 一時レジスタ$t1にi + jを代入
    sub $s0, $t0, $t1  # f = (g + h) - (i + j)
    
    addi $a0, $s0, 0   # $a0 := $s0
    li   $v0, 1        # 整数を印字するために$v0に1を代入
    syscall            # $a0を印字

    jr   $ra           # プログラムの終了
    
