
/* dollar1.c From Kroner calculate Dollar. */

#include <stdio.h>
#include <stdlib.h>

int kr2dollar(int kr);

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

/* end of file dollar1.c */


