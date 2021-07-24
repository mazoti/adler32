.text
.global _start

_start:
	ldr  r0,[sp]
	cmp  r0,#2              @ argc == 2?
	bne  usage

	ldr  r0,[sp,#8]
	push {r1}               @ allocates space in the stack for adler32 value
	mov  r1,sp
	bl   adler32file

mov r0,#2

	cmp  r0,#0
	bne  process_error

	mov  r0,#1
	pop  {r1}               @ prints adler32 in hexadecimal
	bl   printhex

	mov r0,#1
	ldr r1,=usage_message   @ prints one space
	add r1,r1,#7
	mov r2,#1
	bl  print

	ldr r0,[sp,#8]
	eor r2,r2,r2            @ calculates input file name size

	argv1_size:
		add  r2,r2,#1
		ldrb r1,[r0,r2]
		cmp  r1,#0
		bne  argv1_size

	mov r0,#1
	ldr r1,[sp,#8]          @ prints input filename
	bl  print

	mov r0,#1
	ldr r1,=usage_message   @ prints one end of line (10)
	mov r2,#1
	bl  print

	eor r0,r0,r0

	quit:
		mov r7,#1
		swi 0

	process_error:
		mov r2,#26          @ error message size

		cmp r0,#2
		beq error_close_file
		cmp r0,#3
		beq error_read_file

		error_open_file:
			mov r0,#2
			ldr r1,=open_error
			bl  print

			mov r0,#1
			b   quit

		error_close_file:
			ldr r1,=close_error
			bl  print

			mov r0,#2
			b   quit

		error_read_file:
			mov r0,#2
			ldr r1,=read_error
			bl  print

			mov r0,#3
			b   quit

	usage:
		mov r0,#2
		ldr r1,=usage_message
		mov r2,#23
		bl  print

		mov r0,#4
		b   quit

.data
	usage_message: .ascii "\nUsage: adler32 <file>\n"
	open_error:    .ascii "\nError opening input file\n"
	close_error:   .ascii "\nError closing input file\n"
	read_error:    .ascii "\nError reading input file\n"
