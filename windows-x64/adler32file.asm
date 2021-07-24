; int adler32file(char* filepath, int* result);

global adler32file

extern CreateFileA
extern CloseHandle
extern ReadFile


; ======= Configure here the best size for your system =======
%define BUFFER_SIZE 65536
; ============================================================


section .bss
	buffer resb BUFFER_SIZE

section .text
	adler32file:
		mov rbx,rdx                          ; adler32 output address

		push rbp
		mov  rbp,rsp
			push 0                           ; lpSecurityAttributes = NULL
			push 128                         ; FILE_ATTRIBUTE_NORMAL
			push 3                           ; OPEN_EXISTING
			sub  rsp,32                      ; shadow space, rcx contains file path
			xor  r9d,r9d
			xor  r8d,r8d
			mov  edx,-2147483648             ; GENERIC_READ
			call CreateFileA                 ; used to read files too (windows kernel)
		leave

		cmp rax,-1                           ; INVALID_HANDLE_VALUE
		jz open_error

		mov r15,rax                          ; file handle
		mov r14,65521                        ; MOD_ADLER
		mov r13,1                            ; s1 == r13d
		xor r12,r12                          ; s2 == r12d

		read_input:                          ; synchronous read and processing (blocking input and output)
			mov rcx,r15
			lea rdx,[rel buffer]
			mov r8,BUFFER_SIZE
			sub rsp,8
			lea r9,[rsp]                     ; bytes read

			push rbp
			mov  rbp,rsp
				push 0
				sub  rsp,32
				call ReadFile
			leave

			pop   r11

			test  rax,rax
			je    read_error

			test  r11,r11
			je    close

			lea   rdi,[rel buffer]           ; start buffer address
			lea   rsi,[rel buffer+r11]       ; end buffer address

			process_buffer:
				movzx rax,byte [rdi]
				add   eax,r13d

				xor   rdx,rdx
				div   r14d
				mov   r13d,edx

				add   r12d,r13d
				mov   eax,r12d

				xor   rdx,rdx
				div   r14d
				mov   r12d,edx

				inc   rdi
				cmp   rdi,rsi
				jl    process_buffer
		jmp read_input

		close:
			shl  r12d,16
			add  r13d,r12d                   ; update *result with adler32
			mov  [rbx],r13d

			mov  rcx,r15
			call CloseHandle

			test rax,rax
			je   close_error

			xor  rax,rax
			ret

		open_error:
			mov  rax,1
			ret

		close_error:
			mov  rax,2
			ret

		read_error:
			mov  rcx,r15
			call CloseHandle                 ; try to close to avoid memory leak

			mov  rax,3
			ret
