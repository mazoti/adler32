; void printhex(int stdout_stderr, int number);

global printhex

section .data
	hex_table db '0123456789abcdef'

section .text
	printhex:
		push esi
		push ebx

		mov edi,esp

		mov eax,[esp+16]                ; number to print in hex
		mov ebx,[esp+12]                ; stdout or stderr

		divide:
			mov  edx,eax
			and  edx,15            ; divide by 16

			push edx               ; save the modulus
			shr  eax,4
			jnz  divide

		mov edx,1                      ; write 1 character

		print_stack:
			pop  esi
			lea  ecx,[rel hex_table+esi]
			mov  eax,4
			int  0x80

			cmp  edi,esp
			jne  print_stack

		pop ebx
		pop esi
		ret
