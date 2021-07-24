adler32: main.o print.o printhex.o adler32file.o
	ld --relax -O -X -s -flto -nostdlib obj/main.o obj/printhex.o obj/print.o obj/adler32file.o -o bin/adler32

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


main.o: main.s
	as --strip-local-absolute --warn main.s -o obj/main.o

main_test: adler32
	gcc -Ofast -flto tests/main_test.c -o bin/main_test

	as --strip-local-absolute --warn tests/main_close.s -o obj/main_close.o
	ld --relax -O -X -s -flto -nostdlib obj/main_close.o obj/printhex.o obj/print.o obj/adler32file.o -o bin/main_close

	as --strip-local-absolute --warn tests/main_read.s -o obj/main_read.o
	ld --relax -O -X -s -flto -nostdlib obj/main_read.o obj/printhex.o obj/print.o obj/adler32file.o -o bin/main_read

adler32file.o: adler32file.s
	as --strip-local-absolute --warn adler32file.s -o obj/adler32file.o

adler32file_test.o: adler32file.o
	gcc -c tests/adler32file_test.c -o obj/adler32file_test.o
	gcc -Ofast -flto obj/adler32file_test.o obj/adler32file.o -o bin/adler32file_test

	as --strip-local-absolute --warn tests/adler32file_close.s -o obj/adler32file_close.o
	gcc -c tests/adler32file_close_test.c -o obj/adler32file_close_test.o
	gcc -Ofast -flto obj/adler32file_close_test.o obj/adler32file_close.o -o bin/adler32file_close

	as --strip-local-absolute --warn tests/adler32file_read.s -o obj/adler32file_read.o
	gcc -c tests/adler32file_read_test.c -o obj/adler32file_read_test.o
	gcc -Ofast -flto obj/adler32file_read_test.o obj/adler32file_read.o -o bin/adler32file_read

adler32.o: adler32.s
	as --strip-local-absolute --warn adler32.s -o obj/adler32.o

adler32_test.o: adler32.o
	gcc -c tests/adler32_test.c -o obj/adler32_test.o
	gcc -Ofast -flto obj/adler32_test.o obj/adler32.o -o bin/adler32_test

printhex.o: printhex.s
	as --strip-local-absolute --warn printhex.s -o obj/printhex.o

printhex_test.o: printhex.o
	gcc -Ofast -flto -c tests/printhex_test.c -o obj/printhex_test.o
	gcc -Ofast -flto obj/printhex_test.o obj/printhex.o -o bin/printhex_test

print.o: print.s
	as --strip-local-absolute --warn print.s -o obj/print.o

print_test.o: print.o
	gcc -Ofast -flto -c tests/print_test.c -o obj/print_test.o
	gcc -Ofast -flto obj/print_test.o obj/print.o -o bin/print_test
