/*
 Clipper / xBase
 af Peter Stubbe <stubbe@bitnisse.dk>
 $Id$

 Programmet er skrevet til Harbour
 http://www.harbour-project.org

 Oversættelse:
  harbour hello.prg
  gcc -c hello.c -I/usr/include/harbour
  harbour-link hello.o

 Afvikling:
  ./hello
*/

procedure main()
  ? 'Hello, world!'
return
