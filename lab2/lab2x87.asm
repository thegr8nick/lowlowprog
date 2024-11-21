%include "io64.inc"

section .data
    float_num1: dd 3.3
    result_up1: dd 0.0
    result_down1: dd 0.0

section .text
    global main

main:
    ; Округление вверх с использованием SSE
    movss xmm0, [float_num1]   ; Загружаем число в xmm0
    roundss xmm0, xmm0, 0x01    ; Округление вверх (к +∞)
    movss [result_up1], xmm0    ; Сохраняем результат округления вверх

    mov eax, [result_up1]       ; Загружаем результат в eax
    PRINT_STRING "Round up: "
    PRINT_DEC 4, eax            ; Печатаем результат округления вверх
    NEWLINE

    ; Округление вниз с использованием SSE
    movss xmm0, [float_num1]    ; Загружаем число в xmm0
    roundss xmm0, xmm0, 0x02    ; Округление вниз (к -∞)
    movss [result_down1], xmm0  ; Сохраняем результат округления вниз

    mov eax, [result_down1]     ; Загружаем результат в eax
    PRINT_STRING "Round down: "
    PRINT_DEC 4, eax            ; Печатаем результат округления вниз

    ; Завершаем программу
end:
    xor eax, eax
    ret
