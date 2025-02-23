%include "io64.inc"

section .data
    prompt db "Enter a number: ", 0
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
    CEXTERN printf
    CEXTERN scanf
    
main:
    mov rbp, rsp
    sub rsp, 40
    
    mov rcx, length_fmt
    mov rdx, number  
    call scanf
    

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
    
    mov rcx, string_fmt
    mov rdx, output_not_prime
    call printf
    
    jmp end_program

print_prime:
    mov rcx, string_fmt
    mov rdx, output_prime
    call printf

end_program:
    xor eax, eax
    and rsp, 40
    mov rsp, rbp
    ret