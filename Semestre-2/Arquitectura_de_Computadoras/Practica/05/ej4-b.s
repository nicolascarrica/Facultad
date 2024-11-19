.data
base: .word 5
exponente: .word 4   
result: .word 0         

.code
daddi $sp, $0, 0x400
ld $t0, base($zero)
ld $t1, exponente($zero)

daddi $sp, $sp, -16       
sd $t0, 8($sp)
sd $t1, 0($sp)

jal potencia 

sd $v0, result($zero)

daddi $sp, $sp, 16

halt


potencia:
    ;Recuperar los parámetros de la pila
    ld $a0, 8($sp)         ;Recuperar el valor de la base desde la pila
    ld $a1, 0($sp)         ;Recuperar el valor del exponente desde la pila

    daddi $v0, $zero, 1

    lazo:
        beqz $a1, terminar 
        daddi $a1, $a1, -1 
        dmul $v0, $v0, $a0 
        j lazo

    terminar:
        jr $ra