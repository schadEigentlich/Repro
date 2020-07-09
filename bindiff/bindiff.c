#include <stdio.h>

size_t filesize(FILE *fp){
  fseek(fp, 0L, SEEK_END);
  size_t size = ftell(fp);
  fseek(fp, 0L, SEEK_SET);
  return size;
}

int main(int argc, char** argv){
  int verbose = 0;
  if(argc > 3){
    verbose = 1;
  }
  FILE *a = fopen(argv[1], "r");
  FILE *b = fopen(argv[2], "r");
  size_t size_a = filesize(a);
  size_t size_b = filesize(b);
  size_t min_size = size_a > size_b ? size_b : size_a;
  int errors = 0;
	int lastdiff =-2;
  for(size_t i = 0; i < min_size; i++){
    int x = fgetc(a);
    int y = fgetc(b);

    if(x!=y){
      if(verbose){
	if(lastdiff==i-1){
	}else{
        printf("%d %x ", i, i);
	}
	lastdiff = i;
      }
      errors++;
    }else{
	if(lastdiff==i-1){
	printf(" until %d %x\n", i, i);
	}
}
  }
	if(errors){
  printf("Sizes: %u %u, diff: %d\n", size_a, size_b, size_a - size_b);

  printf("%d of %u bytes differ. %f%%\n", errors, min_size, ((float)errors/(float)min_size)*100.0);
}
  return errors;
}
