.data
A: .word 5
.code
daddi r1,r0,5
;ld r1, A(r0)
;daddi r1,r0,4
;daddi r1,r0,0
daddi r2,r0, 7
;ld r2, B(r0)
;daddi r2,r0,3
;daddi r2,r0,0
slt r3, r1, r2
;bne r1, r2, no
;daddi r3,r0,0
;loop: ld r3,A(r1)
daddi r1,r0,1
;daddi r3,r0,1
;loop: dadd r3,r3,r2
;dadd r2,r2,r3
and r4, r3, r1
;j fn
;daddi r1,r1,-1
;daddi r1,r1,8
daddi r1, r0, 8 
;no: daddi r3,r0, 0
;bnez r1, loop
;bnez r3, loop
sd r4, A(r1)
;fn: sd r3, C(r0)
;sd r3, res(r0)
;sd r2, RES(r0)