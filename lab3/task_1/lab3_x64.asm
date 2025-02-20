;%include "io64.inc"

section .rodata
    polynomial: dd 0xEDB88320
    init_crc: dd 0xFFFFFFFF
    final_crc: dd 0xFFFFFFFF 
    fmt_input: db "%s", 0
    fmt_output: db "%08X", 10, 0
    
    

section .text
extern printf
extern scanf
extern malloc
extern free
global main


main:
    ;mov rbp, rsp; for correct debugging
    ; i - ECX 
    ; data - RSI
    ; crc - EDX
    ;GET_STRING data, 256
    push r12
    push rsi
    push rbp
    mov rbp, rsp
    sub rsp, 32
    
    mov rcx, 257 ; RCX, RDX, R8, R9, XMM0-3
    call malloc ; result to RAX, if not success NULL
    mov r12, rax ; regsiter non-volatile(ben vung)
    
    ;read input string
    lea rcx, [fmt_input]
    mov rdx, r12
    call scanf
    
    ;initialize CRC calculation
    mov edx, [init_crc]
    mov rsi, r12
.cycle_start:      ; Load the address of input into RSI
    movzx eax, byte [rsi] ; Move with Zero-Extend: Copy the first byte of input into EAX
    test al, al
    jz .cycle_end
     
    xor edx, eax  
    mov ecx, 0  ; Initialize counter to 0
.bit_loop:
    mov eax, edx
    and eax, 1  ; Now EAX contains the least significant bit of EDX
    shr edx, 1 

    test eax, eax ; check if least significant bit is 0 or 1
    jz .bit_end   ; if 0, skip XOR operation
    xor edx, [polynomial] ; if 1, XOR EDX with polynomial
.bit_end:
    inc ecx       ; Increment counter
    cmp ecx, 8    ; Compare counter with 8
    jl .bit_loop  ; If counter is less than 8, continue loop

    inc rsi
    jmp .cycle_start
.cycle_end:
    xor edx, [final_crc] ;0xF...F
    
    ;print result
    lea rcx, [fmt_output]
    call printf
    
    ;free memory
    mov rcx, r12
    call free
    xor eax, eax
    leave
    pop rsi
    pop r12
    ret   