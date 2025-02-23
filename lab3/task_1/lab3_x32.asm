%include "io64.inc"

section .data
    ent db "", 10, 0
    output_prime db "A prime number", 10, 0
    output_not_prime db "Not a prime number", 10, 0
    length_fmt db "%d", 0
    string_fmt db "%s", 0

section .bss
    number resd 1
    is_prime resb 1

section .text
    global main
    extern printf
    extern scanf

main:
    push ebp
    mov ebp, esp
    sub esp, 40

    push number
    push length_fmt
    call scanf
    add esp, 8

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
    cmp byte [is_prime], 1
    je print_prime

    push output_not_prime
    push string_fmt
    call printf
    add esp, 8

    jmp end_program

print_prime:
    push output_prime
    push string_fmt
    call printf
    add esp, 8

end_program:
    mov esp, ebp
    pop ebp
    ret