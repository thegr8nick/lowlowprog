%include "io64.inc"

section .rodata
    a: dd 1.0
    x: dd 1.0
    b: dd 2.0
    c: dd 2.0

    ;y = (b*c)/(a+x)
    
section .text
global main

main:
mov rbp, rsp
xor eax, eax

FLD dword[b] ;ST0 = b
FLD dword[c] ;ST1 = c
FMULP ;ST0 = b*c
FLD dword[a] 
FLD dword[x] 
FADDP
FDIVP

movss xmm0, dword[c]
mulss xmm0, [b]
movss xmm1, dword[a]
addss xmm1, [x]
divss xmm0, xmm1

ret