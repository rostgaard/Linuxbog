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
	$books = array(
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
		
    }
    
    $php.= join(",",@php) . q{); ?>}."\n";
print $php;

if ($error) {
	die($error);
}
