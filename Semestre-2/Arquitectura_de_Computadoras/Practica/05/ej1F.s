.data
DIR_CONTROL: .word 0x10000
DIR_DATA: .word 0x10008
msj_exp: .asciiz "ingrese exponente"

.code
daddi $sp, $0, 0x400
ld $s0, DIR_CONTROL($0)
ld $s1, DIR_DATA($0)

daddi $t0, $0, msj_exp
daddi $t1, $0, 4
sd $t0, 0($s1)
sd $t1, 0($s0)

daddi $t1, $0, 8
sd $t1, 0($s0)
ld $a0, 0($s1)

daddi $a1, $0, 2
jal potencia
daddi $s2, $v0, 0 

daddi $a1, $0, 3
jal potencia
daddi $s3, $v0, 0

dadd $t0, $s2, $s3
daddi $t1, $0, 1
sd $t0, 0($s1)
sd $t1, 0($s0)

halt

potencia: daddi $sp, $sp, -8
          sd $a0, 0($sp)
          daddi $v0, $0, 1
          lazo: beqz $a0, terminar
          daddi $a0, $a0, -1
          dmul $v0, $v0, $a1
          j lazo
          terminar: ld $a0, 0($sp)
          daddi $sp, $sp, 8
          jr $ra