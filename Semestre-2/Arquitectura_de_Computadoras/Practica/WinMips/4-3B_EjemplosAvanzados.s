;-------------------------------------------------------------------------------------------------------------------------------------
; Definir dos variables AYB, con valores 4 y 5 respecivamente.
; deifinir una varibale C, sin valor.
; cargar A y B en registros, sumarlos y guardar en C. USar desplazamiento desde A para cargar B


; .data
; A: .word 4 ;00h posicion de memoria por defecto para el primer dato
; B: .word 5 ; 08h B se carga en 08h porque el tamaño del dato .word es de 64 bits (8bytes), A esta ocupando desde el 00h hasta el 07h;
; C: .word 0 ;10h es el valor 16 en hexadecimal

; .code
; daddi r5, r0, 0
; ld r1, A(r5)
; daddi r5, r0, 8 ; uso de r5 para sumar el desplazamiento
; ld r2, A(r5) ; se carga en r2 el balor de b con desplazamiento.

; dadd r3, r1, r2 ; suma de A + B

; daddi r5, r0, 16
; sd r3, A(r5) ; se carga el resultado de la suma con dezplazamiento 16 = 10H
;halt



;-------------------------------------------------------------------------------------------------------------------------------------
;VECTORES SIN LOOP
; Definir un vector de 3 numeros
; calcular la suma de los numeros sin utlizar saltos
; guardar el resultado en una variable calcular
; Asumir los valores del vector 2,4,9

; .data
; V: .word 2,4,9
; C: .word 0

; .code
; daddi r2,r0,0 ;acumulador para guardar la suma
; daddi r5, r0, 0
; ld r1, V(r5);
; dadd r2, r2,r1 ;acumular los valores en r2

; daddi r5,r5,8  ;paso al siguiente numero del vector
; ld r1, V(r5);
; dadd r2, r2,r1

; daddi r5,r5,8  ;paso al siguiente numero del vector
; ld r1, V(r5);
; dadd r2, r2,r1

; sd r2, C(r0)
; halt


;-------------------------------------------------------------------------------------------------------------------------------------
;VECTORES CON LOOP
; Definir un vector de 5 numeros
; calcular la suma de los numeros, utlizar saltos
; guardar el resultado en una variable calcular
; Asumir los valores del vector 4,-10,512,8,16

; .data
; V: .word 2,4,9
; C: .word 0

; .code
; daddi r2,r0,0   ;resultado
; daddi r3, r0, 3  ;cantidad de elementos del vector

; daddi r5,r0,0   ;despl.
; loop: ld r1, V(r5)
;       dadd r2,r2,r1
;       daddi r5,r5,8
;       daddi r3,r3, -1
;       bnez r3, loop
; sd r2, C(r0)

; halt


;-------------------------------------------------------------------------------------------------------------------------------------
; DESPLAZAMIENTO CON PUNTERO
; Definir un vector, calcular la suma de los numeros utilizando saltos y un registro como puntero para acceder a los desplazamientos.

; .data
; V: .word 2,4,9
; C: .word 0

; .code
; daddi r2,r0,0   ;resultado
; daddi r3, r0, 3  ;cantidad de elementos del vector

; daddi r5,r0,V  ;r5 se inicializa con V(el primer valor que contiene el vector, la direccion 00h.)
; loop: ld r1, 0(r5)   ;V+desplazamiento
;       dadd r2,r2,r1
;       daddi r5,r5,8
;       daddi r3,r3, -1
;       bnez r3, loop
; sd r2, C(r0)

; halt

;-------------------------------------------------------------------------------------------------------------------------------------
;Dado un vector calcular el maximo y guardarlo en una variable C

; .data
; V: .word 4,10,512,8,16
; C: .word 0

; .code
; daddi r2,r0,0;  maximo inicial(cero)
; daddi r3,r0, 5; cantidad elementos
; daddi r5,r0, 0; Desplazamiento
; loop: ld r1, V(r5)
;       slt r4, r1, r2  ; si r1 es menor que el maximo r4=1
;       bnez r4, salto
;       daddi r2,r1,0
; salto: daddi r5,r5,8
;       daddi r3,r3,-1
;       bnez r3, loop
; sd r2, C(r0)

;Calculo de cantidad de elementos positivos del vector
; .data
; V: .word 10,9,8,7,-5,-7,4,-2,0,-1
; res: .word 0

; .code
; daddi $t0,$0,0
; daddi $t1,$0,10
; daddi $t2,$0, 0

; loop: ld $t3, V($t2)
;       slti $t4, $t3, 0
;       bnez $t4, sigue
;       daddi $t0, $t0, 1
;       sigue: daddi $t2, $t2, 8
;       daddi $t1, $t1,-1
;       bnez $t1, loop
; sd $t0, res ($0)
; halt

;CONTAR ELEMENTOS DE LA CADENA
; .data
; cadena: .asciiz "Arquitectura"
; longitud: .word 0
; .code
; daddi $t0, $0,0
; daddi $t1, $0, cadena
; loop: lbu $t2, 0($t1)
;       beq $t2, $0, fin
;       daddi $t0, $t0,1
;       daddi $t1, $t1, 1
;       j loop
; fin: sd $t0, longitud($0)
; halt

;CONTAR APARICIONES DE CARACTER
.data
cadena: .asciiz "abcsrdasrtd"
car: .ascii "a"
cant: .word 0

.code
daddi $t0, $0, 0; cantidad
daddi $t1, $0, cadena
lbu $t2, car($0)
loop: lbu $t3, 0($t1)
      beq $t3, $0, fin
      bne $t3, $t2, sigue
      daddi $t0, $t0,1
      sigue: daddi $t1, $t1,1
      j loop
fin: sd $t0, cant($0)
halt