R: af Peter Stubbe <stubbe@bitnisse.dk>
 : $Id$
 : Programmet er skrevet til RPilot
 : http://rpilot.sourceforge.net/
 :
 : Afvikling:
 :  rpilot udskriv.p

T: Hvilken fil skal listes?
A: $fil
C: $kommando = [ -e $fil ]
S: $kommando
J(#retcode=0): udskriv
T: Filen $fil findes ikke!
J: slut
*udskriv
C: $kommando = cat -n $fil
S: $kommando
*slut
A:
M: Q
J(#matched=0): slut
