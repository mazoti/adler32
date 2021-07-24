#include <stdio.h>
#include <time.h>
#include <stdlib.h>

int main(int argc, char** argv){

	time_t start, end;
	int result;
	long fsize;
	FILE* fp;
	size_t j;

	/* get object file by command line argument */
	if(argc != 2){
		printf("\nERROR: argv[1] missing\n");
		return 1;
	}

	time(&start);

	for(j=0; j < 10; ++j){

		result = system("./bin/adler32 tests/data/0x012600c4.txt");
		printf("valid file return %d =>", result);
		result == 0 ? printf(" ok\n") : printf(" FAIL\n");

		result = system("./bin/adler32 asdfsadfasd") >> 8;
		printf("invalid input file return %d =>", result);
		result == 1 ? printf(" ok\n") : printf(" FAIL\n");

		result = system("./bin/main_close tests/data/0x012600c4.txt") >> 8;
		printf("close file error return %d =>", result);
		result == 2 ? printf(" ok\n") : printf(" FAIL\n");

		result = system("./bin/main_read tests/data/0x012600c4.txt") >> 8;
		printf("read file error return %d =>", result);
		result == 3 ? printf(" ok\n") : printf(" FAIL\n");

		result = system("./bin/adler32") >> 8;
		printf("wrong arguments error return %d =>", result);
		result == 4 ? printf(" ok\n\n") : printf(" FAIL\n\n");

	}

	time(&end);

	/* get object file size */
	fp = fopen(argv[1], "rb");
	fseek(fp, 0, SEEK_END);
	fsize = ftell(fp);
	fclose(fp);

	printf("%s size: %ld bytes", argv[1], fsize);
	printf("\nelapsed: %.f seconds\n", difftime(end, start));

	return 0;
}
