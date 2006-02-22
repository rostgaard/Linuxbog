#! /usr/bin/perl
# af Hans Schou
# http://www.docbook.org/tdg/en/html/xref.html
# http://www.oreilly.com/catalog/docbook/chapter/book/xref.html
#
#
print "<TABLE id=\"anvendtetags\">
<title>Anvendte tags</title>
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
		print "<entry>$name</entry>";
		print "<entry><ulink url=\"http://www.docbook.org/tdg/en/html/$name.html\">docbook.org</ulink></entry>";
		print "<entry><ulink url=\"http://www.oreilly.com/catalog/docbook/chapter/book/$name.html\">O'reilly</ulink></entry> ";
		print "</row>\n";
	}
}

print "</tbody></tgroup></table>\n";
