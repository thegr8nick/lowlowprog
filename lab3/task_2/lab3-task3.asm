section .rodata 
  a: dq 0, 0xFFF0000000000000
 
section .text                    
global main  
extern access5  
;  namespace var5 {
;       struct S {
;           int one, one_;
;           double two; }
;
;       void access5(float a, int b, S& c) {
;           int r12d=0;
;           double rdx= c.two;
;           if ((c.one==c.one_)&& isinf(rdx) && ((float)b-a==6312.0)
;                  {r12d=1;}
;           if (r12d==1)
;               printf(%s, "Access granted");
;           else 
;                printf(%s, "Access denied");
;       }
;  }
main: 
    push rbp 
    mov rbp, rsp 
    sub rsp, 32 
     
    lea r8, [a] 
    mov edx, 6312   
    mov rbx, 0
    cvtsi2sd xmm0, rbx
    call access5
     
    xor rax, rax 
    leave    
    ret 
        