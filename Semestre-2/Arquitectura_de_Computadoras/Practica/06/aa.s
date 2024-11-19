

; .data
; cadena: .asciiz "nicolas"
; .code
; daddi $s0,$0, cadena
; lb $t0, 0($s0)         ;# Cargar el primer carácter ('n') en $t0
;     daddi $s0, $s0, 1   ;   # Avanzar el puntero de la cadena en 1 byte
;     lb $t1, 0($s0)       ;  # Cargar el segundo carácter ('i') en $t1
;     daddi $s0, $s0, 1     ; # Avanzar el puntero de la cadena en 1 byte
;     lb $t2, 0($s0)         ;# Cargar el tercer carácter ('c') en $t2
;     daddi $s0, $s0, 1      ;# Avanzar el puntero de la cadena en 1 byte
;     lb $t3, 0($s0)         ;# Cargar el cuarto carácter ('o') en $t3
;     daddi $s0, $s0, 1      ;# Avanzar el puntero de la cadena en 1 byte
;     lb $t4, 0($s0) 

; halt
; .data
; cant: .word 2
; datos: .word 1,2
; res: .word 0
; .code
; dadd r1,r1,r0
; ld r5, cant(r0)
; loop: ld r3, datos (r1)
; daddi r5,r5, -1
; dsllv r3,r3,r3
; sd r3, res(r1)
; daddi r1,r1,8
; bnez r5, loop
; halt
 
;  .data
;  dato: .word 10
;  .code
;  ld r4, dato(r0)
;  dadd r1,r14,r6
;  daddi r2,r2 ,1
;  sd r5, dato(r12)
;  halt

; .data
; A: .word 4
; B: .word 5
; C: .word 0
; .code
; daddi $t0, $0,1
; ld $t1, A($0)
; ld $t2, B($0)
; loop:  dmul $t0, $t0, $t1 
; daddi $t2, $t2,-1
; bnez $t2, loop
; sd $t0, C($0)
; halt

; .code
; daddi r1, r0,1
; loop: nop
; daddi r1,r1,-1
; bnez r1, loop
; halt

; .data
; tabla: .word 10,18,22,45,63
; .code
; daddi $t1,$t1,5
; daddi $t2, $t2, 0
; daddi $t3, $t3, 0

; loop: sd $t2, tabla($t3)
; daddi $t1,$t1,-1
; daddi $t2, $t2, 3
; daddi $t3, $t3, 8
; bnez $t1, loop
; halt

; .data
; cant: .word 4
; .code
; ld $t0, cant($0)
; daddi $t2, $0, 0x20
; sigo: daddi $t0,$t0, -1
; bnez $t0, sigo
; dsub $t2, $t2, $t0
; halt

; .code
; daddi $t2, $0,15
; dadd $t9,$0,$0
; lazo: daddi $t2, $t2,-3
; slti $t8, $t2,12
; beqz $t8, lazo
; dadd $t9,$t9, $t2
; halt

; .data
; valor: .word 5
; .code
; ld $t1, valor($0)
; dadd $t2, $t3, $t4
; dmul $t5, $t6, $t7
; sd $t8, valor($0)
; halt

; .data
; A: .byte 4
; B: .byte 5
; .code
; lb r1, A(r0)
; lb r2, B(r0)
; loop: daddi r2,r2,-1
; bnez r2, loop
; dsll r1,r1,1
; halt


; .data
; tabla1: .word 15,11,24
; tabla2: .word 0,0,0
; .code
; daddi r1,r0,0
; daddi r2, r0, 3
; loop: ld r3, tabla1(r1)
; daddi r3,r3,1
; sd r3, tabla2(r1)
; daddi r1,r1,8
; daddi r2,r2,-1
; bnez r2, loop
; halt

; .data
; CONTROL: .word32 0x10000
; DATA: .word32 0x10008
; VALOR: .byte 255,0,0,0,5,10
; .code
; lwu $s0, DATA($0)
; lwu $s1, CONTROL($0)
; ld $t1, VALOR($0)
; sd $t1, 0($s0)
; daddi $t0,$0,5
; sd $t0, 0($s1)
; halt

; .data
; tabla: .word 20, 1, 14, 7, 12, 11
; num: .word 7
; long: .word 6
; res: .word 0
; .code
; ld r1, long(r0)
; ld r2, num(r0)
; dadd r3, r0, r0
; dadd r10, r0, r0
; loop: ld r4, tabla(r3)
; beq r4, r2, listo
; daddi r1, r1, -1
; daddi r3, r3, 8
; bnez r1, loop
; j fn
; listo: daddi r10, r0, 1
; fn: sd r10, res(r0)
; halt


; . data
; Control: .word 0x10000
; Data: .word 0x10008
; Pares: .word 4,7,8,3,18,3,12,5,82,4,20,12
; Rojo: .word 255,0,0,0
; Cantpares: .word 6
; .code
; Daddi $sp, $0, 0x400
; LD $v1, Pares($0)
; LD $v2, Cantpares($0)
; LD $t3, Rojo($0)
; SD $t3, 0(data)
; Jal Graficar 
; Halt 

; Promedio: 
; daddi $t2, $0, 2
; dadd $v0, $a0, $a1
; ddiv $v0, $v0, $t2
; Jr $ra

; Graficar: daddi $sp, $sp, -8
; SD $ra, $sp
; Daddi $s0, $s0, 0
; Loop: LD $a0, $v1($s0)
; Daddi $s0, $s0, 8
; LD $a1, $v1($s0)
; Daddi $s0, $s0, 8
; Daddi $v2, $v2, -1
; Jal Promedio
; SD $v0, 4(data)
; SD $v0, 5(data)
; Daddi $t1, $0, 5
; SD $t1, 0(control)
; Bnez $v2, loop
; LD $ra, $sp
; Daddi $sp, $sp, 8
; Jr $ra

; .data
; Vector1: .word 3,6
; Vector2: .word 0
; .code
; daddi $s0, $0, 0
; daddi $s2, $0, 2
; loop: LD $s1, Vector1($s0)
; SD $s1, Vector2($s0)
; daddi $s0, $s0, 8
; daddi $s2, $s2, -1
; bnez $s2, loop
; halt

; .data
; num: .word 3
; .code
; ld $t1, num($0)
; daddi $t0, $0, 0
; daddi $t2, $0,2
; loop: dadd $t0, $t0, $t1
; daddi $t2,$t2,-1
; bnez $t2, loop
; halt

.data
vec1: .word 1,2,3
vec2: .word 0,0,0
.code
daddi $t1, $0,3
daddi $t0, $0,0
loop: ld $t2, vec1($t0)
daddi $t1, $t1, -1
sd $t2, vec2($t0)
daddi $t0,$0,0
bnez $t1,loop
halt
