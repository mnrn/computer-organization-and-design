    ########################################
    # @brief 華氏の温度を摂氏に変換するプログラム
    # @date  作成日     : 2015/12/12
    # @date  最終更新日 : 2015/12/12
    #
    # C言語における
    #     float f2c (float fahr)
    #     {
    #         return ((5.0 / 9.0) * (fahr - 32.0));
    #     }
    # をMipsアセンブリ言語によって記述する
    ########################################



    # Data Segment
    .data
const5:  .float 5.0
const9:  .float 9.0
const32: .float 32.0

    # Text Segment
    .text
    .globl main
main:
    li     $v0, 6            # float値を読み込むために$v0に定数6を転送する
    syscall                  # $f0に入力した値が入る
    add.s  $f12, $f12, $f0   # $f12に入力した値を代入 
    
    addi   $sp, $sp, -4      # スタックに1word分のスペースをプッシュ
    sw     $ra, 0($sp)       # 戻りアドレス$raをスタックに退避

    jal    f2c               # f2c(入力した値)を呼び出す

    lw     $ra, 0($sp)       # 戻りアドレス$raをスタックから復元
    addi   $sp, $sp, 4       # スタックに1word分のスペースをポップ

    add.s $f12, $f12, $f0  # f2cの結果を$f12に代入
    li     $v0, 2           # 単精度浮動小数点数を印字するため、システムコールの引数に定数2を転送

    syscall                 # f2cの結果を印字

    jr     $ra              # プログラムの終了



f2c:
    lwc1   $f16, const5       # $f16 = 5.0(5.0はメモリ中)
    lwc1   $f18, const9       # $f18 = 9.0(9.0はメモリ中)

    div.s  $f16, $f16, $f18   # $f16 = 5.0 / 9.0

    lwc1   $f18, const32      # $f18 = 32.0
    sub.s  $f18, $f12, $f18   # $f18 = fahr - 32.0

    mul.s  $f0, $f16, $f18    # $f0 = (5/9) * (fahr - 32.0)
    jr     $ra                # 呼び出し元に戻る
