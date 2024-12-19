section .data
    result dd 0.0
    a dd 1.0
    b dd 0.0

section .text
    global main
    extern exit

main:
    ; x = arctan(2^b) - a

    ; Вычисляем 2^b
    fld dword [b]             ; st(0) = b
    fld1                      ; st(1) = 1.0 (логарифмическое основание)
    fyl2x                     ; st(0) = b * log2(2) = b (так как log2(2) = 1)

    ; Преобразуем в степень: 2^b
    fld1                      ; st(1) = 1.0
    fld st1                   ; st(2) = 1.0, st(1) = 1.0
    fprem                     ; st(0) = дробная часть st(1) (для корректировки диапазона)
    f2xm1                     ; st(0) = 2^(дробная часть) - 1
    fadd                      ; st(0) = 2^(дробная часть)
    fscale                    ; st(0) = 2^b
    fstp st1                  ; Удаляем старые значения, оставляем только результат в st(0)

    ; Вычисляем arctan(2^b)
    fld1                      ; st(1) = 1.0
    fpatan                    ; st(0) = arctan(2^b)

    ; Вычитаем a
    fsub dword [a]            ; st(0) = arctan(2^b) - a

    ; Сохраняем результат в переменную result
    fstp dword [result]       ; Сохраняем результат в памяти

    ; Завершаем программу
    xor rdi, rdi              ; Код завершения = 0
    call exit                 ; Вызов exit
    ret
