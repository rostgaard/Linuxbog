/* tagbal01.c Minimalt program til genkendelse af tags. */

#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <ctype.h>
#include <errno.h>
#include <error.h>

#define INTAG  257
#define OUTTAG 258
#define EXIT_FAILURE 255

int status;
int eofile;			/* global end of file */

#define MAXB 8000
#define SMALLB 800

char buf[MAXB];
char *bufp;
int endbuf;
int lineno;
int indent;

int init();
int fillbuf();
int ch();
int gch();
int nch();
int parse_level1();
int match(const char *lit);
int eat(const char *lit);
void parse_error(char *erms);
void blanks();
void margin();
int getword();
void putword();
int anytag(char *tagbuf);
int have_endtag(const char *litteral);


int main()
{
	if (init() == 0)
		return 1;
	while (!eofile) {
		blanks();
		if (eofile)
			return 0;
		if (ch() != '<')
			parse_error("Text outside tags");
		else
			if (!parse_level1())
				parse_error("Misplaced end-tag\n");
	}
	printf("\n");
	return 0;
}


/************************************************************************
               int parse_level(void) is the main loop
 ************************************************************************/
/*
   parse_level1() is the main loop for handling tags. As the name 
   indicates there could be more levels here, allowing for rules
   for which tags must come before others. For example, in level1:
   get_chapter(); // or die! 

   Then, in subsequent layers, there could be special tag-handling: 
   if (paratag()) do_para();
   else if (emphasis()) no_margin(); 
   else if (bold()) no_margin(); etc etc.  
   
   The blanks() call are strategically placed, but at present I
   am not sure whether the logic could be more stringent.
 */

#define MAXT 1000

int parse_level1()
{
	char tagname[MAXT];
	while (!eofile) {
		if (!anytag(tagname)) {
			return 0;
		}
		while (!eofile) {
			while (getword())
				putword();
			if (have_endtag(tagname))
				break;
			(void) parse_level1();  /* nested tags */
		}
		blanks();
	}
	return 1;
}


/************************************************
 * Anytag() accepts any tag and returns the
 * tags typename in tagbuf (max MAXT).
 * TODO: handle minor errors by returning 0
 ************************************************
 */

int anytag(char *tagbuf)
{
	char *tagp;

	blanks();
	if (ch()!='<')
		return 0;
	if (nch()=='/') /* TODO: nicer handling space before '/' */
		return 0;
	gch();
	blanks();
	if (ch() == '/')
		return 0;
	tagp = tagbuf;
	while (isalnum(ch()))
		*tagp++ = gch();
	*tagp = 0;
	margin();
	printf("<%s", tagbuf);
	indent += 2;
	while (ch() != '>' && !eofile)
		putchar(gch()); /* TODO: squeeze white and format */
	if (eofile)
		parse_error("missing \">\"\n");
	putchar(gch());         /* copy the ">" */
	return 1;
}


/* need_endtag looks for an end-tag and dies if not found. */

int have_endtag(const char *lit)
{
	char errms[SMALLB];
	char endtag[SMALLB];
	blanks();
        if (ch()!='<' || nch() != '/') /* could use strcmp()? */
                return 0;
	sprintf(endtag, "</%s>", lit);
	gch(); /* eat '<' */
	if (ch() != '/') {
		strcpy(errms, "Unbalance, need ");
		strcat(errms, endtag);
		parse_error(errms);
	}
	gch();			/* eat '/' */
	if (!match(lit)) {
		sprintf(errms, "Need endtag for :%s:", lit);
		parse_error(errms);
	}
	indent -= 2;
	margin();
	printf("%s", endtag);
	blanks();
	if (ch() != '>')
		parse_error("end-tag missing '>'");
	gch();
	return 1;
}


void parse_error(char *erms)
{
	char ebuf[MAXB];
	fflush(stdout);
	fprintf(stderr, "\nError parsing line %d: %s\n", lineno, erms);
	strcpy(ebuf, buf);
	fprintf(stderr, "%s\n", ebuf);
	fprintf(stderr, "%*s\n", bufp - buf + 1, "^");
	exit(EXIT_FAILURE);
}


int init()
{
	/* do any initializing of globvars */
	return fillbuf();
}


int fillbuf()
{
	char *rv;

	if (!(rv = fgets(buf, MAXB, stdin))) {
		strcpy(buf, "");
	} else
		++lineno;
	endbuf = strlen(buf);
	bufp = buf;
	return (int) rv;
}


int ch()
{
	return *bufp;
}


int nch()
{
	return *(bufp + 1);
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
			eofile = 1;	/* TODO should not take effect for the next char */
		}
		return c;
	}
	return *bufp++;
}


int match(const char *lit)
{
	int slen;

	slen = strlen(lit);
	if (!slen)
		return 0;
	if (strncasecmp(lit, bufp, slen) == 0) {
		bufp += slen;
		return slen;
	}
	return 0;
}



void blanks()
{
	while (isspace(ch()))
		gch();
}


static char wordbuffer[MAXB];
static char *w;
static int column;

int getword()
{
	w = wordbuffer;
	blanks();
	while (!isspace(ch()) && !eofile) {
		if (ch() == '<') {
			return 0;
		}
		*w++ = gch();
	}
	*w = 0;
	return (w - wordbuffer);
}


void putword()
{
	column += w - wordbuffer + 1;
	if (column > 78)
		margin();
	else {
		putchar(' ');
		++column;
	}
	w = wordbuffer;
	while (*w)
		putchar(*w++);
}


void margin()
{
	column=indent;
	if (indent)
		printf("\n%*s", indent, " ");
	else
		printf("\n");
}



