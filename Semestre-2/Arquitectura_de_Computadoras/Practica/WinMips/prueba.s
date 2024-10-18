;Poner el valor 4 em r2
;el valor 4 en r4
;sumar ambos

; .data

; .code
; daddi r2,r0,4

; daddi r4,r0,5

; dadd r3, r2,r4

; halt

; Definir dos variables a y b, con valores 4 y 5
; una variable c sin valor
; cargar los valores de a y b en registros y sumar. guardar el resultado en cargar

; .data
; A: .word 4
; B: .word 5
; C: .word 0

; .code
; ld r1, A(r0)
; ld r2, B(r0)

; dadd r3, r1, r2

; sd r3, C(r0)

; halt


; Definir dos variables a y b, con valores 4 y 5
; una variable c y d sin valor
;Calcular C = A+2*B y D=C/A+1

; .data
; A: .word 4
; B: .word 5
; C: .word 0
; D: .word 0

; .code
; ld r1, A(r0)
; ld r2, B(r0)

; daddi r3, r0, 2
; dmul r4,r3,r2
; dadd r5, r1,r4
; sd r5, C(r0)

; ddiv r6, r5, r1
; daddi r6, r6, 1
; sd r6, D(r0)

; halt

; dadas dos variables AyB, calcular el maximo y guardar en valor en c
; Asumir que A =4, B = 10 para probar el ejercicio

.data
A: .word 4
B: .word 10
C: .word 0
.code
      ld r1, A(r0)
      ld r2, B(r0)

      slt r3, r1, r2; r3=1 sii r1<r2

      bnez r3, mayorB
      sd r1, C(r0); r1 es mayor
      j fin

mayorB: sd r2, C(r0); r2 es mayor
fin: halt