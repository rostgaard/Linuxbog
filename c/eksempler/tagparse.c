/* tagpars.c Minimalt program til genkendelse af tags. */

#include <stdio.h>
#include <string.h>
#include <strings.h>

#define INTAG  257
#define OUTTAG 258
int status;
int eof;                        /* global end of file */

#define MAXB 8000

char buf[MAXB];
int endbuf;
int bufindex;

int init();
int fillbuf();
int ch();
int gch();

int main()
{
    int c;

    if (init() == 0)
        return 1;
    while (!eof && ch() != '<')
        putchar(gch());

    return 0;
}

int init()
{
    /* do any initializing of globvars */
    return fillbuf();
}

int fillbuf()
{
    char *rv;
    int tlen;
    char tmpbuf[MAXB];

    /* til at begynde med er status 0 altså != INTAG */
    if (status == INTAG)
        while ((rv = fgets(tmpbuf, MAXB, stdin)) != NULL) {
            if ((tlen = strlen(tmpbuf)) > (MAXB - endbuf)) {
                fprintf(stderr, "Tagparse, fatal: buffer full\n");
                exit(255);
            }
            strcpy(&buf[endbuf], tmpbuf);
            endbuf += tlen;
            if (index(&buf[endbuf], '>'))
                break;
        }
    /* end-while */ 
    else {
        rv = fgets(buf, MAXB, stdin);
        endbuf = strlen(buf);
        bufindex = 0;
    }
    if (rv == NULL) {
        eof = 1;
        return 0;
    } else
        return 1;
}

int ch()
{
    return buf[bufindex];
}

int gch()
{
    if (ch() == 0)
        fillbuf();
    return buf[bufindex++];
}
