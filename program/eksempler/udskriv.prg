/*
 Clipper / xBase
 af Peter Stubbe <stubbe@bitnisse.dk>
 $Id$

 Programmet er krevet til Harbour
 http://www.harbour-project.org

 Oversættelse:
  harbour udskriv.prg
  gcc -c udskriv.c -I/usr/include/harbour
  harbour-link udskriv.o

 Afvikling:
  ./udskriv [fil]+
*/

procedure main()
  local fil, fnr, lin, nl, c, lnr

  c:=space(1)
  lin:=space(300)
  nl:=hb_osnewline()

  for fnr:=1 to hb_argc()
    if file(hb_argv(fnr))
      fil:=fopen(hb_argv(fnr),0) 
      lnr:=1
      lin:=''
      while fread(fil, @c,1)=1
        if c=nl
          ? lnr, lin
          lnr:=lnr+1
          lin:=''
        else
          lin:=lin+c
        endif
      end
      fclose(fil)
    else
      ? 'Filen', hb_argv(fnr), 'findes ikke!'
    endif
  next

return
