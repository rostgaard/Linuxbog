
/* kort02.c kortspil - repræsentation */

#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <errno.h>


enum farve_t {
    kloer, ruder, hjerter, spar, joker_roed,
    joker_sort, forkert_vaerdi
};

enum farve_t& operator++(enum farve_t& f)
{
    return f = enum farve_t(f + 1);
}

char *farve(enum farve_t kk)
{
    static char *names[] = {
        "klør", "ruder", "hjerter", "spar", "forkert kuloer"
    };

    if (kk >= forkert_vaerdi || kk < kloer)
        kk = forkert_vaerdi;
    return names[kk];
}

struct kort_t {
    unsigned tag:1;
    enum farve_t farve:3;
    unsigned rang:4;
    struct kort_t *next;
    char knavn[11];
};

int main(int argc, char *argv[])
{
    struct kort_t kort[53];
    enum farve_t kuloer;
    int j;

    for (kuloer = kloer; kuloer <= spar; ++kuloer) {
        for (j = 0; j < 13; ++j) {
            kort[kuloer * 13 + j].tag = 0;
            kort[kuloer * 13 + j].farve = kuloer;
            kort[kuloer * 13 + j].rang = j + 1;
            sprintf(kort[kuloer * 13 + j].knavn, "%s %d", farve(kuloer), j+1);
            kort[kuloer * 13 + j].next = NULL;
        }
    }
    kort[52].tag = 0;
    kort[52].farve = joker_sort;
    kort[52].rang = 15;
    kort[52].next = NULL;
    strcpy(kort[52].knavn,"joker");

    /* test om vi kan skrive nogle af dem ud! */
    for (j = 0; j < 13; ++j)
        printf("%s -- %s\n",kort[j].knavn, kort[40+j].knavn);
    return 0;
}


/* End of kort02.c */
