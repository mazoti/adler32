adler32: main.o adler32file.o print.o printhex.o
	ld -O -s -flto obj/main.o obj/adler32file.o obj/print.o obj/printhex.o -o bin/adler32

tests: print_test.o printhex_test.o adler32_test.o adler32file_test.o main_test
	./bin/print_test          obj/print.o
	./bin/printhex_test       obj/printhex.o
	./bin/adler32_test        obj/adler32.o
	./bin/adler32file_test    obj/adler32file.o
	./bin/adler32file_close   obj/adler32file.o
	./bin/adler32file_read    obj/adler32file.o
	./bin/main_test           obj/main.o

clean:
	rm bin/* obj/*


main.o: main.asm
	nasm -f elf64 main.asm -o obj/main.o

main_test: adler32
	gcc -Ofast tests/main_test.c -o bin/main_test

	nasm -f elf64 tests/main_close.asm -o obj/main_close.o
	ld -O -s -flto obj/main_close.o obj/adler32file.o obj/print.o obj/printhex.o -o bin/main_close

	nasm -f elf64 tests/main_read.asm -o obj/main_read.o
	ld -O -s -flto obj/main_read.o obj/adler32file.o obj/print.o obj/printhex.o -o bin/main_read

adler32file.o: adler32file.asm
	nasm -f elf64 adler32file.asm -o obj/adler32file.o

adler32file_test.o: adler32file.o
	gcc -c -flto tests/adler32file_test.c -o obj/adler32file_test.o
	gcc -Ofast -flto obj/adler32file_test.o obj/adler32file.o -o bin/adler32file_test

	nasm -f elf64 tests/adler32file_close.asm -o obj/adler32file_close.o
	gcc -c -flto tests/adler32file_close_test.c -o obj/adler32file_close_test.o
	gcc -Ofast -flto obj/adler32file_close_test.o obj/adler32file_close.o -o bin/adler32file_close

	nasm -f elf64 tests/adler32file_read.asm -o obj/adler32file_read.o
	gcc -c -flto tests/adler32file_read_test.c -o obj/adler32file_read_test.o
	gcc -Ofast -flto obj/adler32file_read_test.o obj/adler32file_read.o -o bin/adler32file_read

adler32.o: adler32.asm
	nasm -f elf64 adler32.asm -o obj/adler32.o

adler32_test.o: adler32.o
	gcc -c -O2 -flto tests/adler32_test.c -o obj/adler32_test.o
	gcc -Wall -O2 -flto obj/adler32_test.o obj/adler32.o -o bin/adler32_test

printhex.o: printhex.asm
	nasm -f elf64 printhex.asm -o obj/printhex.o

printhex_test.o: printhex.o
	gcc -c tests/printhex_test.c -o obj/printhex_test.o
	gcc obj/printhex_test.o obj/printhex.o -o bin/printhex_test

print.o: print.asm
	nasm -f elf64 print.asm -o obj/print.o

print_test.o: print.o
	gcc -c -O2 -flto tests/print_test.c -o obj/print_test.o
	gcc -O2 -flto obj/print_test.o obj/print.o -o bin/print_test
