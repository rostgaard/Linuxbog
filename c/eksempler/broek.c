/* broek.c - se efter, om man får præcise resultater med en
 * decimalbroek! */

#include <stdio.h>


main()
{
	double andel;
	int bogpris;
	
	andel = 1.0 / 3.0;
	bogpris = 360;
	printf("En trediedel af 360 er ... %f\n",andel * bogpris);
	return 0;
}

