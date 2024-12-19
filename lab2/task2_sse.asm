section .rodata
    x: dd -0.5
    num: dd 30
    ln2: dd 0.6931471805599

section .bss
    result: resd 1

section .text
    global main
    
main:
    mov rbp, rsp; for correct debugging
    movss xmm0, dword[x]
    movss xmm2, dword[ln2]
    xorps xmm1, xmm1
    mov ecx, 1
    
.start_loop:
    cmp ecx, dword[num]
    jge .end_loop
    mov eax, ecx
    cvtsi2ss xmm3, ecx
    movss xmm5, xmm0

.loop_power:
    cmp eax, 1
    jle .skip_power
    mulss xmm5, xmm0
    dec eax
    jmp .loop_power
    
.skip_power:

    movss xmm4, xmm5
    divss xmm4, xmm3

    test ecx, 1
    jnz .add_term
    subss xmm1, xmm4
    jmp .next_iter
    
.add_term:
    addss xmm1, xmm4

.next_iter:
    inc ecx
    jmp .start_loop
    
.end_loop:
    divss xmm1, xmm2
    movss dword[result], xmm1
    
    ret