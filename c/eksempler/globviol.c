
/* fil 1. Demonstration af uheldig praksis. */

/* programmet kompilerer uden warnings - ikke engang option
 * -Wall, som ellers betyder "giv mig alle warnings", får gcc til
 * at reagere på denne konstruktion! Men benyttes g++  får man
 * heldigvis en fejl på denne uheldige fremgangsmåde.
 */

#include <stdio.h>

int min_globale_variabel; /* ok, det bør enhver compiler acceptere. */

int min_globale_variabel; /* uha - burde udløse en warning! */
int min_globale_variabel; /* uha - burde udløse en warning! */
int min_globale_variabel; /* uha - burde udløse en warning! */

int main()
{
     printf("Værdien af min_globale_variabel er %d\n", min_globale_variabel);
     return 0;
}


