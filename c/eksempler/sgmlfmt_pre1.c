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


int ch()
{
    return buf[bufindex];
}

int nch()
{
    return buf[bufindex + 1];
}



/* For longer buffer lookahead we will need to change the gch()
 * and fillbuf() functions so they will work like getc(fp) macro,
 * that is: 
 * 1) check for number of characters left in buffer
 * 2) if near end of buffer, move unfetched chars to beginning of
 *    buffer, reset bufpointer and
 * 3) append newly read chars to string in buffer.
 * the cute thing about this implementation is that we always
 * have one character lookahead (guaranteed) but normally we will
 * have a newline char as the last before zero, which will be our
 * guarantee that if we have a word in the buffer it is the whole
 * word.
 */

/* ch() and gch() must always return same thing, so here we need
 * the nch() function to tell us if we are getting near end of
 * line. Otherwise, gch() simply returns same as ch but advances
 * the buffer index (could have been a pointer).
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



