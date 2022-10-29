

# **Adler32**

#### _Assembly project in various operating systems and architectures_

![FreeBSD](https://img.shields.io/badge/-FreeBSD-%23870000?style=for-the-badge&logo=freebsd&logoColor=white)![NetBSD](https://img.shields.io/badge/NetBSD-FF6600.svg?style=for-the-badge&logo=NetBSD&logoColor=white)![OpenBSD](https://img.shields.io/badge/-OpenBSD-%23FCC771?style=for-the-badge&logo=openbsd&logoColor=black)![Alpine Linux](https://img.shields.io/badge/Alpine_Linux-%230D597F.svg?style=for-the-badge&logo=alpine-linux&logoColor=white)![Debian](https://img.shields.io/badge/Debian-D70A53?style=for-the-badge&logo=debian&logoColor=white)![Manjaro](https://img.shields.io/badge/Manjaro-35BF5C.svg?style=for-the-badge&logo=Manjaro&logoColor=white)![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)

This is an educational open source program to calculate adler32 hash of a file or buffer in memory. It is written in assembly and tests in C.

The goal is to show how to code in assembly and in the end have a very small, fast and usefull application!

Next steps will be integration with high level programming languages.

## Installation

All you need is the adler32 binary file of your architecture and operating system.

Binaries can be downloaded [here.](https://github.com/mazoti/adler32/tree/main/releases)

## Usage:
On command line:
```bash
adler32 <filepath>
```

## Requirements:

- Nasm assembler (gas on arm)

- Gcc (Linux), Clang (Unix) or Visual Studio Community (Windows)

- Make tool (optional, you can run the steps manually)

The tests covers 100% of the source code.

## Build from source:

- Make sure the requirements above are in your path

- Clone or download the right version that matches your system and your architecture

- Configure the best buffer size for your system in file adler32file.asm (adler32file.s on arm)

- Go to the source folder and type "make" ("nmake" on Windows, "gmake" on FreeBSD)

- The release will be on "bin" folder

- To run the tests, type "make tests" ("nmake tests" on Windows, "gmake tests" on FreeBSD). Tests don't take more than a minute

For more information about the Adler32 algorithm check [RFC 1950](https://www.ietf.org/rfc/rfc1950.txt). Feel free to use any function inside your code and **be careful with optimization flags!**

## Donations
You can become a [sponsor](https://github.com/sponsors/mazoti) of this project or donate directly:

BTC: 3JpkXivH11xQU37Lwk5TFBqLUo8gytLH84

[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

**Thanks for your time and have fun!**