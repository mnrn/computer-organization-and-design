    ########################################
    # @brief 文字列の複製テストプログラム
    # @date  作成日     : 2015/12/17
    # @date  最終更新日 : 2015/12/17
    #
    # C言語における
    #     void strcpy(char x[], char y[])
    #     {
    #         int i;
    #         i = 0;
    #         while ((x[i] = y[i]) != '\0') /* コピーして、終了を判定 */
    #             i += 1;
    #     }
    # をMipsアセンブリ言語によって記述する
    ########################################



    # Data Segment
    .data

    .globl x
x:  .asciiz "hello, world!\n"

    .globl y
y:  .asciiz "now is the time\n"



    # Text Segment
    .text

    .globl main 
main:
    addi $sp, $sp, -4    # スタックに1word分のスペースを取る
    sw   $ra, 0($sp)     # スタックに戻りアドレスを退避

    la   $a0, x          # レジスタ$a0にxのアドレスを転送
    la   $a1, y          # レジスタ$a1にyのアドレスを転送

    jal  strcpy          # strcpy(x, y)を呼び出す

    lw   $ra, 0($sp)     # スタックに退避した$raを元に戻す
    addi $sp, $sp, 4     # スタックに1word分のスペースを戻す

    li   $v0, 4          # 文字列を印字するために$v0に4を代入する
    la   $a0, x          # システムコールの引数にxを渡す
    
    syscall              # 文字列xを印字する

    jr   $ra             # プログラムの終了



strcpy:
    addi $sp, $sp, -4       # スタックに1word分のスペースを取る
    sw   $s0, 0($sp)        # スタックに$s0を退避する

    # iを0に初期化するために、$s0を0に設定する
    add  $s0, $zero, $zero  # i = 0 + 0

L1:
    # NOTE: yはwordの配列ではなく、byteの配列であるためiを4倍する必要がない
    add  $t1, $s0, $a1      # y[i]のアドレスを$t1に代入
    lbu  $t2, 0($t1)        # y[i]中の文字を$t2に転送

    add  $t3, $s0, $a0      # x[i]のアドレスを$t3に代入
    sb   $t2, 0($t3)        # x[i] = y[i]

    beq  $t2, $zero, L2     # y[i] == '\0'ならば、L2に分岐

    addi $s0, $s0, 1        # i = i + 1
    j    L1                 # L1へジャンプ

L2:
    lw   $s0, 0($sp)        # スタックから$s0を復元する
    addi $sp, $sp, 4        # スタックに1word分のスペースを戻す

    jr   $ra                # 呼び出し元に戻る
    
