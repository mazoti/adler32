; int adler32(char* buffer, int len);

global adler32

section .text
	adler32:
		test rsi,rsi    ; check for empty buffer
		jnz continue

		mov rax,1
		ret

	continue:
		                ; rdi == start buffer address
		add rsi,rdi     ; rsi == end buffer address
		                ; rax == adler32 final value

		mov r8,1        ; s1 == r8d
		xor r9,r9       ; s2 == r9d

		mov ecx,65521   ; MOD_ADLER

		process_buffer:
			movzx rax,byte [rdi]
			add   eax,r8d

			xor   rdx,rdx
			div   ecx
			mov   r8d,edx

			add   r9d,edx
			mov   eax,r9d

			xor   rdx,rdx
			div   ecx
			mov   r9d,edx

			inc   rdi
			cmp   rdi,rsi
			jl    process_buffer

		shl r9d,16
		add r8d,r9d
		mov rax,r8
		ret
