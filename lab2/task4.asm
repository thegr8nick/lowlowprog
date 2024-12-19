%include "io64.inc"

section .rodata
    a: dd 1.0
    x: dd 1.0
    y: dd 0.10

section .text
    global main
main:
    mov rbp, rsp; for correct debugging
    ; y >= lg^2(sin(x) + a)
    
    ; Вычисление sin(x)
    fld1
    fld dword[x]         
    fsin                 
    
    ; sin(x) + a
    fld dword[a]        
    fadd                 
    
    ; lg(sin(x) + a) (логарифм с основанием 10)
    fyl2x                ; вычислить log2(sin(x) + a)
    fldl2t  ; загрузить log2(10)
    fdiv                 ; log10(sin(x) + a) = log2(sin(x) + a) / log2(10)
    
    ; lg^2(sin(x) + a)
    fld st0             ; дублировать log10(sin(x) + a)
    fmul st0, st0       ; возвести в квадрат (log10(sin(x) + a))^2
    
    ; Сравнение с y
    fld dword[y]        ; загрузить y
    fcomip st1          ; сравнить y с lg^2(sin(x) + a)
    
    ; Проверка условия
    jl .false           ; если y < lg^2(sin(x) + a), перейти к .true
    
    ; Если y >= lg^2(sin(x) + a)
    PRINT_DEC 4, 1      ; вывести 1
    jmp .end
    
.false:
    PRINT_DEC 4, 0      ; вывести 0
    
.end:
    fstp st0
    fstp st7
    xor rax, rax        ; вернуть 0
    ret
