; int adler32file(char* filepath, int* result);

global adler32file

; ======= Configure here the best size for your system =======
%define BUFFER_SIZE 65536
; ============================================================

section .bss
	buffer resb BUFFER_SIZE

section .text
	adler32file:
		push edi
		push esi
		push ebx

		mov  eax,[esp+16]      ; *filepath
		push 0
		push eax
		push 0
		mov  eax,5             ; syscall open code
		int  0x80

		jc   open_error

		push eax               ; file handle
		push dword 1           ; s1 == [esp-8]
		push dword 0           ; s2 == [esp-12]
		mov  esi,65521         ; MOD_ADLER

		push BUFFER_SIZE
		push buffer
		mov  eax,[esp+16]
		push eax               ; push file handle again
		push 0

		read_input:            ; synchronous read and processing (blocking input and output)
			mov  eax,3
			int  0x80

			jc   read_error

			test eax,eax            ; bytes read
			jz   close

			lea  edi,[rel buffer]
			lea  ebx,[rel buffer+eax]

			process_buffer:
				movzx eax,byte [edi]
				add   eax,dword [esp+20]

				xor   edx,edx
				div   esi
				mov   [esp+20],edx

				add   edx,dword [esp+16]
				mov   eax,edx

				xor   edx,edx
				div   esi
				mov   [esp+16],edx

				inc   edi
				cmp   edi,ebx
				jl    process_buffer
			jmp  read_input

		close:
			mov  eax,[esp+16]
			shl  eax,16
			add  eax,dword [esp+20]

			mov  ecx,[esp+60]       ; update *result with adler32
			mov  [ecx],eax

			mov  eax,6              ; syscall close code
			int  0x80

			jc   close_error

			xor  eax,eax

		quit:
			add  esp,40
			pop  ebx
			pop  esi
			pop  edi

			ret

		open_error:
			add  esp,24
			mov  eax,1

			ret

		close_error:
			mov  eax,2
			jmp  quit

		read_error:
			mov  eax,6
			int  0x80                ; try to close to avoid memory leak

			mov  eax,3
			jmp  quit
