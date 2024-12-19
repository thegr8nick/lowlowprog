%include "io64.inc"

section .bss
    x: resd 1
section .rodata
    a: dd 3.0
    section .rodata
    ;2^ctg(x) = a
    ;x = arctg(log2(a))
    
section .text
global main

main:
mov rbp, rsp;
xor rbx, rbx

fld1
fld dword[a] ;ST0 = x

fyl2x
fld1
fxch
fpatan

fstp dword[x]

ret