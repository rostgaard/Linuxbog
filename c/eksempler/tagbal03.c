/* tagbal03.c Program til formatering/kontrol af docBook sgml. */
/* programmet er en hasteudvidelse af tagbal02, således at
 * programmet kan klare <xref>, <doctype> og <book> tags på en
 * passende måde. Der er stadig ikke check på hvilke tags, der må
 * forekomme inden i andre tags. Programmet er ikke lavet til at
 * læse en docbook specification og arbejde ud fra den, det er
 * blot en grundlæggende demonstration af rekursion som værktøj
 * til at checke matchende tags.
 */

#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <ctype.h>
#include <errno.h>
#include <error.h>

#define INTAG  257
#define OUTTAG 258
#define PARSE_FAILURE 255

int nesting;                    /* hvilket tag niveau er vi på */
int eofile;			/* global end of file */

#define MAXB 8000
#define SMALLB 800

char buf[MAXB];
char *bufp;
int endbuf;
int lineno;
int indent;
int column;
int maxcol = 78;		/* TODO command line parm */

int init();
int fillbuf();
int ch();
int gch();
int nch();
int parse_level1();
int anytag(char *tagbuf);
int have_endtag(const char *litteral);
void parse_error(char *erms);
int comment(void);
int xref(void);
int doctype(void);
int programlisting(char *t);
int litt(char *t);
int book(char *t);
int match(const char *lit);
void blanks();
void margin();
int getword();
void putword();
int do_litteral(char *tok);


int main()
{
	if (init() == 0)
		return 1;
	while (!eofile) {
		blanks();
		if (eofile)
			return 0;
		if (!parse_level1())
			parse_error("Misplaced tag, end-tag or text-data\n");
	}
	if (nesting)
		parse_error("Missing end-tag\n");
	printf("\n");
	return 0;
}


/************************************************************************
               int parse_level(void) is the main loop
 ************************************************************************/
/*
   parse_level1() er over-løkken for programmet. Som navnet
   antyder kunne der være flere levels. Det ville muliggøre
   regler for, hvilke tags der må komme inde mellem andre tags.
   Fx. i level1: Get_Chapter(); // eller dø!

   Speciel tag-handling foregår i fx. comment(), som blot
   formaterer output og fortsætter indtil kommentar - slut tegnet.
   Kommentarer optræder jo ikke parvis som <tag> </tag>.
   
   blanks() call er placeret strategisk - jeg tror der er et par
   af dem, som er overflødige. Det er defensiv programmering! De
   skader ikke, hvis der er for mange, men det er fatalt, hvis
   der mangler et kald til blanks()!
   nesting værdien styres her (og *kun* her). Den er desværre
   nødvendig, fordi vi ellers ikke fanger manglende tags ved 
   end-of-file.
 */

#define MAXT 80

int parse_level1()
{
	char tagname[MAXT];
	while (!eofile) {
		blanks();
		if (comment() || xref() || doctype())
			continue;
		if (programlisting(tagname) || litt(tagname)
		    || book(tagname))
			(void) do_litteral(tagname);
		else if (!anytag(tagname))
			return 0;
		++nesting;
		while (!eofile) {
			while (getword())
				putword();
			if (have_endtag(tagname)) {
				--nesting;
				break;
			}
			(void) parse_level1();	/* nested tags */
		}
		blanks();
	}
	return 1;
}

int comment(void)
{
	blanks();
	if (match("<!--")) {
		margin();
		printf("<!--");
		while (!eofile) {
			if (ch() != '-') {
				putchar(gch());
				++column;
			}
			else if (match("-->")) {
				column += printf("-->");
				blanks();
				return 1;
			}
			else 
				putchar(gch());
				++column;
		}
	}
	return 0;
}

int xref()
{
	if (!match("<xref"))
		return 0;
	if (isalnum(ch()))
		parse_error("xref tag format ");
	margin();
	column += printf("%s","<xref");
	while (ch() != '>') {
		if (ch() == '\n') {
			gch();
			continue;
		}
		putchar(gch());    /* tag indhold bogstavtro */
		if (++column > maxcol)
			margin();
	}
	putchar(gch());		   /* medtag slut-vinkel */
	return 1;
}

int doctype(void)
{
	if (!match("<!doctype"))
		return 0;
	/* kør alt igennem til end of doctype - der må vist kun
	 * være een
	 */
	margin();
	column += printf("<!doctype");
	while (ch() != '[') {
		if (ch()=='\n') {
			gch();
			continue;
		}
		putchar(gch());
		if (++column > maxcol)
			margin();
	}
	putchar(gch());           /* skriv start firk.parent.'[' */
	while (ch() != ']')
		putchar(gch());
	putchar(gch());
	while (ch() != '>') {
		if (isprint(ch()))
			parse_error("Illegal character before '>'");
		putchar(gch());
	}
	putchar(gch());
	return 1;
}

