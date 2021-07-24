; void printhex(int stdout_stderr, int number);

global printhex

extern GetStdHandle
extern WriteFile

section .data
	hex_table db '0123456789abcdef'

section .text
	printhex:
		mov rsi,rcx

		mov rbx,rsp
		mov rax,rdx

		divide:
			mov  rdx,rax
			and  rdx,15                    ; push the mod 16

			push rdx
			shr  rax,4
			jnz  divide

		print_stack:
			mov  rcx,rsi
			pop  rdi

			push rbp
			mov  rbp,rsp
			sub  rsp,32

			call GetStdHandle

			mov  rcx,rax                   ; rax contains stderr or stdout address
			lea  rdx,[rel hex_table+rdi]
			xor  r9d,r9d
			mov  r8d,1

			call WriteFile

			leave

			cmp rbx,rsp
			jnz print_stack

		ret
