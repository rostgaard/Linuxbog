#!/usr/bin/perl -w

# Fikser stikord i html udgave, så splitindex kan anvendes.

# Brug: tr "\n" " " < stikord.html | $0 > fixed.stikord.html

my $prevline = "";
my $state = "body"; # body, header

while(<>) {
    s/\<\/H1\>/\<\/H1\>\n/g;
    s/\<H1 /\n\<H1 /g;
    s/\<\/H2\>/\<\/H2\>\n/g;
    s/\<H2 /\n\n\<H2 /g;
    s/\<DL/\n\<DL/g;
    s/ \>/\>/g;
    # Splitte dt'er, så de kan tælles.
    s/\<DT\>/\n\<DT\>/g;
    # Fjerne divs som er noget snavs alligevel.
    s/\<\/DIV\>//g;
    s/\<DIV CLASS=\"indexdiv\"\>//g;
    s/\<DIV CLASS=\"NAVFOOTER\"\>.*//g;
    print $_;
}
