%include "io64.inc"

section .rodata:
    x: dd 1.9
section .bss
    result: resd 1

section .text
global main

set_round_toward_zero:
    sub rsp, 8 
    fstcw [rsp] 
    mov al, [rsp+1] 
    and al, 0xF3
    or al, 12  ; Устанавливаем округление вниз (toward zero)
    mov [rsp+1], al
    fldcw [rsp] 
    add rsp, 8 
    ret

main:
    fld dword[x]          ; Загружаем число в стек FPU
    fist dword[result]
    mov eax, [result]
    PRINT_STRING "Round up: "
    PRINT_DEC 4, eax
    NEWLINE
    call set_round_toward_zero ; Устанавливаем режим округления
    fist dword[result]    ; Преобразуем в целое число
    mov eax, [result]     ; Загружаем результат в eax
    PRINT_STRING "Round down: "
    PRINT_DEC 4, eax      ; Печатаем результат
    xor eax, eax          ; Возвращаем 0
    ret