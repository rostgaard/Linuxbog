#! /usr/bin/perl -w

# Script to escape characters to sgml

while(<>) {
    s/\&/\&amp\;/g;
    s/\</\&lt\;/g;
    s/\>/&gt\;/g;
    print $_;
}