/************************************************
 * Anytag() accepterer hvilken som helst tag og 
 * returnerer typenavnet i en buffer, max MAXT.
 ************************************************
 */

int anytag(char *tagbuf)
{
	char *tagp;
        int i;

	blanks();
	if (ch()!='<') 
		return 0;
	if (nch()=='/')         /* TODO: hvad hvis der er space før '/' */
		return 0;
	gch();
	blanks();
	if (ch() == '/')
		return 0;
	tagp = tagbuf;
        i = 0;
	while (isalnum(ch()) && ++i < MAXT)
		*tagp++ = gch();
	*tagp = 0;
	margin();
	column += printf("<%s", tagbuf);
	indent += 2;
	while (ch() != '>' && !eofile)
		putchar(gch()); /* TODO: squeeze mellemrums-tegn,formatering */
	if (eofile)
		parse_error("missing \">\"\n");
	putchar(gch());         /* copy the ">" */
	++column;               /* TODO: count tag-attribut len */
	return 1;
}


int have_endtag(const char *lit)
{
	char errms[SMALLB];
	char tagtxt[SMALLB];
	/* blanks() may be redundant if have_endtag always is called
	   after getword returns false. */
	blanks();
	if (ch()!='<' || nch() != '/') /* could use strcmp()? */
		return 0;
	sprintf(tagtxt, "</%s>", lit);
	gch(); /* eat '<' */
	if (ch() != '/') {
		strcpy(errms, "Unbalance, need ");
		strcat(errms, tagtxt);
		parse_error(errms);
	}
	gch();			/* eat '/' */
	if (!match(lit)) {
		sprintf(errms, "Need endtag for >>%s<<", lit);
		parse_error(errms);
	}
	indent -= 2;
	margin();
	printf("%s", tagtxt);
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
	strncpy(ebuf, buf, MAXB-1);
	ebuf[MAXB-1] = 0;
	fprintf(stderr, "%s\n", ebuf);
	fprintf(stderr, "%*s\n", bufp - buf + 1, "^");
	exit(PARSE_FAILURE);
}


int programlisting(char *t)
{
	int c;
	blanks();
	if (!match("<programlisting"))	/*TODO: accept space after '<' */
		return 0;
	margin();
	indent += 2;
	printf("<programlisting");
	strcpy(t,"programlisting");
	while (!eofile) {
		putchar(c=gch());
	       	if (c == '>')
			return 1;
	}
	return 0;
}


int litt(char *t)
{
	int c;
	blanks();
	if (!match("<litteral"))	/* TODO see above */
		return 0;
	margin();
	indent += 2;
	printf("<litteral");
	strcpy(t,"litteral");
	while (!eofile) {
		putchar(c=gch());
		if (c=='>')
			return 1;
	}
	return 0;
}

int book(char *t)
{
	int c;
	blanks();
	if (!match("<book"))
		return 0;
	margin();
	indent += 2;
	column += printf("<book");
	strcpy(t,"book");
	while (!eofile) {
		putchar(c=gch());
		if (c=='>')
			return 1;
	}
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

int gch()
{
	int c;
	if (nch() == 0) {
		c = ch();
		if (!fillbuf()) {
			eofile = 1;	/* TODO burde ikke være synlig førend
					   brugeren læser næste gang */
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
	register int c;
	while (isspace(c = ch()))
		gch();
}


static char wordbuffer[MAXB];
static char *w;

int getword()
{
	w = wordbuffer;
	blanks();
	while (!isspace(ch()) && !eofile) {
		if (ch() == '<') {
			break;
		}
		*w++ = gch();
	}
	*w = 0;
	return (w - wordbuffer);
}

void outchar(int writeme)
{
	putchar(writeme);
	++column;
}


/* putword formaterer tekst-data, ganske primitivt, ved at
 * checke, om ordet vil gå ud over kolonne 78, når vi skriver
 * det. TODO: Hvis et ord er længere end maxkol tegn, så skal det
 * skrives alligevel!
 */

void putword()
{
	char *u;
	u = wordbuffer;
	if (column + w - wordbuffer + 1 > maxcol)   /* plads nok? */
		margin();
	else 
		if (!ispunct(*u))               /* skriv mellemrum og så ordet */
			outchar(' ');
	while (*u)
		outchar(*u++);
}

int last;

void margin()
{
	if (indent < 0)
		indent = -indent;
	column=indent;
	if (!last && last != '\n') {
		printf("\n");
	}
	last = 0;
	if (indent)
		printf("%*s", indent, " ");
}


int do_litteral(char *tagtok)
{
	while (!eofile && ch() != '<')
		putchar(last = gch());
	return 1;
}


