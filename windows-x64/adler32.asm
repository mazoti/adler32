; int adler32(char* buffer, int len);

global adler32

section .text
	adler32:
		test rdx,rdx    ; check for empty buffer
		jnz  continue

		mov rax,1
		ret

		continue:
			mov rsi,rcx     ; rsi == end buffer address
			add rsi,rdx     ; rax == adler32 final value
	                        ; rcx == start buffer address
			mov r8,1        ; s1 == r8d
			xor r9,r9       ; s2 == r9d

			mov edi,65521   ; MOD_ADLER

		process_buffer:
			movzx rax,byte [rcx]
			add   eax,r8d

			xor   rdx,rdx
			div   edi
			mov   r8d,edx

			add   r9d,edx
			mov   eax,r9d

			xor   rdx,rdx
			div   edi
			mov   r9d,edx

			inc   rcx
			cmp   rcx,rsi
			jl    process_buffer

		shl r9d,16
		add r8d,r9d
		mov rax,r8
		ret
