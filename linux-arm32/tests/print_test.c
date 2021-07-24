#include <stdio.h>
#include <time.h>

void print(int stdout_stderr, char* str, size_t size);

int main(int argc, char** argv){

	time_t start, end;
	long int fsize;
	FILE* fp;
	size_t i;

	/* get object file by command line argument */
	if(argc != 2){
		printf("\nERROR: argv[1] missing\n");
		return 1;
	}

	time(&start);

	for(i=0; i < 10000; ++i){
		print(1, "Hello World!\n",13);
		print(1, "Hello\n",6);
		print(2, "World!\n",7);
	}

	time(&end);

	/* get object file size */
	fp = fopen(argv[1], "rb");
	fseek(fp, 0, SEEK_END);
	fsize = ftell(fp);
	fclose(fp);

	printf("\n%s size: %ld bytes", argv[1], fsize);
	printf("\nelapsed: %.f seconds\n", difftime(end, start));

	return 0;
}
