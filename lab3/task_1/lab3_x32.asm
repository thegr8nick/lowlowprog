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
    push ebp
    mov ebp, esp
    sub esp, 32
    
    ; выделение памяти для строки
    push 257  ; размер строки + 1
    call malloc
    add esp, 4
    mov esi, eax ; указатель на строку

    ; чтение ввода строки
    push esi
    push fmt_input
    call scanf
    add esp, 8

    ; инициализация CRC
    mov edx, dword [init_crc]

.cycle_start:
    movzx eax, byte [esi] ; загружаем байт
    test al, al
    jz .cycle_end

    xor edx, eax
    mov ecx, 0

.bit_loop:
    mov eax, edx
    and eax, 1
    shr edx, 1
    test eax, eax
    jz .bit_end
    xor edx, dword [polynomial]

.bit_end:
    inc ecx
    cmp ecx, 8
    jl .bit_loop

    inc esi
    jmp .cycle_start

.cycle_end:
    xor edx, dword [final_crc]

    ; вывод результата
    push edx
    push fmt_output
    call printf
    add esp, 8

    ; освобождение памяти
    push esi
    call free

    xor eax, eax
    leave
    ret
