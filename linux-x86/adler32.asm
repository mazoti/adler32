; int adler32(char* buffer, int len);

global adler32

section .text
	adler32:
		cmp  byte [esp+8],0         ; check for empty buffer
		jnz  continue

		mov  eax,1
		ret

	continue:
		push edi

		mov  edi,[esp+8]            ; edi == start buffer address

		mov  eax,[esp+12]
		add  eax,edi                ; [esp-4] == end buffer address
		mov  [esp-4],eax            ; eax == adler32 final value

		mov  [esp-8],dword 1        ; s1 == [esp-8]
		mov  [esp-12],dword 0       ; s2 == [esp-12]

		mov  ecx,65521              ; MOD_ADLER

		process_buffer:
			movzx eax,byte [edi]
			add   eax,dword [esp-8]

			xor   edx,edx
			div   ecx
			mov   [esp-8],edx

			add   edx,dword [esp-12]
			mov   eax,edx

			xor   edx,edx
			div   ecx
			mov   [esp-12],edx

			inc   edi
			cmp   edi,[esp-4]
			jl    process_buffer

		mov  eax,[esp-12]
		shl  eax,16
		add  eax,dword [esp-8]

		pop  edi
		ret
