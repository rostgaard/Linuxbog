
/* char2tal.c */

#include <stdio.h>

int main()
{
    int c;
    while ( (c=getchar()) != EOF) {
      printf("Decimal-værdi %3d, hexadecimal værdi 0x%2x ", c, c);
      if (c > 31 && c < 127)
          printf("%c\n", c);
      else
          printf(".\n");
    }
    return 0;
}
