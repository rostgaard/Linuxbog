
/* sektioner.c - vis en adresse fra BUNDEN og TOPPEN af memory.
 * benytter en static til at vise en adresse fra bunden
 * og en lokal variabel til at vise hvor stakken begynder
 * og endelig en malloc at vise heapen.
 */

#include <stdio.h>
#include <stdlib.h>
static int var_i_datasektion;
static char * message1 = "Dette er en constant string\n";

int main()
{
    int lokal_var;
    char *heap_ptr;

    printf("message1 constant har adresse %u\n", message1);
    printf("var_i_datasektion har adresse %u\n", &var_i_datasektion);
    printf("lokal_var         har adresse %u\n", &lokal_var);
    
    heap_ptr = malloc(200);
    printf("heap_ptr          har value   %u\n", heap_ptr);

    return 0;
}


static char *keystring = "Under traeerne var der stille og roligt.";
static int inuse;
static char *mv;
static int keylen;

int afkrypter(int inpchar)
{
   int m, dc;
   if (!inuse) {
       inuse = 1;
       mv = keystring;
       keylen = strlen(keystring);
   }
   if (mv - keystring > keylen)
       mv = keystring;
   /* return (inpchar + *mv++) % 93 + 33; */
   /* return ((krypchar-33) - *mv++ + 93); */
   m = inpchar - 33;
   dc = m + 93 - *mv++;
   if (dc > 31 && dc < 126)
       return dc;
   else if (dc < 32) 
       return dc + 93;
   else if (dc > 125) return dc - 93;
   fprintf(stderr, "Error!\n");
   exit(224);
   return -1;
}


