#!/usr/bin/perl
# $Id$

my $state = 0;
my $headerX = "";
my $file = "";
my $filetitle = "";

my $header1 = "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">
<HTML>
  <HEAD>
    <TITLE>";
my $header2 = "</TITLE>
    <META name=\"GENERATOR\" content=\"splitindex.pl\">
    <LINK rel=\"STYLESHEET\" type=\"text/css\" href=\"linuxbog.css\">
  </HEAD>

  <BODY class=\"SETINDEX\">
";

open(FILE,">/dev/null");
open(IDX,">idx.html") || die "Can not write to idx.html";
while (<>) {
    # Kæmpestart
    if ($state == 0) {
	if (m/indexdiv/) {
#	    print STDERR "1: Match på : $_";
	    $state = 1;
	    print IDX $header1."Oversigt".$header2."\n<ul>\n";
	} else {
#	    print STDERR "1: Ej Match på : $_";
	    $headerX .= $_;
	}
    }
    # Åbning af fil?
    if ($state == 1) {
	if (m/<H2 CLASS="indexdiv"><A NAME="[a-zA-Z0-9]+"><\/A>([a-zA-Z]+)<\/H2>/) {
#	    print STDERR "2: Match på : $_";
	    $filetitle = $1;
	    $file = "idx-".lc $filetitle.".html";
	    print IDX "<li><a href=\"$file\">$filetitle</a></li>\n";
	    print FILE "</body></html>";
	    close(FILE);
	    open(FILE,">$file") || die "Can not write to $file";
	    print FILE $header1.$filetitle.$header2;
	    print FILE "<h1>$filetitle</h1>\n";
	} else {
#	    print STDERR "2: Ej Match på : $_";
	    if (
	    print FILE $_;
	}

    }
}
print IDX "</ul></body></html>";
close(IDX);
print FILE "</body></html>";
close(FILE);
