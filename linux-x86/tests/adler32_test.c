#include <stdio.h>
#include <time.h>
#include <stdint.h>

int adler32(unsigned char* buffer, int len);

typedef struct {
	const char* input;
	size_t inputSize;
	uint32_t result;
} unit_test;

static const unit_test tests[] = {
	{"", 0, 0x00000001},
	{"a", 1, 0x00620062},
	{"ab", 2, 0x012600c4},
	{"How can you write a big system without C++?  -Paul Glick", 56, 0x2e5d1316}
};

int main(int argc, char** argv){

	time_t start, end;
	long int fsize;

	FILE* fp;
	size_t i, j, testsNumber = sizeof(tests) / sizeof(unit_test);

	/* get object file by command line argument */
	if(argc != 2) {
		printf("\nERROR: argv[1] missing\n");
		return 1;
	}

	time(&start);

	for(j=0; j < 10000; ++j){
		for(i=0; i < testsNumber; ++i){
			if(adler32((unsigned char*)tests[i].input, tests[i].inputSize) != tests[i].result) {
				fprintf(stderr , "\n\nTest #%zd => FAIL\n" , i+1);
				continue;
			}
			printf("\nTest #%zd => ok", i+1);
		}
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
