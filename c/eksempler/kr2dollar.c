
/* file dollar3b.c - for lettere at holde styr på, hvilke
 * eksempelfiler, der hører sammen.
 * kr2dollar, function som får kroner og returnerer dollar. */

static double kurs = 8.65; /* skulle slå den op på nettet! */

double kr2dollar(double k)
{
    return k / kurs;
}


