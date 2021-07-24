@ void print(int stdout_stderr, char* str, size_t size);

.text
.global print

print:
	mov r7,#4   @ write system call
	swi 0
	bx lr
