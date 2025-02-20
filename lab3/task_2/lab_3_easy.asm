section .text
global main
extern access6

main:
    push rbp
    mov rbp, rsp

    mov ecx, 2          ; param_1 = 2 (int)
    mov dx, 10          ; param_2 = 10 (short)
    mov r8b, 13         ; param_3 = 13 (char)
    mov r9, 5           ; param_4 = 5 (longlong)

    call access6       
    mov rsp, rbp
    pop rbp
    xor rax, rax
    ret
    
; void access6(int param_1,short param_2,char param_3,longlong param_4)
; {
; bool bVar1;
; double extraout_XMM0_Qa;  ((5 - 10) - 13) - 2 = -20
; std::sin<long_long>(((param_4 - param_2) - (longlong)param_3) - (longlong)param_1);
; bVar1 = false;
; if (extraout_XMM0_Qa < 0.0) {   
;   bVar1 = param_4 < param_2 && param_1 < param_3; 5 < 10 and 2 < 13
; }
; check(bVar1);
; return;
; }
;
;void check(char param_1)
;
;{
;  if (param_1 != '\0') {
;    puts("Access granted");
;    return;
;  }
;  puts("Access denied");
;                    /* WARNING: Subroutine does not return */
;  exit(-1);
;}
