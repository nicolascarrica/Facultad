.data
base: .word 5              ;Valor de la base
exponente: .word 4         ;Valor del exponente
result: .word 0            ;Donde se guardará el resultado

.code
;Cargar las direcciones de los parámetros en los registros
daddi $a0, $zero, base      ;Dirección de la base
daddi $a1, $zero, exponente ;Dirección del exponente
jal potencia                
sd $v0, result($zero)       
halt                        


potencia:
    ;Cargar los valores a partir de las direcciones (paso por referencia)
    ld $t0, 0($a0)          ;Cargar el valor de la base desde la dirección $a0
    ld $t1, 0($a1)          ;Cargar el valor del exponente desde la dirección $a1
    
    daddi $v0, $zero, 1    
    
    lazo:
        beqz $t1, terminar 
        daddi $t1, $t1, -1 
        dmul $v0, $v0, $t0 
        j lazo             
    
    terminar:
        jr $ra