%include "io64.inc"

section .data
    input_num dd 0           ; Переменная для ввода числа
    result_up dd 0           ; Результат округления вверх
    result_down dd 0         ; Результат округления вниз

section .text
global main

main:
    ; Ввод числа от пользователя
    PRINT_STRING "Enter a real number:  "
    NEWLINE
    GET_DEC 4, input_num    ; Ввод числа (32-битное вещественное)

    ; Округление вверх (SSE)
    movss xmm0, [input_num] ; Загрузить число в регистр xmm0
    roundss xmm1, xmm0, 2   ; Округлить вверх (режим 2: к +∞)
    movss [result_up], xmm1 ; Сохранить результат округления вверх

    ; Вывод результата округления вверх
    PRINT_STRING "Round up: "
    PRINT_DEC 4, result_up
    NEWLINE

    ; Округление вниз (SSE)
    movss xmm0, [input_num] ; Загрузить число в регистр xmm0
    roundss xmm1, xmm0, 1   ; Округлить вниз (режим 1: к -∞)
    movss [result_down], xmm1 ; Сохранить результат округления вниз

    ; Вывод результата округления вниз
    PRINT_STRING "Round down: "
    PRINT_DEC 4, result_down
    NEWLINE

    ; Завершение программы
    xor eax, eax            ; Возврат 0
    ret
