/*
 * hello2.c
 * af Torkil Zachariassen <torkil@flug.fo>
 * $Id$
 *
 * Dette er den rettede version af det
 * originale "hello world" program.
 * Det kan oversættes med gcc uden
 * at der kommer fejl eller advarsler.
 *
 * Oversætter: gcc -o hello2 hello2.c
 *
 * Afvikling: ./hello2
*/

#include <stdio.h>

int main(void)
{
	printf("Hello, world!\n");
	return 0;
}
