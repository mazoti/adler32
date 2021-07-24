; void printhex(int stdout_stderr, int number);

global printhex

section .data
	hex_table db '0123456789abcdef'

section .text
	printhex:
		mov rax,1      ; write syscall
		mov rbx,rsp
		mov rdx,1      ; write 1 character

		divide:
			mov  rcx,rsi
			and  rcx,15    ; push mod 16
			push rcx

			shr  rsi,4
			jnz  divide

		print_stack:
			pop  rcx

			lea  rsi,[rel hex_table]
			add  rsi,rcx
			syscall

			cmp  rbx,rsp
			jne  print_stack
		ret
