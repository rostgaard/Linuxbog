
/* kort03.c kortspil - repræsentation */
/* Næsten som kort02.c, men uden jokere. */
/* Skriv alle kort-navne ud */

#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <errno.h>


enum farve_t {
    kloer, ruder, hjerter, spar
};

char *farve(enum farve_t kk)
{
    static char *names[] = { 
        "klør", "ruder", "hjerter", "spar"
    };
    return names[kk];  /* callers ansvar at kk er indenfor grænser */
}

struct kort_t {
    unsigned tag:1;
    enum farve_t farve:2;
    unsigned rang:4;
    struct kort_t *next;
    char knavn[11];
};

int main(int argc, char *argv[])
{
    struct kort_t kort[52];
    enum farve_t kuloer;
    int j;

    for (kuloer = kloer; kuloer <= spar; ++kuloer) {
	for (j = 0; j < 13; ++j) {
	    kort[kuloer*13+j].tag = 0;
	    kort[kuloer*13+j].farve = kuloer;
	    kort[kuloer*13+j].rang = j+1;
	    sprintf(kort[kuloer*13+j].knavn,"%s %2d", farve(kuloer), j+1);
	    kort[kuloer*13+j].next = NULL;
	}
    }

    /* test om vi kan skrive dem ud! */
    for (j = 0; j < 13; ++j)
        printf("%11s -- %11s --%11s -- %11s\n",kort[j].knavn, 
	kort[13+j].knavn, kort[26+j].knavn, kort[39+j].knavn);
    return 0;
}


/* End of kort03.c */

