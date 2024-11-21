%include "io64.inc"

section .data
    prompt db "Enter a number: ", 0
    ent db "", 10, 0
    output_prime db "A prime number", 10, 0
    output_not_prime db "Not a prime number", 10, 0

section .bss
    number resd 1
    is_prime resb 1

section .text
    global main
    
main:
    PRINT_STRING prompt

    GET_DEC 4, number

    mov eax, [number]
    cmp eax, 1
    je not_prime
    cmp eax, 2
    je print_prime

    mov ecx, 2
    mov byte [is_prime], 1

loop_check:
    mov eax, [number]
    xor edx, edx
    div ecx
    cmp edx, 0
    je not_prime

    mov eax, ecx
    mul ecx
    cmp eax, [number]
    jg end_check

    inc ecx
    jmp loop_check

not_prime:
    mov byte [is_prime], 0

end_check:
    mov eax, [number]

    cmp byte [is_prime], 1
    je print_prime

    PRINT_DEC 4, number
    PRINT_STRING ent
    PRINT_STRING output_not_prime
    jmp end_program

print_prime:
    PRINT_DEC 4, number
    PRINT_STRING ent
    PRINT_STRING output_prime

end_program:
    ret