#include <stdio.h>
#include <time.h>
#include <stdint.h>

int adler32file(char* filepath, uint32_t* result);

int main(int argc, char** argv){

	uint32_t adler32_result;
	time_t start, end;
	long int fsize;
	int result;
	FILE* fp;
	size_t j;

	/* get object file by command line argument */
	if(argc != 2){
		printf("\nERROR: argv[1] missing\n");
		return 1;
	}

	time(&start);

	for(j=0; j < 1000; ++j){

		result = adler32file("tests/data/0x00000001.txt", &adler32_result);
		printf("\n0x00000001.txt return %d and adler32: 0x%.8x =>", result, adler32_result);
		(result == 0 && adler32_result == 0x00000001) ? printf(" ok") : printf(" FAIL");

		result = adler32file("tests/data/0x00620062.txt", &adler32_result);
		printf("\n0x00620062.txt return %d and adler32: 0x%.8x =>", result, adler32_result);
		(result == 0 && adler32_result == 0x00620062) ? printf(" ok") : printf(" FAIL");

		result = adler32file("tests/data/0x012600c4.txt", &adler32_result);
		printf("\n0x012600c4.txt return %d and adler32: 0x%.8x =>", result, adler32_result);
		(result == 0 && adler32_result == 0x012600c4) ? printf(" ok") : printf(" FAIL");

		result = adler32file("tests/data/0x2e5d1316.txt", &adler32_result);
		printf("\n0x2e5d1316.txt return %d and adler32: 0x%.8x =>", result, adler32_result);
		(result == 0 && adler32_result == 0x2e5d1316) ? printf(" ok") : printf(" FAIL");

	}

	for(j=0; j < 1000; ++j){

		result = adler32file("asfsafsdf", &adler32_result);
		printf("\ninvalid file return %d =>", result);
		result == 1 ? printf(" ok") : printf(" FAIL");

	}

	time(&end);

	/* get object file size */
	fp = fopen(argv[1], "rb");
	fseek(fp, 0, SEEK_END);
	fsize = ftell(fp);
	fclose(fp);

	printf("\n\n%s size: %ld bytes", argv[1], fsize);
	printf("\nelapsed: %.f seconds\n", difftime(end, start));

	return 0;
}
