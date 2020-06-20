global _start

section .text

_start:
    mov rdi, 254d	; exit code to declare
    mov rax, 60
    syscall
