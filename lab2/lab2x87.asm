%include "io64.inc"

section .data
    real_numb: dd 3.3
    round_up: dd 0.0
    round_down: dd 0.0
    ctrl_word: dw 0
    
section .text
    global main

main:
    fstcw [ctrl_word]
    mov ax, [ctrl_word]
    or ax, 0x0800
    mov [ctrl_word], ax
    fldcw [ctrl_word]

    fld dword [real_numb]
    fistp dword [round_up]

    mov eax, [round_up]
    PRINT_STRING "Round up: "
    PRINT_DEC 4, eax
    NEWLINE

    mov ax, [ctrl_word]
    and ax, 0xF3FF
    or ax, 0x0400
    mov [ctrl_word], ax
    fldcw [ctrl_word]

    fld dword [real_numb]
    fistp dword [round_down]

    mov eax, [round_down]
    PRINT_STRING "Round down: "
    PRINT_DEC 4, eax
end:
    xor eax, eax
    ret
