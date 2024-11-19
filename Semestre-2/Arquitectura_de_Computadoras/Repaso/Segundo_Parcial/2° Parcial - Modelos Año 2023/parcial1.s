.data
cad_msg: .asciiz "Cadena con Reemplazos /n"
digi_msg: .asciiz "Digitos convertidos a digitos + 1 /n"
cadena: .asciiz "3a?7eN95en1234a"
control: .word 0x10000
datos: .word 0x10008
digitos: .asciiz ""

.code
daddi $sp, $0, 0x400
daddi $a0, $0, cadena
daddi $a1, $0, digitos
jal procesar_cadena
daddi $a0, $0,cad_msg
daddi $a1, $0, cadena
jal imprimir
daddi $a0, $0,digi_msg
daddi $a1, $0, digitos
jal imprimir
halt

es_digito:
daddi $v0, $0, 0
slti $t3, $a2, 48
bnez $t3, no_es
slti $t3, $a2, 57
beqz $t3, no_es
daddi $v0, $0, 1
no_es: jr $ra

obtener_digito:
daddi $v0, $a2, 1
jr $ra

imprimir:
ld $t0, control($0)
ld $t1, datos($0)
daddi $t2, $0,4
sd $a0, 0($t1)
sd $t2, 0($t0)
sd $a1, 0($t1)
sd $t2, 0($t0)
jr $ra 

procesar_cadena:
daddi $sp, $sp, -24
sd $s0, 16($sp)
sd $s1, 8($sp)
sd $ra, 0($sp)
dadd $s0, $0, $a0
dadd $s1, $0, $a1

loop: lb $a2, 0($s0)
beqz $a2, fin
jal es_digito
beqz $v0, seguir
jal obtener_digito
sb $v0, 0($s0)
sb $v0, 0($s1)
daddi $s1, $s1, 1
seguir: daddi $s0, $s0, 1
j loop
fin: ld $s0, 16($sp)
ld $s1, 8($sp)
ld $ra, 0($sp)
daddi $sp, $sp, 24
jr $ra

