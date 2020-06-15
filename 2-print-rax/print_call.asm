section .data
newline_char: db 10
codes: db '0123456789abcdef'

section .text
global _start

print_newline:
    mov rax, 1			; 'write' syscall identifier
    mov rdi, 1			; stdout file descriptor
    mov rsi, newline_char	; where do we take data from (10 is EOF)
    mov rdx, 1			; the amount of bytes to write
    syscall			; rax, rdi
    ret

print_hex:
    mov rax, rdi

    mov rdi, 1
    mov rdx, 1
    mov rcx, 64			; how far are we shifting rax ?
    iterate:
        push rax		; save the initial rax value
        sub rcx, 4
        sar rax, cl		; shift to 60, 56, 51, …4, 0
				; the cl register is the smaller part of rcx
        and rax, 0xf		; clear all bits but the lower four (mask).
        lea rsi, [codes + rax]	; take a hexadecimal digit character code

        mov rax, 1		; syscall write identifier

        push rcx		; save rcx because syscall will break rcx
        syscall			; rax =1 (write), rdi = 1 (stdout), rsi = the address of a character line 28
        
        pop rcx

        pop rax			; see line 24
        test rcx, rcx		; rcx = 0 when all digits are shown
        jnz iterate

        ret
_start:
    mov rdi, 0x1122334455667788
    call print_hex
    call print_newline

    mov rax, 60			; exit identifier for syscall
    xor rdi, rdi
    syscall
