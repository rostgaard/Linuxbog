\ af Peter Stubbe <stubbe@bitnisse.dk>
\ $Id$

\ Programmet er skrevet til FORTH-dialekten bigFORTH
\ http://bigforth.sourceforge.net
\
\ Afvikling:
\  bigforth udskriv.fs fil+

variable linlen
variable fid
create lin 258 allot

: lsfl		( n1 n2 -- )
  begin
    2dup		( n1 n2 -- n1 n2 n1 n2 )
    <			( n1 n2 n1 n2 -- n1 n2 flag )
  while			( n1 n2 flag -- n1 n2 )
    0			( n1 n2 -- n1 n2 n3 )
    2 pick		( n1 n2 n3 -- n1 n2 n3 n1 )
    arg			( n1 n2 n3 n1 -- n1 n2 n3  c-addr u )
    r/o			( n1 n2 n3 c-addr u -- n1 n2 n3 c-addr u fam )
    open-file		( n1 n2 n3 c-addr u fam -- n1 n2 n3 fileid ior )
    if			( n1 n2 n3 fileid ior -- n1 n2 n3 fileid )
      2drop		( n1 n2 n3 fileid -- n1 n2 )
      ." Kan ikke åbne filen "
      over		( n1 n2 -- n1 n2 n1 )
      arg		( n1 n2 n1 -- n1 n2 c-addr u )
      type		( n1 n2 c-addr u - n1 n2 )
      ." !" cr
    else
      fid !		( n1 n2 n3 fileid -- n1 n2 n3 )
      begin
        fid @		( n1 n2 n3 -- n1 n2 n3 fileid )
        lin linlen	( n1 n2 n3 fileid -- n1 n2 n3 fileid c-addr u )
        rot		( n1 n2 n3 fileid c-addr u -- n1 n2 n3 c-addr u fileid )
        read-line	( n1 n2 n3 c-addr u1 fileid -- n1 n2 n3 u2 flag ior )
        drop		( n1 n2 n3 u flag ior -- n1 n2 n3 u2 flag )
      while		( n1 n2 n3 u flag -- n1 n2 n3 u )
        swap		( n1 n2 n3 u -- n1 n2 u n3 )
        1+		( n1 n2 u n3 -- n1 n2 u n4 )
        dup .		( n1 n2 u n3 -- n1 n2 u n3 )
        swap		( n1 n2 u n3 -- n1 n2 n3 u )
        lin		( n1 n2 n3 u -- n1 n2 n3 u c-addr )
        swap		( n1 n2 n3 u c-addr -- n1 n2 n3 c-addr u )
        type cr		( n1 n2 n3 c-addr u -- n1 n2 n3 )
        key?		( n1 n2 -- n1 n2 flag )
        if		( n1 n2 flag -- n1 n2 )
          key dup	( n1 n2 -- n1 n2 c c )
          [char] q =	( n1 n2 c c -- n1 n2 c flag )
          swap		( n1 n2 c flag -- n1 n2 flag c )
          [char] Q =	( n1 n2 flag1 c -- n1 n2 flag1 flag2 )
          or		( n1 n2 flag1 flag2 -- n1 n2 flag3 )
          if bye then	( n1 n2 flag3 -- n1 n2 )
        then
      repeat
      2drop		( n1 n2 u n3 u -- n1 n2 )
      fid @		( n1 n2 -- n1 n2 fileid )
      close-file	( n1 n2 fileid -- n1 n2 ior )
      drop		( n1 n2 ior -- n1 n2 )
    then
    swap		( n1 n2 -- n2 n1 )
    1+			( n1 n2 -- n1 n3 )
    swap		( n1 n2 -- n2 n1 )
  repeat ;

256 linlen !
2 argc @	( -- n1 n2 )
lsfl
bye
