#!/usr/bin/perl
# Count used SGML tags in files.
# by Hans Schou and Ole Tange
#
# Usage:
#   cat *.sgml | ./usedtags.pl | sort -nr > usedtags.inc

while (<>) {
  if (/<([a-zA-Z][^>\s]+)[^>]*>/) {
    $s = lc $1;
    $all{$s}++;
  }
}

@keys = sort { $all{$a} <=> $all{$b} } keys %all;

@keys = keys %all;
for (@keys) {
	if ($all{$_} > 0) {
        	print "$all{$_} $_\n";
	}
}
