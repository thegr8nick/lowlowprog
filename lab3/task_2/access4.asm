section .data
    T1: dq 1
    T2: dq 1
    T3: dq 1
    T4: dq 1

section .text
    global main
    extern access4

main:
    push rbp
    mov rbp, rsp
    mov rbx, [T1]
    mov r8, [T2]
    mov r9d, [T3]
    mov rdx, [T4]
    call access4
    pop rbp
    ret
