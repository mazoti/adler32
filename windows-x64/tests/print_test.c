#include <stdio.h>
#include <time.h>

void print(int stdout_stderr, char* str, size_t size);

int main(int argc, char** argv){

	time_t start, end;
	int result, fsize;
	FILE* fp;
	size_t i;

	/* get object file by command line argument */
	if(argc != 2) return 1;

	time(&start);

	for(i=0; i < 10000; ++i){
		print(-11, "Hello World!\n",13);
		print(-11, "Hello\n",6);
		print(-12, "World!\n",7);
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
