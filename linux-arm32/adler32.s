@ int adler32(char* buffer, int len);

.text
.global adler32

adler32:
	cmp r1,#0                @ check for empty buffer
	bgt continue

	mov r0,#1
	bx lr

continue:
	stmfd sp!,{r5,r6,lr}

	mov r2,r0                @ r0 == return adler32 value
	add r3,r2,r1             @ r2 == buffer start address
	                         @ r3 == buffer end address

	ldr r8,=65535
	ldr r9,=65521            @ MOD_ADLER

	mov r0,#1                @ initial adler32 value
	and r5,r0,r8             @ s1 == r5
	mov r6,r0,lsr #16        @ s2 == r6

	process_buffer:
		ldrb r7,[r2]                @ s1 = s1 + buf[n]
		add r5,r5,r7

		remainder_s1:
			cmp r9,r5
			bgt continue_s1

			sub r5,r5,r9
			b remainder_s1
		continue_s1:                @ modulus in r5
			add r6,r6,r5

		remainder_s2:
			cmp r9,r6
			bgt continue_s2

			sub r6,r6,r9
			b remainder_s2

		continue_s2:                @ modulus in r6
			add r2,r2,#1

		cmp r2,r3
		blt process_buffer

		mov r6,r6,lsl #16
		add r0,r5,r6

	ldmfd sp!,{r5,r6,pc}
	bx lr
