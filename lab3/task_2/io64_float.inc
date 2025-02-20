%include "io64.inc"

;Файл необходимо поместить в папку /include из каталога установки SASM
;(по умолчанию - C:\Program Files (x86)\SASM\include)
;
;Файл содержит макросы PRINT_FLOAT, PRINT_DOUBLE, READ_FLOAT, READ_DOUBLE, NEWLINE_
;Макросы PRINT_FLOAT, PRINT_DOUBLE, READ_FLOAT, READ_DOUBLE принимают 1 аргумент - указатель в памяти, метку в памяти или XMM-регистр.
;Примеры:
;PRINT_DOUBLE xmm0
;READ_FLOAT [rax]
;PRINT_FLOAT label1
;
;Макрос NEWLINE_ является заменой стандартного макроса NEWLINE, который по определенным причинам обнуляет XMM0-5
;Для сравнение попробуйте выполнить данный код
; mov rax, __float64__(0.1)
; movq xmm0, rax
; PRINT_DOUBLE xmm0
; NEWLINE 
; PRINT_DOUBLE xmm0

%macro IS_XMM 1
    %assign %$is_xmm 0
    %ifidni %1, xmm0
        %assign %$is_xmm 1
    %elifidni %1, xmm1
        %assign %$is_xmm 1
    %elifidni %1, xmm2
        %assign %$is_xmm 1
    %elifidni %1, xmm3
        %assign %$is_xmm 1
    %elifidni %1, xmm4
        %assign %$is_xmm 1
    %elifidni %1, xmm5
        %assign %$is_xmm 1
    %elifidni %1, xmm6
        %assign %$is_xmm 1
    %elifidni %1, xmm7
        %assign %$is_xmm 1
    %elifidni %1, xmm8
        %assign %$is_xmm 1
    %elifidni %1, xmm9
        %assign %$is_xmm 1
    %elifidni %1, xmm10
        %assign %$is_xmm 1    
    %elifidni %1, xmm11
        %assign %$is_xmm 1
    %elifidni %1, xmm12
        %assign %$is_xmm 1
    %elifidni %1, xmm13
        %assign %$is_xmm 1
    %elifidni %1, xmm14
        %assign %$is_xmm 1
    %elifidni %1, xmm15
        %assign %$is_xmm 1  
    %endif
    %endmacro

%macro pushxmm 1
    sub rsp, 16
    movdqu [rsp], %1
%endmacro

%macro popxmm 1
    movdqu %1, [rsp]
    add rsp, 16
%endmacro

%macro SAVE_REGS 0
    pushfq
    push rax
    push rcx
    push rdx
    push r8
    push r9
    push r10
    push r11
    pushxmm xmm0
    pushxmm xmm1
    pushxmm xmm2
    pushxmm xmm3
    pushxmm xmm4
    pushxmm xmm5
%endmacro


%macro RESTORE_REGS 0
    popxmm xmm5
    popxmm xmm4
    popxmm xmm3
    popxmm xmm2
    popxmm xmm1
    popxmm xmm0
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdx
    pop rcx
    pop rax
    popfq
%endmacro

%macro NEWLINE_ 0
SAVE_REGS
NEWLINE
RESTORE_REGS
%endmacro

%macro PRINT 0
    sub rsp, 32
    call printf
    call get_stdout
    mov rcx, rax
    call fflush
    add rsp, 32
%endmacro

%macro READ 0
    sub rsp, 32
    call scanf
    add rsp, 32
%endmacro

%macro PRINT_DOUBLE 1
    IS_GPR %1
    IS_XMM %1
    SAVE_REGS
    jmp %%after_s
    %%s: db "%lf", 0
    %%after_s:
    %if %$is_reg = 1
        %error "Only XMM registers, labels and memory [except RSP-based pointers] are supported"
    %elif %$is_xmm = 1
        movsd xmm1, %1
        movq rdx, xmm1
        mov rcx, %%s
        PRINT
    %elifstr %1
        jmp %%after_s1
        %%s1: db %1, 0
        %%after_s1:
        mov rcx, %%s1
        PRINT
    %elifid %1
        movsd xmm1, [%1]
        movq rdx, xmm1
        mov rcx, %%s
        PRINT
    %else
        movsd xmm1, %1
        movq rdx, xmm1
        mov rcx, %%s
        PRINT
    %endif
    RESTORE_REGS
%endmacro


%macro PRINT_FLOAT 1
    IS_GPR %1
    IS_XMM %1
    SAVE_REGS
    jmp %%after_s
    %%s: db "%f", 0
    %%after_s:
    %if %$is_reg = 1
        %error "Only XMM registers, labels and memory [except RSP-based pointers] are supported"
    %elif %$is_xmm = 1
        cvtss2sd xmm1, %1
        movq rdx, xmm1
        mov rcx, %%s
        PRINT
    %elifstr %1
        jmp %%after_s1
        %%s1: db %1, 0
        %%after_s1:
        mov rcx, %%s1
        PRINT
    %elifid %1
        cvtss2sd xmm1, [%1]
        movq rdx, xmm1
        mov rcx, %%s
        PRINT
    %else
        cvtss2sd xmm1, %1
        movq rdx, xmm1
        mov rcx, %%s
        PRINT
    %endif
    RESTORE_REGS
%endmacro

%macro READ_DOUBLE 1
    IS_GPR %1
    %if %$is_reg = 1
        %error "Only XMM registers, labels and memory [except RSP-based pointers] are supported"
    %endif
    IS_XMM %1
    
    %if %$is_xmm = 1
        push rbx
        sub rsp, 8
        mov rbx, rsp
    %endif
    
    SAVE_REGS
    jmp %%after_s
    %%s: db "%lf", 0
    %%after_s:    
    mov rcx, %%s
    
    %if %$is_xmm = 1
        mov rdx, rbx  
    %elifstr %1
        %error "Wrong argument"
    %elifid %1
        lea rdx, [%1]
    %else
        lea rdx, %1
    %endif
    READ
    RESTORE_REGS
    
    %if %$is_xmm = 1
        movsd %1, [rbx]
        add rsp,8
        pop rbx
    %endif
%endmacro

%macro READ_FLOAT 1
    IS_GPR %1
    %if %$is_reg = 1
        %error "Only XMM registers, labels and memory [except RSP-based pointers] are supported"
    %endif
    IS_XMM %1
    
    %if %$is_xmm = 1
        push rbx
        sub rsp, 8
        mov rbx, rsp
    %endif
    
    SAVE_REGS
    jmp %%after_s
    %%s: db "%f", 0
    %%after_s:    
    mov rcx, %%s
    
    %if %$is_xmm = 1
        mov rdx, rbx  
    %elifstr %1
        %error "Wrong argument"
    %elifid %1
        lea rdx, [%1]
    %else
        lea rdx, %1
    %endif
    READ
    RESTORE_REGS
    
    %if %$is_xmm = 1
        movss %1, [rbx]
        add rsp,8
        pop rbx
    %endif
%endmacro
