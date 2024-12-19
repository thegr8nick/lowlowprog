%include "io64.inc"

section .rodata
    a: dd 1.0
    x: dd 1.0
    b: dd 2.0
    c: dd 2.0

    ;y = asin(bx) + cos(cx)

section .bss
    temp resd 1
    
section .text
    global main

main:
    mov rbp, rsp
    xor eax, eax
    
    fld dword[b]
    fld dword[x]
    fmulp
    fsin
    fld dword [a]
    fmulp
    
    fld dword[b]
    fld dword[x]
    fmulp
    fcos
    
    fadd


    movss xmm0, dword [x]
    mulss xmm0, dword [b]
    movss dword [temp], xmm0

    fld dword [temp]
    fsin
    fstp dword [temp]

    movss xmm0, dword [temp]
    mulss xmm0, dword [a]
    
    movss xmm1, dword [x]
    mulss xmm1, dword [c]
    movss dword [temp], xmm1
    
    fld dword [temp]
    fcos
    fstp dword [temp]
    
    movss xmm1, dword [temp]
    addss xmm0, xmm1

    
    ret