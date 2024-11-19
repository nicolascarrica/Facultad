.code
daddi $sp, $0, 0x400
daddi $t0, $0, 5
daddi $t1, $0, 8
daddi $sp, $sp,-16
sd $t0, 0($sp)
sd $t1, 8($sp)
ld $t0, 8($sp)
ld $t1, 0($sp)
daddi $sp, $sp, 16
halt

