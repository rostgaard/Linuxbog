
int printf();

main()
{
    int x = 0xf0f0f0f0;

    /* udskriv x's bitmønster: */
    { 
        int i = 0;
        char numstr[35];           /* character array til resultat string */
        strcpy(numstr,"b:");       /* initialiser local var.*/
        numstr[34] = 0;
        while (i++ < 32) {                  /* i er under testen 0 til 31 */
            numstr[34-i] = (x & 1) + '0';   /* undersøg én bit af gangen */
            x = x>>1;                       /* shift integeren */
        }
        printf("%s\n",numstr);
    }   
}

