
/* summer.c */

#include <stdio.h>
#include <stdlib.h>

#define MAXL 80000
int main()
{
    char line[MAXL];/* for input */
    char *ptr; /* for strtod konverteringspointer */
    double tal;/* for det laeste tal */
    double sum = 0;/* for totalen */

    while ( (fgets(line,MAXL,stdin)) != NULL) {
     tal = strtod(line,&ptr);
     sum += tal;
    }
    printf("%18.2f\n",sum);
    return 0;
}
/* end of file summer.c */

