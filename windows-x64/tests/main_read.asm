; int main(int argc, char** argv){

bits 64
default rel

global main

extern ExitProcess
extern GetCommandLineA

extern adler32file
extern printhex
extern print

%define STDOUT -11
%define STDERR -12

%macro cmd_line 1
	inc rax
	or  byte [rax],0
	je  usage
	cmp byte [rax],%1
%endmacro

%macro exit 1
	mov  rcx,%1
	call ExitProcess
%endmacro

segment .data
	usage_message   db 10,'Usage: adler32 <file>',10
	open_error      db 10,'Error opening input file',10
	close_error     db 10,'Error closing input file',10
	read_error      db 10,'Error reading input file',10

segment .text
	get_argv1:
		call GetCommandLineA             ; rax points to full command line string (ex: program.exe arg1 arg2)
		cmp byte [rax],'"'               ; works only when argc == 2 (skips program name)
		jz skip_quotes

		skip_char:
			cmd_line ' '
			jnz skip_char
			jmp first_arg

		skip_quotes:
			cmd_line '"'
			jz  first_arg
			jmp skip_quotes

		first_arg:
			cmd_line ' '
			jz  first_arg
		ret

	main:
		call get_argv1
		push rax

		mov  rcx,rax
		push 1                           ; rax points to input file address
		lea  rdx,[rsp]
		call adler32file

mov rax,3
jmp process_error

		mov  rcx,STDOUT
		pop  rdx                         ; prints adler32 in hexadecimal
		call printhex

		mov  rcx,STDOUT
		lea  rdx,[rel usage_message+7]   ; prints one space
		mov  r8,1
		call print

		mov rax,[rsp]
		xor r8,r8                        ; calculates input file name size

		argv1_size:
			inc r8
			or byte [rel rax+r8],0
			jne argv1_size

		pop rax

		mov  rcx,STDOUT
		mov  rdx,rax                     ; prints input filename
		call print

		mov  rcx,STDOUT
		lea  rdx,[rel usage_message]     ; prints one end of line (10)
		mov  r8,1
		call print

		exit 0

	process_error:
		mov rcx,STDERR
		mov r8,26                        ; error message size

		cmp rax,2
		je  error_close_file
		cmp rax,3
		je  error_read_file

		error_open_file:
			lea  rdx,[rel open_error]
			call print

			exit 1

		error_close_file:
			lea  rdx,[rel close_error]
			call print

			exit 2

		error_read_file:
			lea  rdx,[rel read_error]
			call print

			exit 3
	usage:
		mov  rcx,STDERR
		lea  rdx,[rel usage_message]
		mov  r8,23
		call print

		exit 4
