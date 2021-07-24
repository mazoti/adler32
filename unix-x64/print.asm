; void print(int stdout_stderr, char* str, size_t size);

global print

section .text
	print:
		mov rax,4   ; write syscall
		syscall
		ret
