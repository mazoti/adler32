; void print(int stdout_stderr, char* str, size_t size);

extern GetStdHandle
extern WriteFile

global print

section .text
	print:
		push rbp
		mov  rbp,rsp
		sub  rsp,32

		call GetStdHandle

		mov  rcx,rax
		xor  r9d,r9d

		call WriteFile

		leave
		ret
