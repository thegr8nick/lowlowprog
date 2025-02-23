section .data
    a: dd 5.0

section .text
    global main

main:
    mov rbp, rsp; for correct debugging
    fld1
    fld dword [a]
    fyl2x
    fld1
    fpatan
    
    ret
