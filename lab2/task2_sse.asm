section .rodata
    a: dd 1.0           ; a = 1.0
    x: dd 1.0           ; x = 1.0
    b: dd 2.0           ; b = 2.0
    c: dd 2.0           ; c = 2.0

section .bss
    temp resd 1

section .text
    global main

main:
    mov rbp, rsp; for correct debugging
    movss xmm0, dword [x]
    mulss xmm0, dword [b]

    ; Сохраняем результат в temp, чтобы передать в x87
    movss dword [temp], xmm0

    ; Работаем с x87: вычисляем asin(bx)
    fld dword [temp]         ; Загружаем значение bx (x * b) в ST(0)
    fsin                     ; Вычисляем asin(bx)
    fstp dword [temp]        ; Сохраняем результат обратно в temp

    movss xmm0, dword [temp] ; Загружаем результат asin(bx) в xmm0
    mulss xmm0, dword [a]    ; xmm0 = a * asin(bx)

    ; Вычисляем cx = c * x и сохраняем в xmm1
    movss xmm1, dword [x]    ; Загружаем x в xmm1
    mulss xmm1, dword [c]    ; xmm1 = c * x

    ; Сохраняем cx в temp для работы с x87
    movss dword [temp], xmm1

    ; Работаем с x87: вычисляем cos(cx)
    fld dword [temp]         ; Загружаем cx в ST(0)
    fcos                     ; Вычисляем cos(cx)
    fstp dword [temp]        ; Сохраняем результат обратно в temp

    ; Загружаем результат cos(cx) в xmm1
    movss xmm1, dword [temp] ; Загружаем результат cos(cx) в xmm1

    ; Складываем asin(bx) и cos(cx)
    addss xmm0, xmm1         ; xmm0 = asin(bx) + cos(cx)

    ; Сохраняем результат в temp
    movss dword [temp], xmm0 ; Сохраняем результат в temp

    ret
