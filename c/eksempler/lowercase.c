
/* file lowercase.c - skriv KUN lowercase */

#include <stdio.h>

int nc;

int main()
{
    char c;
    while ( (c=getchar()) != EOF)
        putchar(tolower(c));
    return 0;
}

/*end of file lowercase.c*/
