%include "io64.inc"

section .data
    x_val: dd 0.3
    one: dd 1.0
    minus_one: dd -1.0
    zero: dd 0.0
    max_iter: dd 10
    ln2: dd 0.69314718
    neg_one: dd -1.0

section .text
    global main

main:
    mov rbp, rsp; for correct debugging
task2:
    movss xmm0, dword [x_val]
    comiss xmm0, dword [zero]
    jbe error_negative_x
    comiss xmm0, dword [one]
    jae error_x_out_of_range

    movss xmm1, xmm0
    subss xmm1, dword [one]

    movss xmm2, xmm1
    movss xmm3, xmm1
    movss xmm4, dword [one]
    mov ecx, dword [max_iter]

taylor_loop:
    cmp ecx, 0
    je taylor_end

    addss xmm4, dword [one]

    mulss xmm2, xmm1

    mulss xmm2, dword [neg_one]

    movss xmm5, xmm2
    divss xmm5, xmm4

    addss xmm3, xmm5

    dec ecx
    jmp taylor_loop

taylor_end:
    divss xmm3, dword [ln2]
    
    jmp end
    
error_negative_x:
    PRINT_STRING "3) Error: x must be greater than 0."
    jmp end

error_x_out_of_range:
    PRINT_STRING "3) Error: x must be less than 0."
    
end:
    xor eax, eax
    ret