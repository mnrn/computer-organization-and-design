    ########################################
    # @brief 符号付き加算のオーバフロートラップテストプログラム
    # @date  作成日     : 2015/12/23
    # @date  最終更新日 : 2015/12/23
    ########################################



    # Data Segment
    .data
msg01: .asciiz "overflow will occur!"
msg02: .asciiz "No overflow!" 

    

    # Text Segment
    .text
    .globl main
main:
    li   $t1, 0x7fffffff          # レジスタ$t0に0x7fffffffを転送
    li   $t2, 1                   # レジスタ$t1に0x00000001を転送

    addu $t0, $t1, $t2            # 和をレジスタ$t0に代入.トラップしない

    # 符号が異なるかどうか判定
    xor  $t3, $t1, $t2            # $t1と$t2の排他的論理和を取る
    slt  $t3, $t3, $zero          # 符号が異なるとき、$t3 = 1 (∵ 2の補数)
    bne  $t3, $zero, No_overflow  # $t1と$t2の符号が一致しないとき、
                                  # オーバフローは発生しない

    # 以下、$t1と$t2の符号が等しい場合の処理を行う
    xor  $t3, $t0, $t1            # 和$t0と$t1の排他的論理和を取る
    slt  $t3, $t3, $zero          # 符号が異なるとき、$t3 = 1
    bne  $t3, $zero, Overflow     # 和$t0と$t1の符号が一致しないとき、
                                  # オーバーフローは発生する

No_overflow:
    la   $a0, msg02               # システムコールの引数にmsg02を渡す
    li   $v0, 4                   # 文字列を印字するために$v0に定数4を転送

    syscall                       # msg02を印字

    j    exit                     # exitへ


Overflow:
    la   $a0, msg01               # システムコールの引数にmsg01を渡す
    li   $v0, 4                   # 文字列を印字するために$v0に定数4を転送

    syscall                       # msg01を印字

    j    exit                     # exitへ


exit:
    jr   $ra                      # プログラムの終了
    
