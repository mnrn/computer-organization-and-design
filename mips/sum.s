    ########################################
    # @brief 繰り返しを用いた再帰手続きのテストプログラム
    # @date  作成日     : 2015/12/17
    # @date  最終更新日 : 2015/12/17
    #
    # C言語における
    #     int sum(int n, int acc)
    #     {
    #         if (n > 0) return sum(n - 1, acc + n);
    #         else       return acc;
    #     }
    # をMipsアセンブリ言語によって記述する
    ########################################



    # Data Segment
    .data



    # Text Segment
    .text
    .globl main

main:
    li   $s0, 10           # $s0 := 10
    addi $sp, $sp, -4      # スタックに1word分のスペースを取る
    sw   $ra, 0($sp)       # 戻りアドレスを退避する

    add  $a0, $s0, $zero   # 引数nに10を代入する
    add  $a1, $zero, $zero # 引数accに0を代入する
    jal  sum               # sum(n, acc)を呼び出す

    lw   $ra, 0($sp)       # スタックに退避した$raを元に戻す
    addi $sp, $sp, 4       # スタックから1word分のスペースを落とす

    add  $s7, $v0, $zero   # レジスタ$s7にsum(n, acc)の戻り値を代入する

    add  $a0, $s7, $zero   # $a0 := $s7
    li   $v0, 1            # 整数を印字するために$v0に1を代入

    syscall                # sum(n, acc)の結果を印字

    jr   $ra               # プログラムの終了

    

sum:
    slti $t0, $a0, 1           # n <= 0かどうかチェック
    bne  $t0, $zero, sum_exit  # n <= 0ならば、sum_exitへ分岐
    add  $a1, $a0, $a1         # nをaccに累計
    addi $a0, $a0, -1          # nを1繰り下げ
    j sum                      # sumにジャンプ

sum_exit:
    add  $v0, $a1, $zero       # 戻り値accを設定
    jr   $ra                   # 呼び出し元に戻る
    
