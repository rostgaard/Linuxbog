/* 
  udskriv.c
  af Frank Damgaard <frank@sslug.dk>
  $Id$

  Oversæt med: gcc -Wall udskriv.c -o udskriv

  Afvikling: ./udskriv filnavn [filnavn ...]

*/
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <errno.h>

/* Vent på at der bliver tastet et tegn */
void wait_for(char *flere_tegn) {
  int tegn;
  while ( (tegn=getchar())!=EOF ) {
    if ( strchr(flere_tegn,tegn) ) break;
  }
}

int print_file(char *filnavn, FILE *udfil) {
  FILE *infil;
  int  tegn;
  int  linienummer=0;
  int  nylinie=1;

  printf("[%s]\n",filnavn);
  if ( (infil=fopen(filnavn,"r"))==NULL ) {
    printf("%s eksisterer ikke (%d: %s)\n",filnavn,errno,strerror(errno));
    return -1;
  }

  while ( (tegn=fgetc(infil))!=EOF ) {
    if (nylinie) {
      fprintf(udfil,"%5d ",++linienummer);
      nylinie=0;
    }
    if (isprint(tegn)) fputc(tegn,udfil);
    else if ( tegn == '\n') {
      fputc('\n',udfil);
      nylinie=1;
    } 
    else fputc('¿',udfil);
  }
  if (!nylinie) fputc('\n',udfil);
  fclose(infil);
  wait_for("QqNn");
  return 0;
}

int main ( int argc, char **argv) {
	/* Udskriv alle filer på kommando-linien */
  for (argv++ ; --argc; argv++) {
    if (print_file(*argv, stdout)<0) break;
  }
	/* Afslut med fejl-kode 0 */
  return 0;
}
