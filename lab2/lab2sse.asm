%include "io64.inc"

section .data
    real_numb: dd 3.3

section .text
    global main

main:
    movss xmm0, dword [real_numb]
    roundss xmm0, xmm0, 0x01
    cvttss2si eax, xmm0
    PRINT_STRING "Round down: "
    PRINT_DEC 4, eax
    NEWLINE

    movss xmm0, dword [real_numb]
    roundss xmm0, xmm0, 0x02
    cvttss2si eax, xmm0
    PRINT_STRING "Round up: "
    PRINT_DEC 4, eax

end:
    xor eax, eax
    ret