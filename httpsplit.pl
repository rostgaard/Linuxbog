#!/usr/bin/perl -w -i -p
 
# Script af Hans Schou (og Ole Tange har også hjulpet lidt med et par "småting").
# $Id$

# Afvikling:
#  ./httpsplit *.sgml

# Hyperlinks i PostScript og PDF giver så lange tekster at
# links går ud over kanten af papiret, og kan så ikke læses.
# Scriptet her fjerner <ULINK> og sætter spacer før '/' i URLer.

# Filerne bliver ændret, så dette script må kun køres på en kopi.

undef ($/);

 # Lav mailto om
 s!<ulink\s+url="mailto:(.*?)">.*?</ulink>!<ComMand>&lt;$1&gt;</ComMand>!gsi;
 
 # Lav http og ftp URLer om
 s!<ulink\s+url="     # <ulink url="
    (.tt?p://|file:)  # http://, ftp:// eller file:
    (.*?)">           # www.sslug.dk/linuxbog">
    .*?</ulink>       # www.sslug.dk/linuxbog</ulink>
  !
    $http=$1;$path=$2;$path =~ s@/@/@g;
    "$http$path"
  !gsixe;             # Global SingleString IgnoreCase eXtentedComments Expression

