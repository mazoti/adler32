@ int adler32file(char* filepath, int* result);

.text
.global adler32file

adler32file:
	push {r5}
	push {r1}                 @ adler32 output address

	eor r1,r1,r1              @ read-only
	mov r7,#5                 @ open syscall code, filepath is on r0
	swi 0

	cmp r0,#1
	blt open_error

	mov r10,r0                @ r10 == FILE* input
	mov r12,#1                @ 1 == adler32 initial value

	ldr r8,=65535             @ 0xffff for AND operation
	and r5,r12,r8             @ s1 == r5
	mov r6,r12,lsr #16        @ s2 == r6

	ldr r8,=BUFFER
	ldr r9,=65521             @ MOD_ADLER

	read_input:
		mov r0,r10
		ldr r1,=BUFFER
		ldr r2,=BUFFER_SIZE
		mov r7,#3         @ syscall read
		swi 0

		cmp r0,#1         @ check for the end of file or error
		blt close

		eor r3,r3,r3

		process_buffer:
			ldrb r7,[r8,r3]   @ s1 = s1 + buf[n]
			add  r5,r5,r7

			remainder_s1:
				cmp r9,r5
				bgt continue_s1

				sub r5,r5,r9
				b   remainder_s1
			continue_s1:                @ modulus in r5
				add r6,r6,r5

			remainder_s2:
				cmp r9,r6
				bgt continue_s2

				sub r6,r6,r9
				b   remainder_s2

			continue_s2:                @ modulus in r6
				add r3,r3,#1

			cmp r3,r0
			blt process_buffer
		b   read_input

	close:
		cmp r0,#0
		blt read_error

		pop {r1}

		mov r6,r6,lsl #16
		add r12,r5,r6     @ save adler32 result
		str r12,[r1]

		pop {r5}

		mov r0,r10
		mov r7,#6         @ syscall close
		swi 0

		cmp r0,#0
		bne close_error

		eor r0,r0,r0
		bx  lr

	open_error:
		pop {r1}
		pop {r5}

		mov r0,#1
		bx  lr

	close_error:
		mov r0,#2
		bx  lr

	read_error:
		pop {r1}
		pop {r5}

		mov r0,r10
		mov r7,#6         @ try to close to avoid memory leak
		swi 0

		mov r0,#3
		bx  lr

.bss

@ ======= Configure here the best size for your system =======
	BUFFER: .skip 65536
	BUFFER_SIZE = .-BUFFER
@ ============================================================
