global _start

section .data

test_string: db "abcdef", 0

section .text
strlen:
    xor rax, rax		; init rax to zero

    .loop:
        cmp byte [rdi + rax], 0	; Check if we get the 0 value of the test_string value (the last by string convention)
        je .end			; if 0 is got then jum to label .end
            inc rax		; else inc rax (rax hold the length of the string thanks to increment.
            jmp .loop		; goto the begining of .loop
        .end:
            ret			; When we hit 'ret', rax should hold return value

_start:

    mov rdi, test_string
    call strlen			; ret --> result value in rax
    mov rdi, rax		; put rax value into rdi register, so strlen will be te exit value (echo $?)

    mov rax, 60			; exit syscall identifier
    syscall
