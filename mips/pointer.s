    ########################################
    # @brief 配列とポインタの比較プログラム
    # @date  作成日     : 2015/12/21
    # @date  最終更新日 : 2015/12/21
    #
    # C言語における配列を使用した手続き
    #     void clear1(int array[], int size)
    #     {
    #         int i;
    #         for (i = 0; i < size; i += 1)
    #             array[i] = 0;
    #     }
    # および、ポインタを使用した手続き
    #     void clear2(int *array, int size)
    #     {
    #         int *p;
    #         for (p = &array[0]; p < &array[size]; p = p + 1)
    #             *p = 0;
    #     }
    # をMipsアセンブリ言語によって記述する
    ########################################



    # Data Segment
    .data
array:
    .word 1, 4, 2, 5, 3



    # Text Segment
    .text
    .globl main
main:
    la   $a0, array    # レジスタ$a0にarrayのアドレスを転送
    li   $a1, 5        # レジスタ$a1に定数5(size)を転送

    addi $sp, $sp, -4  # スタックに1word分のスペースをプッシュ
    sw   $ra, 0($sp)   # スタックに戻りアドレス$raを退避

    jal  clear1        # clear1(array, size)を呼び出す

    lw   $ra, 0($sp)   # スタックから戻りアドレス$raを復元
    addi $sp, $sp, 4   # スタックから1word分のスペースをポップ

    lw   $a0, 0($a0)   # システムコールの引数としてarray[0]を渡す
    li   $v0, 1        # 整数を印字するために$v0に1を代入

    syscall            # array[0]の印字

    jr   $ra           # プログラムの終了


    #************************************************************
    # @brief clear1: 配列バージョン
    # @param array   $a0に割り当て
    # @param size    $a1に割り当て
    # @param i       $t0に割り当て
    #************************************************************
clear1:
    move $t0, $zero         # i = 0
loop1:
    sll  $t1, $t0, 2        # $t1 = i * 4
    add  $t2, $a0, $t1      # $t2 = array[i]のアドレス
    sw   $zero, 0($t2)      # array[i] = 0
    addi $t0, $t0, 1        # i = i + 1
    slt  $t3, $t0, $a1      # (i < size) ならば、$t3 = 1
    bne  $t3, $zero, loop1  # (i < size) ならば、loop1へ
    jr   $ra                # 呼び出し元へ戻る



    #************************************************************
    # @brief clear2: ポインタバージョン
    # @param array   $a0に割り当て
    # @param size    $a1に割り当て
    # @param p       $t0に割り当て
    #************************************************************
clear2:
    move $t0, $a0           # p = array[0]のアドレス
    sll  $t1, $a1, 2        # $t1 = size * 4
    add  $t2, $a0, $t1      # $t2 = array[size]のアドレス
loop2:
    sw   $zero, 0($t0)      # メモリ[p] = 0
    addi $t0, $t0, 4        # p = p + 4
    slt  $t3, $t0, $t2      # (p < &array[size]) ならば、$t3 = 1
    bne  $t3, $zero, loop2  # (p < &array[size]) ならば、loop2
    jr   $ra                # 呼び出し元へ戻る
    
