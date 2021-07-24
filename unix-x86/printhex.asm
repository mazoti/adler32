; void printhex(int stdout_stderr, int number);

global printhex

section .data
	hex_table db '0123456789abcdef'

section .text
	printhex:
		mov edi,esp

		mov eax,[esp+8]                ; number to print in hex
		mov ebx,[esp+4]                ; stdout or stderr

		divide:
			mov  edx,eax
			and  edx,15            ; divide by 16

			push edx               ; save the modulus
			shr  eax,4
			jnz  divide

		print_stack:
			pop  esi
			lea  ecx,[rel hex_table+esi]

			push 1                 ; write 1 character
			push ecx
			push ebx
			sub  esp,4
			mov  eax,4
			int  0x80

			add  esp,16
			cmp  edi,esp
			jne  print_stack
		ret
