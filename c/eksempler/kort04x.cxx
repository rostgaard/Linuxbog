
/* kort04x.cxx kortspil repræsentation, kortene blandes */
/* ved at anbringe dem i en liste (linked liste)     */
/* blande - rutinen laves som en service funktion    */
/* display rutinen skilles ud fra main.              */


#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <stdlib.h>
#include <time.h>
#include <errno.h>
#include <list>


enum farve_t { kloer, ruder, hjerter, spar };

char *farve(enum farve_t kk)
{
    static char *names[] = {
	"klør", "ruder", "hjerter", "spar", "forkert kuloer"
    };

    int xk = kk;
    if (kk > spar || kk < kloer)
	xk = 4;
    return names[xk];
}

enum farve_t& operator++(enum farve_t& f)
{
    return f = farve_t(f+1);
}

struct kort_t {
    unsigned tag:1;
    unsigned farve:2;
    unsigned rang:4;
    struct kort_t *next;
    char knavn[11];
};

#define MAXK 52

/* global list */
using namespace std;
list <kort_t> kortbunke;

/* prototyper på vores to service funktioner */

void show_all(struct kort_t *k);
void bland(struct kort_t *k, int lim, list<kort_t> bunke);
void show_kortbunke(struct kort_t *k);
void show_kortliste();


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

    /* test om vi kan skrive dem ud! */
    // show_all(kort);
    {
	bland(kort, MAXK, kortbunke);
	// show_kortbunke(bunke);
	show_kortliste();
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

void bland(struct kort_t *k, int lim, list<kort_t> kl )
{
    int j, count;
    int seen_last;

    for (j = 0; j < lim; ++j)
        (k+j)->tag = 0;
    srand(time(NULL));
    count = 0;
    while (count < MAXK) {
        j = rand() % MAXK;
        if ((k+j)->tag || j==seen_last)
	    continue;
	++count;
	seen_last = j;
	(k+j)->tag = 1;
        kortbunke.push_front(k[j]);
    }
}


void show_kortbunke(struct kort_t *k)
{
    while (k) {
	show1kort(k);
	k = k->next;
    }
}

void show_kortliste()
{
    list<kort_t>::const_iterator kl;
    kl = kortbunke.begin();
    while (kl != kortbunke.end()) {
        printf("%s\n", kl->knavn);
	++kl;
    }
}


/* End of kort04x.cxx */

