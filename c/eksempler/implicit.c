
/* implicit.c Kroner til dollar, uden prototype. */

#include <stdio.h>
#include <stdlib.h>


int main()
{
    int kroner;
    char inputlinie[800];

    printf("OMREGNING FRA KRONER TIL DOLLAR\n");
    while (printf("Input tal:"),
           fgets(inputlinie,800,stdin)!=NULL) {
        kroner = atoi(inputlinie);
        printf("Kroner %d giver Dollar %d\n", kroner, kr2dollar(kroner));
    }
    return 0;
}

/* end of file implicit.c */


