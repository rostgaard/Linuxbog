

/* kort04.c kortspil repræsentation, kortene blandes */
/* ved at anbringe dem i en liste (linked liste)     */
/* blande - rutinen laves som en service funktion    */
/* display rutinen skilles ud fra main.              */


#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <stdlib.h>
#include <time.h>
#include <errno.h>


enum farve_t { kloer, ruder, hjerter, spar };

char *farve(enum farve_t kk)
{
    static char *names[] = {
	"klør", "ruder", "hjerter", "spar", "forkert kuloer"
    };

    if (kk > spar || kk < kloer)
	kk = 4;
    return names[kk];
}

struct kort_t {
    int tag:1;
    int farve:2;
    int rang:4;
    struct kort_t *next;
    char knavn[11];
};

#define MAXK 53

/* prototyper på vores to service funktioner */

void show_all(struct kort_t *k);
void bland(struct kort_t *k, int lim, struct kort_t **first);
void show_kortbunke(struct kort_t *k);

int main(int argc, char *argv[])
{
    struct kort_t kort[MAXK];
    enum farve_t kuloer;
    int j;

    for (kuloer = kloer; kuloer <= spar; ++kuloer) {
	for (j = 0; j < 13; ++j) {
	    kort[kuloer * 13 + j].tag = 0;
	    kort[kuloer * 13 + j].farve = kuloer;
	    kort[kuloer * 13 + j].rang = j + 1;
	    sprintf(kort[kuloer * 13 + j].knavn, "%s %d", farve(kuloer),
		    j + 1);
	    kort[kuloer * 13 + j].next = NULL;
	}
    }
    kort[52].tag = 0;
    kort[52].farve = 0;
    kort[52].rang = 15;
    kort[52].next = NULL;
    strcpy(kort[52].knavn, "joker");

    /* test om vi kan skrive dem ud! */
    // show_all(kort);
    {
	struct kort_t *bunke;
	bland(kort, MAXK, &bunke);
	show_kortbunke(bunke);
    }
    return 0;
}

void show1kort(struct kort_t *k)
{
    printf("%11s \n", k->knavn);
}

void show_all(struct kort_t *k)
{
    int j;
    for (j = 0; j < 13; ++j)
	printf("%11s -- %11s --%11s -- %11s\n", (k + j)->knavn,
	       (k + 13 + j)->knavn, (k + 26 + j)->knavn,
	       (k + 39 + j)->knavn);
}

void bland(struct kort_t *k, int lim, struct kort_t **first)
{
    int j, count;
    struct kort_t *prev;

    for (j = 0; j < lim; ++j)
        (k+j)->next = 0;
    srand(time(NULL));
    // printf("rand: %d\n", rand());
    // printf("rand: %d\n", rand()%52);
    j = rand() % 52;
    prev = *first = k+j;
    count = 0;
    while (count < 51) {
        j = rand() % 52;
        if ((k+j)->next || k+j==prev) /* obs: her går noget galt
	måske får vi p.t. slet ikke de sidste kort med - den står
	og looper uendelig længe. Sidst tilf. || k+j == prev */
	    continue;
	++count;
	prev->next = k+j;
	prev = prev->next;
    }
}

void show_kortbunke(struct kort_t *k)
{
    while (k) {
	show1kort(k);
	k = k->next;
    }
}

/* End of kort04.c */
