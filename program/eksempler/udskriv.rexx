#!/usr/bin/rexx
/*
 af Peter Stubbe <stubbe@bitnisse.dk>
 $Id$
 Programmet er skrevet til Regina Rexx
 http://www.radiks.net/~jmthomas/regina/Regina%20REXX.htm

 Afvikling
  ./udskriv.rexx [fil]+
*/

parse arg args
parse value args with fil rest
do forever while fil\=""
  args=rest
  if lines(fil)==0 then do
    say 'Filen' fil 'findes ikke!'
  end
  else do
    lnr=0
    do while lines(fil)>0
      lin=linein(fil)
      lnr=lnr+1
      say lnr lin
    end
  end
  parse value args with fil rest
end
do forever while slut\="Q"
  parse pull slut
end
