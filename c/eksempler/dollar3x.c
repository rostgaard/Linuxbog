
/* dollar3x.c kroner til dollar UDEN prototype. */

#include <stdio.h>
#include <stdlib.h>
#define MAXL 8000

int main()
{
    double kroner;
    char inputlinie[MAXL];

    printf("OMREGNING FRA KRONER TIL DOLLAR\n");
    while (printf("Input kroner: "), fgets(inputlinie,MAXL,stdin)!=NULL) {
        kroner = atoi(inputlinie);
        printf("kroner %6.2f giver dollar %6.2f\n", kroner, kr2dollar(kroner));
    }
    return 0;
}

/* end of file dollar3x.c */

