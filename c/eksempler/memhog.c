/* memhog.c, program som allokerer 20MB RAM og venter */
#include <stdio.h>
#include <stdlib.h>

typedef struct dummy OBJEKT;
main()
{
	OBJEKT *p2objekt;
	p2objekt = malloc(20 * 1024 * 1024);
	if (p2objekt == NULL)
		printf("Ikke nok memory\n");
	else
		printf("Har allokeret 20MB memory\n");
	getchar();
	return 0;
}


