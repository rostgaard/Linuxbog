
/* afkrypt2.c - afkryptering med 31 som '\n'    */
/* Læser fra stdin og skriver til stdout.
 * matcher krypter2.c
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
   /* return (inpchar + *mv++) % 96 + 31; */
   /* return ((krypchar-31) - *mv++ + 96); */
   m = inpchar - 31;
   dc = m + 96 - *mv++;
   // printf("\nkrypted: %c, afkrypt: %d\n",inpchar,dc);
   while (dc < 31)
       dc += 96;
   while (dc > 126)
       dc -= 96;
   if (dc > 31 && dc <= 126)
       return dc;
   else if (dc == 31) 
       return '\n';
   fprintf(stderr, "Error!\n");
   exit(224);
   return -1;
}


