;Como usar control y data?
;CONTROL Y DATA SON CELDAS DE MEMORIA Y SE LEEN Y ESCRIBEN CON INSTRUCCIONES DE MEMORIA
;LD/L.D/LBU/SD/S.D
; ld/sd $t1, DATA(ro) esto no sirve porque data y control no son variables y no se pueden definir como etiquetas.
;ld/sd $t1, 0x10000(r0) esto tampoco se usa, pasan la cantidad de bytes permitidos

;COMO SE HACE ENTONCES??
; .DATA
; DIR_CONTROL: .WORD 0X1000
; DIR_DATA: .WORD 0X1008

; .CODE
; ld $t2, DIR_CONTROL($0)
; ld/sd $t1,0($t2) ; t2 tiene la direccion de control y se usa como puntero

; ld $t3, DIR_DATA($0)
; ld/sd $t4, 0($t3)

;TAMBIEN PUEDE PONERSE DATA Y CONTROL EN .WORD32 Y SE CARGA CON LWU
; ejemplo imprimir un entero sin signo

.data
DIR_CONTROL: .word 0X1000
DIR_DATA: .word 0X1008
num: .word 5

.code
ld $t2, DIR_CONTROL($0)
ld $t3, DIR_DATA($0)

ld $t1, num($0)    ;carga numero
sd $t1, 0($t3)     ;guarda en numero en data
daddi $t1, $0,1    ; cod 1 para imprimir
sd $t1, 0($t2)
halt

