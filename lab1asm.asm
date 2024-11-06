section .data
    prompt db "Enter a number: ", 0
    output_prime db "%d A prime number", 10, 0
    output_not_prime db "%d Not a prime number.", 10, 0
    format_input db "%d", 0

section .bss
    number resd 1
    is_prime resb 1

section .text
    extern printf, scanf
    global main

main:
    push prompt
    call printf
    add esp, 4

    push number
    push format_input
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
    mov eax, [number]
    push eax
    cmp byte [is_prime], 1
    je print_prime

    push eax
    push output_not_prime
    call printf
    add esp, 8
    jmp end_program

print_prime:
    push eax
    push output_prime
    call printf
    add esp, 8

end_program:
    ret
