; void print(int stdout_stderr, char* str, size_t size);

global print

section .text
	print:
		mov  eax,4          ; write syscall
		int  0x80

		ret
