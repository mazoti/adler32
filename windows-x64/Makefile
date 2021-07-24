adler32: clean adler32file.o print.o printhex.o main.o
	link obj\main.o obj\printhex.o obj\print.o obj\adler32file.o /subsystem:console /entry:main /defaultlib:Kernel32.lib /nologo /incremental:no /opt:ref /out:"bin\adler32.exe" /LARGEADDRESSAWARE:NO

tests: clean main_test adler32_test adler32file_test print_test printhex_test
	bin\print_test               obj\print.o
	bin\printhex_test            obj\printhex.o
	bin\adler32_test             obj\adler32.o
	bin\adler32file_test         obj\adler32file.o
	bin\adler32file_close_test   obj\adler32file_close.o
	bin\adler32file_read_test    obj\adler32file_read.o
	bin\main_test                obj\main_test.o

clean:
	del /q obj\*.* bin\*.*


main.o: main.asm
	nasm -f win64 main.asm -o obj\main.o

main_test: adler32
	cl /O2 /c /GL /Wall tests\main_test.c /Foobj\main_test.o
	cl /O2 /GL /Wall obj\main_test.o /Febin\main_test.exe

	nasm -f win64 tests\main_close.asm -o obj\main_close.o
	link obj\main_close.o obj\printhex.o obj\print.o obj\adler32file.o /subsystem:console /entry:main /defaultlib:Kernel32.lib /nologo /incremental:no /opt:ref /out:"bin\main_close.exe" /LARGEADDRESSAWARE:NO

	nasm -f win64 tests\main_read.asm -o obj\main_read.o
	link obj\main_read.o obj\printhex.o obj\print.o obj\adler32file.o /subsystem:console /entry:main /defaultlib:Kernel32.lib /nologo /incremental:no /opt:ref /out:"bin\main_read.exe" /LARGEADDRESSAWARE:NO

adler32file.o: adler32file.asm
	nasm -f win64 adler32file.asm -o obj\adler32file.o

adler32file_test: adler32file.o
	cl /Os /c /GL /Wall tests\adler32file_test.c /Foobj\adler32file_test.o
	cl /O2 /GL /Wall obj\adler32file_test.o obj\adler32file.o /Febin\adler32file_test.exe /link /LARGEADDRESSAWARE:NO

	cl /Os /c /GL /Wall tests\adler32file_close_test.c /Foobj\adler32file_close_test.o
	nasm -f win64 tests\adler32file_close.asm -o obj\adler32file_close.o
	cl /O2 /GL /Wall obj\adler32file_close_test.o obj\adler32file_close.o /Febin\adler32file_close_test.exe /link /LARGEADDRESSAWARE:NO

	cl /Os /c /GL /Wall tests\adler32file_read_test.c /Foobj\adler32file_read_test.o
	nasm -f win64 tests\adler32file_read.asm -o obj\adler32file_read.o
	cl /O2 /GL /Wall obj\adler32file_read_test.o obj\adler32file_read.o /Febin\adler32file_read_test.exe /link /LARGEADDRESSAWARE:NO

adler32.o: adler32.asm
	nasm -f win64 adler32.asm -o obj\adler32.o

adler32_test: adler32.o
	cl /Os /c /GL /Wall tests\adler32_test.c /Foobj\adler32_test.o
	cl /O2 /GL /Wall obj\adler32_test.o obj\adler32.o /Febin\adler32_test.exe

printhex.o: printhex.asm
	nasm -f win64 printhex.asm -o obj\printhex.o

printhex_test: printhex.o
	cl /Os /GL /c /Wall tests\printhex_test.c /Foobj\printhex_test.o
	cl /O2 /GL /Wall obj\printhex_test.o obj\printhex.o /Febin\printhex_test.exe /link /LARGEADDRESSAWARE:NO

print.o: print.asm
	nasm -f win64 print.asm -o obj\print.o

print_test: print.o
	cl /Os /c /GL /Wall tests\print_test.c /Foobj\print_test.o
	cl /O2 /GL /Wall obj\print_test.o obj\print.o /Febin\print_test.exe
