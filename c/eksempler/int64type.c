
#include <stdio.h>

typedef long long int _int64;

int main()
{
    _int64 big;

    big = 1;
    while (big <<= 1)
        printf("Vores 64 bit int er nu %Ld\n", big);

    /* 9,223,372,036,854,775,808 */
    big = 9223372036854775807;
    printf("Vores 64 bit int er nu %Ld\n", big);
    ++big;
    printf("Vores 64 bit int er nu %Ld\n", big);
    return 0;
}
