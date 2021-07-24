; void print(int stdout_stderr, char* str, size_t size);

global print

section .text
	print:
		mov rax,1   ; write syscall
		syscall
		ret

