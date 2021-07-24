

<center><h1>Adler32: Assembly project in various OSs and architectures</h1></center>

This program calculates the adler32 hash of a file or buffer in memory. It was written in assembly and the tests in C.

Requirements:

- Nasm assembler (gas on arm)

- Gcc (Linux), Clang (Unix) or Visual Studio Community (Windows)

- Make tool

The tests covers 100% of the source code. It was tested on Debian, FreeBSD and Windows.

Binaries can be downloaded [here.](https://github.com/mazoti/adler32/release/)

To build from source code:

- Make sure the requirements above are in your path

- Clone or download the right version that matches your system and your architecture

- Configure the best buffer size for your system in file adler32file.asm (adler32file.s on arm)

- Go to the source folder and type "make" ("nmake" on Windows, "gmake" on FreeBSD)

- The release will be on "bin" folder

- To run the tests, type "make tests" ("nmake tests" on Windows, "gmake tests" on FreeBSD). Tests don't take more than a minute

For more information about the Adler32 algorithm check [RFC 1950](https://www.ietf.org/rfc/rfc1950.txt). Feel free to use any function inside your code and **be careful with optimization flags!**



License is 3-clause BSD. Bugs, optimizations, support, send by email to my last name at gmail.



Thanks for your time and have fun!
