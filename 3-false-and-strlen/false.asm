global _start

section .text
_start:
    mov rdi, 1		;to return 1 form exit syscall
    mov rax, 60		;exit syscall identifier
    syscall
