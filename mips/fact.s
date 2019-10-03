    ########################################
    # @brief 入れ子状にリンクされた再帰手続きのテストプログラム
    # @date  作成日     : 2015/12/17
    # @date  最終更新日 : 2015/12/17
    #
    # C言語における
    #     int fact(int n)
    #     {
    #         if (n < 1) return (1);
    #         return (n * fact(n - 1));
    #     }
    # をMipsアセンブリ言語によって記述する
    ########################################



    # Data Segment
    .data



    # Text Segment
    .text
    .globl main

main:
    li   $s0, 6           # $s0 := 6

    addi $sp, $sp, -4     # スタックに1word分スペースを取る
    sw   $ra, 0($sp)      # 戻りアドレスを退避する

    add  $a0, $s0, $zero  # 引数nに6を代入する
    jal  fact             # fact(n)を呼び出す

    lw   $ra, 0($sp)      # スタックに退避した$raを元に戻す
    addi $sp, $sp, 4      # スタックから1word分のスペースを落とす

    add  $s7, $v0, $zero  # $レジスタ$s7にfact(n)の戻り値を代入する

    add  $a0, $s7, $zero  # $a0 := $s7
    li   $v0, 1           # 整数を印字するために$v0に1を代入

    syscall               # fact(n)の結果を印字

    jr   $ra              # プログラムの終了



fact:
    addi $sp, $sp, -8     # スタックに2word分スペースを取る
    sw   $ra, 4($sp)      # 戻りアドレスを退避する
    sw   $a0, 0($sp)      # 引数nを退避する

    slti $t0, $a0, 1      # n < 1であるかどうかをチェック
    beq  $t0, $zero, L1   # n >= 1であれば、L1に分岐

    addi $v0, $zero, 1    # 1を返す
    addi $sp, $sp, 8      # スタックから2word分スペースを落とす
    jr   $ra              # 呼び出し元に戻る
L1:
    addi $a0, $a0, -1     # n >= 1でならば、引数を(n - 1)とする
    jal  fact             # (n - 1)を用いてfactを呼び出す

    # 次の命令はfactから戻るための処理である.
    # まず、古い戻りアドレスと古い引数を復元し、スタック・ポインタを戻す

    lw   $a0, 0($sp)      # 引数nを復元する
    lw   $ra, 4($sp)      # 戻りアドレスを復元する
    addi $sp, $sp, 8      # スタックから2word分スペースを落とす

    # 次に、値レジスタの$v0に古い引数$a0と値レジスタの最新の値の積を代入する

    mul  $v0, $a0, $v0    # n * fact (n - 1)を返す
    jr   $ra              # 呼び出し元に戻る
    
