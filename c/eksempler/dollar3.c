
/* dollar3.c bed om kroner og beregn dollar. */

#include <stdio.h>
#include <stdlib.h>
#define MAXL 8000

int main()
{
    double kroner;
    double kr2dollar(double);	/* placeret her har prototypen
				   kun scope i denne funktion - 
				   her kun for at vise muligheden for
				   at gøre det på denne måde.
				 */
    char inputlinie[MAXL];

    printf("OMREGNING FRA KRONER TIL DOLLAR\n");
    while (printf("Input kroner: "), fgets(inputlinie, MAXL, stdin) != NULL) {
	kroner = atoi(inputlinie);
	printf("kroner %6.2f giver dollar %6.2f\n", kroner, kr2dollar(kroner));
    }
    return 0;
}

/* end of file dollar3.c */
