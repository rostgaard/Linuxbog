#!/usr/bin/perl -w

use strict;

sub bottles {
    my $n = shift;

    return "No bottles" if $n == 0;
    return "1 bottle"   if $n == 1;
    return "$n bottles";
}

my $i = 99;
while($i > 0) {
    print bottles($i), " of beer on the wall\n";
    print bottles($i), " of beer\n";
    print "Take one down and pass it around\n";
    print bottles(--$i), " of beer on the wall\n";
    print "\n";
}

