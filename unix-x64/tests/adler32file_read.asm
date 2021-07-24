; int adler32file(char* filepath, int* result);

global adler32file

; ======= Configure here the best size for your system =======
%define BUFFER_SIZE 65536
; ============================================================

section .bss
	buffer resb BUFFER_SIZE

section .text
	adler32file:
		mov  rbx,rsi                          ; adler32 output address

		xor  rsi,rsi
		mov  rax,5                            ; syscall open code
		syscall

		jc   open_error                       ; invalid input file

		mov  r15,rax                          ; file handle
		mov  r14,65521                        ; MOD_ADLER
		mov  r13,1                            ; s1 == r13d
		xor  r12,r12                          ; s2 == r12d

		read_input:                           ; synchronous read and processing (blocking input and output)
			mov  rdi,r15
			lea  rsi,[rel buffer]
			mov  rdx,BUFFER_SIZE
			mov  rax,3                    ; syscall read code
			syscall

jmp read_error

			test rax,rax                  ; bytes read
			jz   close

			lea  rdi,[rel buffer]         ; start buffer address
			lea  rsi,[rel buffer+rax]     ; end buffer address

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
			add  r13d,r12d                ; update *result with adler32
			mov  [rbx],r13d

			mov  rdi,r15
			mov  rax,6                    ; syscall close code
			syscall

			jc   close_error

			xor  rax,rax
			ret

		open_error:
			mov  rax,1
			ret

		close_error:
			mov  rax,2
			ret

		read_error:
			mov  rdi,r15
			mov  rax,6                    ; try to close to avoid memory leak
			syscall

			mov  rax,3
			ret
