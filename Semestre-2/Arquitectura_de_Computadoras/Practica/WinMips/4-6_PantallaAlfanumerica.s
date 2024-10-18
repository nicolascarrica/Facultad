;Numeros positivos
; .data
; DIR_CONTROL: .word 0x10000
; DIR_DATA: .word 0x10008
; A: .word 25
; B: .word 50

; .code
; ld $t2, DIR_CONTROL($0)
; ld $t3, DIR_DATA($0)

; ld $t0, A($0)
; ld $t1, B($0)

; dadd $t5, $t0, $t1
; sd $t5, 0($t3); pongo el resultado en data

; daddi $t6,$t6,1 ; pongo 1 en Control
; sd $t6, 0($t2)
; halt

;Numeros Negativos, requiere interpretar la secuencia de bits en ca2. hay que cambiar el 1 que se manda a control por un 2. si no lo hago se imprime cualquier cosa.
; en ca2 se pone un 1 en el bit mas significativo entonces si el sistema lo interpreta como bss dara un valor grande
; .data
; DIR_CONTROL: .word 0x10000
; DIR_DATA: .word 0x10008
; A: .word -25
; B: .word -50

; .code
; ld $t2, DIR_CONTROL($0)
; ld $t3, DIR_DATA($0)

; ld $t0, A($0)
; ld $t1, B($0)

; dadd $t5, $t0, $t1
; sd $t5, 0($t3); pongo el resultado en data

; daddi $t6,$t6,2 ; pongo 2 en Control
; sd $t6, 0($t2)
; halt

;Numeros en punto flotante, tengo que poner el valor 3 en data.  Hay que cargar los datos con l.d y guardad con s.d. 
;Usar los registros f, porq son registros para punto flotante
; .data
; DIR_CONTROL: .word 0x10000
; DIR_DATA: .word 0x10008
; A: .double 1.5
; B: .double 0.5

; .code
; ld $t2, DIR_CONTROL($0)
; ld $t3, DIR_DATA($0)

; l.d f0, A($0)
; l.d f1, B($0)

; add.d f2, f0, f1
; s.d f2, 0($t3); pongo el resultado en data

; daddi $t6,$0,3 ; pongo 3 en Control
; sd $t6, 0($t2)
; halt

;MOSTRAR EN PANTALLA UN VECTOR DE NUMEROS
; .data
; DIR_CONTROL: .word 0x10000
; DIR_DATA: .word 0x10008
; vec: .word -25,10,-12,15,50,2

; .code
; ld $t0, DIR_CONTROL($0)
; ld $t1, DIR_DATA($0)

; ;como hay numeros negativos pongo 2 en un registro para luego mandarlo a control
; daddi $t6, $0, 2

; daddi $t2,$0, 6   ;cantidad de elementos del vector
; daddi $t3, $0, 0  ;desplazamiento

; loop: ld $t4,vec($t3)
;       sd $t4, 0($t1)  ;guardo valor en data
;       sd $t6, 0($t0)  ;guardo valor 2 en control
;       daddi $t3, $t3, 8
;       daddi $t2, $t2, -1
;       bnez $t2, loop
; halt

;MOSTRAR STRING EN PANTALLA
; .data
; DIR_CONTROL: .word 0x10000
; DIR_DATA: .word 0x10008
; str: .asciiz "Hola"

; .code
; ld $t2, DIR_CONTROL($0)
; ld $t3, DIR_DATA($0)

; daddi $t0, $0, str   ;se pone en t0 la direccion de comienzo del str
; sd $t0, 0($t3)        ; se guarda en data

; daddi $t1, $0, 4    ;codigo 4 para imprimir un caracter
; sd $t1, 0($t2)
; halt

;MOSTRAR EN PANTALLA 10 VECES LO MISMO
; .data
; DIR_CONTROL: .word 0x10000
; DIR_DATA: .word 0x10008
; str: .asciiz "Hola\n"

; .code
; ld $t2, DIR_CONTROL($0)
; ld $t3, DIR_DATA($0)

; daddi $t0, $0, str
; sd $t0, 0($t3)

; daddi $t1, $0,4
; daddi $t4, $0,10
; loop: sd $t1, 0($t2)
;       daddi $t4, $t4, -1
;       bnez $t4, loop
;       halt

;MOSTRAR EN PANTALLA 10 VECES LO MISMO con conteo de veces
.data
DIR_CONTROL: .word 0x10000
DIR_DATA: .word 0x10008
str: .asciiz "Hola "
nl: .asciiz "\n"

.code
ld $t2, DIR_CONTROL($0)
ld $t3, DIR_DATA($0)

daddi $t0, $0, str
daddi $t6, $0, nl

;Codigos para imprimir
daddi $t1, $0, 4
daddi $t5, $0, 1
;contador
daddi $t4, $0,10

loop: sd $t0, 0($t3)
      sd $t1, 0($t2)
      sd $t4, 0($t3)
      sd $t5, 0($t2)
      sd $t6, 0($t3)
      sd $t1, 0($t2)
      daddi $t4, $t4,-1
      bnez $t4, loop
      halt