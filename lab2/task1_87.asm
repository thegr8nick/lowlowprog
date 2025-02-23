%include "io64.inc"

section .data
    value dd 3.7
    result dd 0
    control_word_up dw 0x0800 | 0x003F

section .bss
    temp resd 1

section .text
    global main
    extern printf

main:
    finit
    fldcw [control_word_up]
    fld dword [value]
    fist dword [temp]
    mov eax, [temp]
    PRINT_DEC 4, eax

    ret

