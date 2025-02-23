%include "io64.inc"

section .data
    y: dq 2.0
    x: dq 2.0          
    a: dq 0.1   
    x_minus_a: dq 0.0 
    exp_x_minus_a: dq 0.0
    exp_neg_x_minus_a: dq 0.0
    cosh_result4: dq 0.0

section .text
    global main

main:
    mov rbp, rsp

    fld qword [x]
    fsub qword [a]
    fstp qword [x_minus_a]

    fld qword [x_minus_a]
    fldl2e
    fmulp st1, st0
    
    fld st0
    frndint
    fsub st1, st0
    fxch st1
    f2xm1
    fld1
    faddp st1, st0
    fscale
    fstp st1
    fstp qword [exp_x_minus_a]

    fld qword [x_minus_a]
    fchs
    fldl2e
    fmulp st1, st0
    
    fld st0
    frndint
    fsub st1, st0
    fxch st1
    f2xm1
    fld1
    faddp st1, st0
    fscale
    fstp st1
    fstp qword [exp_neg_x_minus_a]

    fld qword [exp_x_minus_a]
    fld qword [exp_neg_x_minus_a]
    faddp st1, st0
    fld1
    fadd st0, st0
    fdivp st1, st0
    fstp qword [cosh_result4]

    fld qword [y]
    fld qword [cosh_result4]
    fcompp

    fstsw ax
    sahf

    jae condition_true

    PRINT_DEC 4, 0
    jmp end

condition_true:
    PRINT_DEC 4, 1

end:
    xor eax, eax
    ret
