; int main(int argc, char** argv){

global _start

extern adler32file
extern printhex
extern print

%define STDOUT 1
%define STDERR 2

segment .data
	usage_message   db 10,'Usage: adler32 <file>',10
	open_error      db 10,'Error opening input file',10
	close_error     db 10,'Error closing input file',10
	read_error      db 10,'Error reading input file',10

segment .text
	_start:
		cmp  byte [esp],2
		jnz  usage

		mov  eax,[esp+8]                 ; eax points to input file address
		push dword 1
		lea  ecx,[esp]
		push ecx
		push eax
		call adler32file
mov eax,2
		test eax,eax
		jne  process_error

		pop  eax
		pop  eax
		mov  ecx,[eax]
		push ecx
		push STDOUT                      ; prints adler32 in hexadecimal
		call printhex

		push 1
		lea  eax,[rel usage_message+7]   ; prints one space
		push eax
		push STDOUT
		call print

		mov  eax,[esp+32]
		xor  edx,edx                     ; calculates input file name size

		argv1_size:
			inc edx
			or  byte [rel eax+edx],0
			jne argv1_size

		push edx
		mov  ecx,[esp+36]                ; prints input filename
		push ecx
		push STDOUT
		call print

		push 1
		lea  eax,[rel usage_message]     ; prints one end of line (10)
		push eax
		push STDOUT
		call print

		xor  ebx,ebx

	quit:
		mov  eax,1
		int  0x80

	process_error:
		push 26                          ; error message size

		cmp  eax,2
		je   error_close_file
		cmp  eax,3
		je   error_read_file

		error_open_file:
			push open_error
			push STDERR
			call print

			mov  ebx,1
			jmp  quit

		error_close_file:
			push close_error
			push STDERR
			call print

			mov  ebx,2
			jmp  quit

		error_read_file:
			push read_error
			push STDERR
			call print

			mov  ebx,3
			jmp  quit

	usage:
		push 23
		push usage_message
		push STDERR
		call print

		mov  ebx,4
		jmp  quit
