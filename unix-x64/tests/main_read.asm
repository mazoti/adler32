; int main(int argc, char** argv){

global _start

extern adler32file
extern printhex
extern print

%define STDOUT 1
%define STDERR 2

%macro exit 1
	mov rdi,%1
	jmp quit
%endmacro

segment .data
	usage_message   db 10,'Usage: adler32 <file>',10
	open_error      db 10,'Error opening input file',10
	close_error     db 10,'Error closing input file',10
	read_error      db 10,'Error reading input file',10

segment .text
	_start:
		cmp  byte [rsp],2
		jne  usage

		mov  rdi,[rsp+16]                ; rdi points to input file address
		push 1
		lea  rsi,[rsp]
		call adler32file
		pop  rsi

mov rax,3

		test rax,rax
		jne  process_error

		mov  rdi,STDOUT	                 ; prints adler32 in hexadecimal
		call printhex

		mov  rdi,STDOUT
		lea  rsi,[rel usage_message+7]   ; prints one space
		mov  rdx,1
		call print

		mov  rax,[rsp+16]
		xor  rdx,rdx                     ; calculates input file name size

		argv1_size:
			inc rdx
			or  byte [rel rax+rdx],0
			jne argv1_size

		mov  rdi,STDOUT
		mov  rsi,[rsp+16]                ; prints input filename
		call print

		mov  rdi,STDOUT
		lea  rsi,[rel usage_message]     ; prints one end of line (10)
		mov  rdx,1
		call print

		xor  rdi,rdi
	quit:
		mov  rax,1
		syscall

	process_error:
		mov rdi,STDERR
		mov rdx,26                       ; error message size

		cmp rax,2
		je  error_close_file
		cmp rax,3
		je  error_read_file

		error_open_file:
			lea  rsi,[rel open_error]
			call print
			exit 1

		error_close_file:
			lea  rsi,[rel close_error]
			call print
			exit 2

		error_read_file:
			lea  rsi,[rel read_error]
			call print
			exit 3

	usage:
		mov  rdi,STDERR
		lea  rsi,[rel usage_message]
		mov  rdx,23
		call print
		exit 4
