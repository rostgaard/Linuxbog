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
	if ($state == 0) {
		if (/INDEXDIV/) {
			$state = 1;
			print IDX $header1."Oversigt".$header2;
		} else {
			$headerX .= $_;
		}
	}
	if ($state == 1) {
		if (/<H1 class="INDEXDIV"><A name="[a-zA-Z0-9]+">([a-zA-Z]+)<\/A><\/H1>/) {
			$filetitle = $1;
			$file = "idx-".lc $filetitle.".html";
			print IDX "<a href=\"$file\">$filetitle</a>\n";
			print FILE "</body></html>";
			close(FILE);
			open(FILE,">$file") || die "Can not write to $file";
			print FILE $header1.$filetitle.$header2;
			print FILE "<h1>$filetitle</h1>\n";
		} else {
			print FILE $_;
		}

	}
}
print IDX "</body></html>";
close(IDX);
print FILE "</body></html>";
close(FILE);
