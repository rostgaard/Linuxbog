/* file charcount.c - tael characters */

#include <stdio.h>

int nc;

int main()
{
    char c;
    while ( (c=getchar()) != EOF)
      ++nc;
    printf("%d\n", nc);
    return 0;
}

/*end of file charcount.c*/
