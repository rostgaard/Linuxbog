/* modular programmering - fil nr. 1, kryptio.c */
/* main læser fra tastatur (eller omdirigeret fil)
 * og skriver det krypterede bogstav ud på skærmen.
 */

#include <stdio.h>
main()
{
    int c;
    while ( (c = getchar()) != EOF) {
        c = krypter(c);
        putchar(c);
    }
}


