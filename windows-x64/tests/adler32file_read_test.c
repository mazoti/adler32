#include <stdio.h>
#include <time.h>
#include <stdint.h>


int adler32file(char* filepath, int* result);


int main(int argc, char** argv){

	uint32_t adler32_result;
	time_t start, end;
	int result, fsize;
	FILE* fp;
	size_t j;

	/* get object file by command line argument */
	if(argc != 2) return 1;

	time(&start);

	for(j=0; j < 1000; ++j){

		result = adler32file("tests\\data\\0x00620062.txt", &adler32_result);
		printf("\nread error return %d =>", result);
		result == 3 ? printf(" ok") : printf(" FAIL");

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
