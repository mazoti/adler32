; int adler32file(char* filepath, int* result);

global adler32file

%define BUFFER_SIZE 65536

section .bss
	buffer resb BUFFER_SIZE

section .text
	adler32file:
		push edi
		push esi
		push ebx

		mov  eax,5              ; syscall open code
		mov  ebx,[esp+16]       ; *filepath
		xor  ecx,ecx            ; read-only
		int  0x80

		test eax,eax
		jle  open_error

		mov  [esp-4],eax        ; file handle
		mov  [esp-8],dword 1    ; s1 == [esp-8]
		mov  [esp-12],dword 0   ; s2 == [esp-12]
		mov  esi,65521          ; MOD_ADLER

		read_input:             ; synchronous read and processing (blocking input and output)
			mov  eax,3
			mov  ebx,[esp-4]
			lea  ecx,[rel buffer]
			mov  edx,BUFFER_SIZE
			int  0x80

			test eax,eax            ; bytes read
			jle  close

			lea  edi,[rel buffer]
			lea  ebx,[rel buffer+eax]

			process_buffer:
				movzx eax,byte [edi]
				add   eax,dword [esp-8]

				xor   edx,edx
				div   esi
				mov   [esp-8],edx

				add   edx,dword [esp-12]
				mov   eax,edx

				xor   edx,edx
				div   esi
				mov   [esp-12],edx

				inc   edi
				cmp   edi,ebx
				jl    process_buffer
			jmp  read_input

		close:
			test eax,eax
			jl   read_error

			mov  eax,[esp-12]
			shl  eax,16
			add  eax,dword [esp-8]

			mov  ecx,[esp+20]       ; update *result with adler32
			mov  [ecx],eax

			mov  eax,6              ; syscall close code
			mov  ebx,[esp-4]
			int  0x80

			pop  ebx
			pop  esi
			pop  edi
jmp close_error
			test eax,eax
			jnz  close_error

			xor  eax,eax
			ret

		open_error:
			pop  ebx
			pop  esi
			pop  edi

			mov  eax,1
			ret

		close_error:
			mov  eax,2
			ret

		read_error:
			mov  eax,6
			mov  ebx,[esp-4]        ; try to close to avoid memory leak
			int  0x80

			pop  ebx
			pop  esi
			pop  edi

			mov  eax,3
			ret
