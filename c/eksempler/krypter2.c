/* file krypter2.c - brugbar krypterings-funktion version 2.
 */
/* denne version af krypterings funktionen behandler
 * linieskift bedre. 
 * Output burde kun være, som i version 1, characters med værdier
 * fra 33 til 126.  Det er 93 værdier, men vi vil gerne have
 * repræsenteret 95 værdier, nemlig newline (10) og space (32)
 * samt 33-126.  Desuden vil vi ikke have, at linieskift
 * forbliver som i originalteksten, og spaces må heller ikke
 * forblive spaces.
 *
 * Hvis ikke vi vil lave om på selve programflowet, hvor en
 * oprindelig character mappes til en krypteret character (det
 * vil sige, hvis vi vil fastholde vores funktions-opdeling) så
 * må vi altså skaffe 2 printable characters mere eller lade
 * nogle andre tegn udgå (fx. # og ` kunne være kandidater.)
 * 
 * Men i denne version vælger vi alligevel at bruge space,
 * newline mapper vi til character 31, så må vi se, hvordan det
 * går ...
 */

static char *keystring = "Under traeerne var der stille og roligt.";
static int inuse;
static char *mv;
static int keylen;

int krypter(int inpchar)
{
   if (!inuse) {
       inuse = 1;
       mv = keystring;
       keylen = strlen(keystring);
   }
   if (mv - keystring > keylen)
       mv = keystring;
   if (inpchar < ' ') {
       if (inpchar == '\n')
          inpchar = 31;
       else
          inpchar = '.';
   } else if (inpchar > 126)
       inpchar = '.';
   return (inpchar + *mv++) % 96 + 31;
}


