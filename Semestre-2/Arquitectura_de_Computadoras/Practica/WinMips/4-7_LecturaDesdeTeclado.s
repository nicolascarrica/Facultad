;LEER un NUMERO: poner en control el valor 8,  luego ingresarlo y buscarlo en data
;LEER un CARACTER: poner en control el valor 9, buscarlo en data con LBU(el caracter ocupa 1 byte), el caracter no se muestra en pantalla

;LEER DOS NUMEROS E IMPRIMIR LA SUMA
; .data
; DIR_CONTROL: .word 0x10000
; DIR_DATA: .word 0X10008

; .code
; ld $t6, DIR_CONTROL($0)
; ld $t7, DIR_DATA($0)

; daddi $t0, $0, 8  ;leer numero

; sd $t0, 0($t6)
; ld $t1, 0($t7)    ; obtengo el numero de data y lo guardo en t1

; sd $t0, 0($t6)
; ld $t2, 0($t7)
; ;sumar
; dadd $t3, $t1, $t2

; sd $t3, 0($t7)
; daddi $t5,$0, 1
; sd $t5, 0($t6)
; halt

;LEER NUMEROS HASTA EL CERO E IMPRIMIR LA SUMA DE TODOS
; .data
; DIR_CONTROL: .word 0x10000
; DIR_DATA: .word 0x10008
; .code
; ld $t6, DIR_CONTROL($0)
; ld $t7, DIR_DATA($0)

; daddi $t0, $0,8
; daddi $t2, $0, 0        ;acumula la suma
; loop: sd $t0, 0($t6)
;       ld $t1, 0($t7)
;       beqz $t1, fin
;       dadd $t2, $t2, $t1
;       j loop
; fin:  sd $t2, 0($t7)
;       daddi $t5,$0,1
;       sd $t5,0($t6)
; halt

;EJEMPLO CON NUMEROS FLOTANTES:
; .data
; DIR_CONTROL: .word 0x10000
; DIR_DATA: .word 0x10008
; cero: .double 0
; .code
; ld $t6, DIR_CONTROL($0)
; ld $t7, DIR_DATA($0)

; daddi $t0, $0, 8
; l.d f0,cero($0)   ;acumulador suma
; l.d f2, cero($0)  ;comparador con numero ingresado

; loop: sd $t0, 0($t6)
;       l.d f1, 0($t7)
;       c.eq.d f2,f1
;       bc1t fin
;       add.d f0,f0, f1
;       j loop
; fin: s.d f0, 0($t7)
;       daddi $t5, $0, 3
;       sd $t5, 0($t6)
; halt  

;LEER 5 NUMEROS Y GUARDAR EN MEMORIA
; .data
; DIR_CONTROL: .word 0x10000
; DIR_DATA: .word 0x10008
; vec: .word 0,0,0,0,0

; .code
; ld $t6, DIR_CONTROL($0)
; ld $t7, DIR_DATA($0)

; daddi $t0, $0, 8
; daddi $t2, $0, 0  ;despl
; daddi $t4, $0, 5  ;canti

; loop: sd $t0, 0($t6)
;       ld $t1, 0($t7)
;       sd $t1, vec($t2)
;       daddi $t2, $t2, 8
;       daddi $t4, $t4,-1
;       bnez $t4, loop
; halt

;LEER UN CARACTER Y VERIFICAR SU ES UNA "A"
; .data
; DIR_CONTROL: .word 0x10000
; DIR_DATA: .word 0x10008
; cod_a: .ascii "A"
; msj_igual: .asciiz "Ingreso una A"
; msj_dist: .asciiz "No ingreso una A"

; .code
; ld $t6, DIR_CONTROL($0)
; ld $t7, DIR_DATA($0)
; daddi $t0, $0, 9   ; 9= ingres0 de caracteres
; sd $t0, 0($t6)
; lbu $t1, 0($t7)

; lbu $t2, cod_a($0)
; bne $t1, $t2, dist

; daddi $t3, $0, msj_igual
; j mostrar
; dist:       daddi $t3, $0, msj_dist
; mostrar:    sd $t3, 0($t7)
;             daddi $t4, $0, 4
;             sd $t4, 0($t6)
; halt

;LEER UNA CADENA Y ALMACENAR EN MEMORIA
.data
DIR_CONTROL: .word 0x10000
DIR_DATA: .word 0x10008
str: .asciiz ""

.code
ld $t6, DIR_CONTROL($0)
ld $t7, DIR_DATA($0)

daddi $t0, $0, 9
daddi $t2, $0, 0
daddi $t3, $0, 5

loop: sd $t0, 0($t6)
      lbu $t1, 0($t7)
      sb $t1, str($t2)  ; guarda el byte en memoria con el desplazamiento de t2
      daddi $t2, $t2, 1 ; incrementa en 1 btye el desplazamiento. El string ocupa 1 byte
      daddi $t3, $t3, -1
      bnez $t3, loop
;Imprimir
daddi $t4, $0, str
sd $t4, 0($t7)
daddi $t0, $0, 4
sd $t0, 0($t6)
halt