/* bogpris1.c -- en demonstration af objekt håndtering i C */

#include <stdio.h>
#include <stdlib.h>
#include <strings.h>

struct broek {
   int t;
   int d;
};

/* man skal i store programmer selv huske at free'e allokeret
 * memory, ellers har man en memory leak, d.v.s. at programmets
 * RAM forbrug stiger i løbet at køretiden, uden at man egentlig
 * får noget for pengene. Det er ikke en katastrofe. Fx. sendmail
 * og nameservere genstartes somme tider blot for at afværge memory leak
 * problemer.
 */

struct broek* new_broek(int tal, int divisor)
{
    struct broek *newbroek;
    newbroek = malloc(sizeof(struct broek));
    newbroek->t = tal;
    newbroek->d = divisor;
    return newbroek;
}

inline int min(int x1, int x2) {
    return x1<x2? x1 : x2;
}

int broek_multiply(struct broek *result, struct broek *b1, struct broek *b2)
{
    result->t = b1->t * b2->t;
    result->d = b1->d * b2->d;
    /* TODO if overflow ... return 0 */
    /* find fællesnævner / forkortelse af broek, skrives til sidst  */
    { int x;
      int maxx = min(result->t, result->d);
        for (x = 1; x <= maxx ; ++x) {
            if (result->t % x == 0 && result->d %x == 0) {
                result->t /= x;
                result->d /= x;
            }
        }
    }
    return 1;
}

char * broek_string(struct broek *b)
{
    static char strbroek[80];
    sprintf(strbroek,"%d/%d",b->t, b->d);
    return strbroek;
}

int main()
{
    struct broek andel;
    struct broek afgift;
    struct broek *b_bogpris;

    andel.t = 1;
    andel.d = 3;
    b_bogpris = new_broek(360,1);
    broek_multiply(&afgift,b_bogpris,&andel);
    free(b_bogpris);
    printf("Afgiften som broek er : %s\n",broek_string(&afgift));
    return 0;
}


