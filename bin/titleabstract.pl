#!/usr/bin/perl

# $Id$
# (C) 2004 Ole Tange http://ole.tange.dk under GPL
# 
# Programmet tager indholdsfilerne fra hver af bøgerne og
# samler dem til en php-liste.
#
# Programmet skal køres fra det subdir der skal være udgangs-
# punkt til sidst.
#
# Brug:
#   titleabstract.pl <fil1.sgml> [fil2.sgml [fil3.sgml]]
# Eksempel:
#   titleabstract.pl */indhold.sgml > titleabstract.php

$php = q{<?php
/*
 * Denne fil er genereret af http://cvs.sslug.dk/bin/titleabstract.pl
 * Ret ikke i denne fil. Den overskrives.
 * Rækkefølge af bøger styres af 'configure', variabel SUBDIRS.
 */
	$books = array(
	     };

$html = q{<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
       "http://www.w3.org/TR/html40/loose.dtd">
<!-- Denne fil er genereret af http://cvs.sslug.dk/bin/titleabstract.pl
	Ret ikke i denne fil. Den overskrives. -->
<html><head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<title>Friheden til at vælge</title>
</head><body>
<img src="front.png" alt="Friheden til at skrive bøger" align=right width="183" height="213">
<h1>Friheden til at vælge</h1>
<p><a name="stikord">Stikord</a>:
<a href="idx-a.html">&nbsp;A&nbsp;</a>
<a href="idx-b.html">&nbsp;B&nbsp;</a>
<a href="idx-c.html">&nbsp;C&nbsp;</a>
<a href="idx-d.html">&nbsp;D&nbsp;</a>
<a href="idx-e.html">&nbsp;E&nbsp;</a>
<a href="idx-f.html">&nbsp;F&nbsp;</a>
<a href="idx-g.html">&nbsp;G&nbsp;</a>
<a href="idx-h.html">&nbsp;H&nbsp;</a>
<a href="idx-i.html">&nbsp;I&nbsp;</a>
<a href="idx-j.html">&nbsp;J&nbsp;</a>
<a href="idx-k.html">&nbsp;K&nbsp;</a>
<a href="idx-l.html">&nbsp;L&nbsp;</a>
<a href="idx-m.html">&nbsp;M&nbsp;</a>
<a href="idx-n.html">&nbsp;N&nbsp;</a>
<a href="idx-o.html">&nbsp;O&nbsp;</a>
<a href="idx-p.html">&nbsp;P&nbsp;</a>
<a href="idx-q.html">&nbsp;Q&nbsp;</a>
<a href="idx-r.html">&nbsp;R&nbsp;</a>
<a href="idx-s.html">&nbsp;S&nbsp;</a>
<a href="idx-t.html">&nbsp;T&nbsp;</a>
<a href="idx-u.html">&nbsp;U&nbsp;</a>
<a href="idx-v.html">&nbsp;V&nbsp;</a>
<a href="idx-w.html">&nbsp;W&nbsp;</a>
<a href="idx-x.html">&nbsp;X&nbsp;</a>
<a href="idx-y.html">&nbsp;Y&nbsp;</a>
<a href="idx-z.html">&nbsp;Z&nbsp;</a>
<a href="idx-symboler.html">Symboler</a>
</p>
<h2>Bøger i denne samling</h2>
<ul>
};

for $file (@ARGV) {
	$content=join("",`cat $file`);
	$content =~ m!^.*?<title>(.*?)</title>!si  or  do { $error .= "Title mangler i $file"; };
	$title = $1;
	$content =~ m!^.*?<abstract>.*?<para>(.*?)</para>.*?</abstract>!si  or  do { $error .= "Abstract mangler i $file"; };
	$abstract = $1;
	$abstract =~ s/^\s*//;	$abstract =~ s/\s*$//; 	$abstract =~ s/\s+/ /g;
	$file =~ m!^([^/]+)/!  or  do { $error .= "Dirname dur ikke i $file"; };
	$dir = $1;
	push(@php, qq{
        	"$dir" => array (
    		     title => "$title",
    		     comment => "$abstract",
    		     )
        });
	if ($dir ne "samling") {
		push(@html, qq{
    			<li><b>$dir</b>: <a href="$dir/$dir/index.html"><b>$title</b></a><br>$abstract</li>
		});
	}
    	
}

$php .= join(",",@php) . q{); ?>}."\n";
print $php;

$html .= join("\n",@html). q{
</ul>
<p>
Denne samling af bøger er downloadet fra
<a href="http://www.linuxbog.dk/">www.linuxbog.dk</a> .
Se efter bogpakken kaldet "samling" for at downloade en opdatering.
</p>
</body></html>
};
open(HTML, ">samling/index.html");
print HTML $html;
close HTML;

if ($error) {
	die($error);
}
