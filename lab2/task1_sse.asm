%include "io64.inc"

section .rodata:
    x: dd -1.9

section .text
    global main
    
main:
    movss xmm0, dword[x]
    roundss xmm0, xmm0, 2
    cvtss2si eax, xmm0
    PRINT_STRING "Round up: "
    PRINT_DEC 4, eax
    NEWLINE
    
    xor eax, eax
    ret