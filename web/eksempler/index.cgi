#!/usr/bin/perl -w

#Lav en liste med indholdet af ./ kataloget
#dvs. samme katalog som index.cgi selv
opendir DIR, "./" or die "Can't list directory /.!\n";

#filtrer listen så den kun indeholder .html filer
my @files = grep /\.html$/, readdir(DIR);

#vælg tilfældigt index i listen
my $no=int rand ($#files+1);

#udskriv en location til dokument no $no
print 'Location: ', $files[$no] ,"\r\n\r\n";
