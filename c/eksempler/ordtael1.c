
/*file ordtael1.c - tom filtermekanisme */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

typedef long long _int64;

_int64 nc, nw, np, nl; /* taellere, char, words, punc, lines */

enum status_t { UDE, ORD, TEGN, TAL };

enum status_t status;

int main()
{
    int c;
    while ( (c=getchar()) != EOF) {
        /* her kan du skrive statements, som behandler en char
         * af gangen.
         */
    }
    printf("Antal char: %ld, antal ord: %ld, tegn: %ld, linier %d\n",
            nc, nw, np, nl);
    return 0;
}

/* end of file ordtael.c */


