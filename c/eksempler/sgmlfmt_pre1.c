/* sgmlfmt_pre1.c Forstadium til mini program, som checker
 * balancen i
 * sgml tags. I den nuværende skikkelse kan programmet erstatte 
 * alle "mindre-end" tegn med sgml-koden for dette, altså \&lt; - 
 * så det kan såmænd bruges til at filtrere C-programmer, der 
 * skal includeres i en sgml-tekst. */


#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <errno.h>
#include <error.h>

int status;
int eofile;                        /* global end of file */

#define MAXB 8000

char buf[MAXB];
int endbuf;
int bufindex;

int init();
int fillbuf();
int ch();
int gch();
int parse();

int main()
{
    if (init() == 0)
        return 1;
    while (!eofile) {
        if (ch() != '<')
            putchar(gch());
        else {
	    printf("&lt;");
	    gch(); /* discard character '<' */
        }
    }
    return 0;
}


int init()
{
    /* insert initialization of global vars here */
    return fillbuf();
}

int fillbuf()
{
    char *rv;

    if (!(rv = fgets(buf, MAXB, stdin)))
	strcpy(buf, "");
    endbuf = strlen(buf);
    bufindex = 0;
    return (int) rv;
}

/* ch() returnerer den næste character i input stream *men* læser
 * ikke, og ændrer ikke noget i den eksisterende buffer. Det
 * svarer til at spørge "Hvad er det næste input tegn, hvis vi nu
 * gad gå videre?!"
 */

int ch()
{
    return buf[bufindex];
}

int nch()
{
    return buf[bufindex + 1];
}



/* Hvis vi altid vil kunne se mere end én character fremefter, må
 * vi udskifte gch() og fillbuf() funktionerne, således at de
 * checker, hvor meget er der i bufferen, og hvis der er for få
 * (mindre end ønsket) skal de efterfylde bufferen og justere
 * pointere.
 * Det søde ved denne implementering er imidlertid, at vi altid
 * har én character lookahead (garanteret), men hvis vi ser på et
 * ord, kan vi se hele resten af ordet, fordi et ord ikke kan
 * krydse en liniedeling.
 */

/* gch() returnerer samme som ch() men flytter pointeren en plads
 * frem. Hvis vi ved fremadrykning rammer end of line (en
 * nul-byte) må vi fylde bufferen, så ch() næste gang har et tegn
 * at kigge på.
 */

int gch()
{
    int c;
    if (nch() == 0) {
	c = ch();
        if (!fillbuf()) {
            eofile = 1;		/* will take effect for the next char */
        }
	return c;
    }
    return buf[bufindex++];
}



