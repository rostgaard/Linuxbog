

static char *keystring = "Under træerne var der stille og roligt.";
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
   if (inpchar < ' ') inpchar = '.';
   if (inpchar > 126) inpchar = '~';
   return (inpchar + *mv++) % 93 + 33;
}


