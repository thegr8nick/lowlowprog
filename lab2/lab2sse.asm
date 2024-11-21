%include "io64.inc"

section .data
    real_numb: dd 3.3
    round_up: dd 0.0
    round_down: dd 0.0

section .text
    global main

main:
    movss xmm0, [real_numb]
    roundss xmm0, xmm0, 0x01
    movss [round_up], xmm0

    mov eax, [round_up]
    PRINT_STRING "Round up: "
    PRINT_DEC 4, eax
    NEWLINE

    movss xmm0, [real_numb]
    roundss xmm0, xmm0, 0x02
    movss [round_down], xmm0

    mov eax, [round_down]
    PRINT_STRING "Round down: "
    PRINT_DEC 4, eax

    ; Завершаем программу
end:
    xor eax, eax
    ret