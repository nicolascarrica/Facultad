;----------------------------------------------------------------------------
;PASAR A MAYUSCULAS UNA CADENA DE CARACTERES
.data
  cadena: .asciiz "Hola"
.code
  mayusCar:
  ;recibe $a0: caracter
  ;devuelve $v0 el caracter en mayuscula
  ;0x61 ascii "a"
  ;0x7b ascci 'z'
  ;0x20 deferencia entre mayuscula y minuscula
  dadd $v0, $a0, $0
  slti $t0, $v0, 0x61 ;compara el valor pasado con la 'a'. $t0 es 1 si $v0<'a'.
  bnez $t0, salir
  slti $t0, $v0, 0x61 ;compara el valor pasado con la 'z'. $t0 es 1 si $v0<'a'
  beqz $t0, salir
  daddi $v0, $v0, -0x20; convierte a mayusculas
  salir:  jr $ra


  ;recibe 
  ;$a0: la direccion de comienzo
  mayus:  daddi $sp, $sp, -16 ; al principio se hace un guardado en la pila de ra y s0
          sd $ra, 0($sp)
          sd $s0, 8($sp)

          dadd $s0, $a0, $0 ; pone en s0 el valor de a0, el valor de comienzo de la cadena
    loop: lbu $a0, 0($s0)   ; se pone en a0 el valor del primer elemento del string
          beq $a0, $0, fin  ; se compara el primer elemento con el valor cero para saber si es el final
          jal mayusCar
          sb $v0, 0($s0)    ;guarda el valor en memoria
          daddi $s0, $s0, 1
          j loop
    fin:  ld $ra, 0($sp)  ; se desapilan los valores
          ld $s0, 8($sp)
          daddi $sp, $sp, 16
          jr $ra

  ;Iniciar SP
  daddi $sp, $0, 0x400
  ;paremetro: dir.de cadena
  daddi $a0, $0, cadena   ; en $a0 queda guardada la direccion de inicio de la cadena
  jal mayus
  halt
  
