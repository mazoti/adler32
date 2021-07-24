; void print(int stdout_stderr, char* str, size_t size);

global print

section .text
	print:
		push ebx

		mov  edx,[esp+16]   ; size_t size
		mov  ecx,[esp+12]   ; char* str
		mov  ebx,[esp+8]    ; STDOUT or STDERR
		mov  eax,4          ; write syscall
		int  0x80

		pop  ebx
		ret
