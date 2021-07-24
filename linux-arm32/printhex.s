@ void printhex(int stdout_stderr, int number);

.text
.global printhex
	printhex:
		stmfd sp!,{r4-r5,lr}

		mov r2,#1
		mov r5,r0
		mov r7,#4

		mov r4,sp

		divide:
			and  r3,r1,#15
			push {r3}
			lsrs r1,#4
			bne  divide

		print_stack:
			pop  {r3}
			ldr  r1,=hex_table
			add  r1,r1,r3

			swi  0

			mov  r0,r5
			cmp  r4,sp
			bne  print_stack

		ldmfd sp!,{r4-r5,pc}
		bx lr

.data
	hex_table: .ascii "0123456789abcdef"
