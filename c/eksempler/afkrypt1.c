
/* modular programmering - fil nr. 1, kryptio.c */
/* main læser fra tastatur (eller omdirigeret fil)
 * og skriver det krypterede bogstav ud på skærmen.
 */

#include <stdio.h>
int afkrypter(int);

int main()
{
    int c;
    while ( (c = getchar()) != EOF) {
        c = afkrypter(c);
        putchar(c);
    }
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


