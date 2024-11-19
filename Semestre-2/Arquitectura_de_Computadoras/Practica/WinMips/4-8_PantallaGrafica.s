; OPERACIONES
;PONER EN DATA EL VALOR DEL COLOR, DATA= COLOR, VA DESDE DATA A DATA +3. EL COLOR RGBA OCUPA 4 BYTES. LUEGO PONER LA CORRDENADA "Y" RN DATA +4. "X"  EN DATA +5
; PONER 5 EN EL REGISTRO DE CONTROL
; EL 7 LIMPIA LA PANTALLA GRAFICA

; PONER EL PIXEL 24, 10 EN VIOLETA
; .data
; coordX: .byte 24;
; coordY: .byte 10
; color: .byte 255,0,255,0 ; rojo+azul. el ultimo cero es la transparencia
; DIR_CONTROL: .word32 0x10000
; DIR_DATA: .word32 0x10008

; .code
; lwu $s6, DIR_CONTROL($0)  ;
; lwu $s7, DIR_DATA($0)

; lbu $s0, coordX($0)
; sb  $s0, 5($s7); pone en data+5 el valor de la coodenada x
; lbu $s1, coordY($0)
; sb $s1, 4($s7)

; lwu $s2, color($0)  ; lwu cargar 4 bytes de color de una vez
; sw $s2, 0($s7)      ; sw guarda los 4 bytes de una
; daddi $t3, $0, 5
; sd $t3, 0($s6)
; halt


;PINTAR DE VERDE TODA UNA LINEA(24,10) A (24,20)
; .data
; coordX: .byte 24
; coordY: .byte 10
; color: .byte 0,255,0,0
; DIR_CONTROL: .word32 0x10000
; DIR_DATA: .word32 0x10008

; .code
; lwu $s6, DIR_CONTROL($0)
; lwu $s7, DIR_DATA($0)
; ;coordenada x y color
; lbu $s0, coordX($0)
; sb $s0, 5($s7)
; lwu $s2, color($0)
; sw $s2, 0($s7)

; daddi $t0, $0, 5
; ;coordenada y
; lbu $s1, coordY($0)
; loop: sb $s1, 4($s7)
;       sb $t0, 0($s6)
;       daddi $s1, $s1, 1
;       slti $s3, $s1, 21
;       bnez $s3, loop
; halt

;CAMBIAR UN PIXEL DE COLORES. desde negro a rojo
.data
coordX: .byte 24
coordY: .byte 10
color: .byte 0,0,0,0
DIR_CONTROL: .word32 0x10000
DIR_DATA: .word32 0x10008

.code
lwu $s6, DIR_CONTROL($0)
lwu $s7, DIR_DATA($0)

;coordenadas xy
lbu $s0, coordX($0)
sb $s0, 5($s7)
lbu $s1, coordY($0)
sb $s1, 4($s7)
daddi $t0, $0, 5
; colores; secarga a registros los colores para ir cambiandolos
lbu $s2, color+0($0)  ;rojo
lbu $s3, color+1($0)  ;verde
lbu $s4, color+2($0)  ;blue
lbu $s5, color+3($0)  ;alpha

sb $s3, 1($s7)
sb $s4, 2($s7)
sb $s5, 3($s7)
loop: sb $s2, 0($s7)
      sd $t0,0($s6)
      daddi $s2, $s2, 32
      slti $s3, $s2, 256
      bnez $s3, loop
      halt
