#! /usr/bin/perl
# af Hans Schou
# $Id$
#
# Anvendes sammen med usedtags.pl til at lave en tabel
# hvor der også er links til docbook.org og oreilly.com .

print "<table id=\"anvendte-elementer-tabel\">
<title>Anvendte elementer i denne bog</title>
<tgroup cols=4 align=\"char\">
<thead><row>
<entry>Antal</entry>
<entry>Navn</entry>
<entry>O'reilly</entry>
<entry>DocBook.org</entry>
</row></thead><tbody>\n";

while (<>) {
	chomp;
	if (/^([0-9]+)\s([a-z0-9]+)$/) {
		$count = $1;
		$name = $2;
		print "<row>";
		printf("<entry>%4d</entry>", $count);
		$found = `egrep -i 'sect3 *id=\"docbook-$name\"' docbook.sgml`;
		#print "\n**** $found\n"; exit;
		if ($found) {
			print "<entry>$name</entry>";
		} else {
			print "<entry><link linkend=\"docbook-$name\">$name</link></entry>";
		}
		print "<entry><ulink url=\"http://www.docbook.org/tdg/en/html/$name.html\">docbook.org</ulink></entry>";
		print "<entry><ulink url=\"http://www.oreilly.com/catalog/docbook/chapter/book/$name.html\">O'reilly</ulink></entry> ";
		print "</row>\n";
	}
}

print "</tbody></tgroup></table>\n";

