#!/usr/bin/perl -w

#Udskriv header
print "Content-Type: text/html\r\n";
print "\r\n";

#Vælg tilfældig farve 
my $color=sprintf("%x",int rand 0x1000000);

#Udskriv HTML indhold
print "<H1>Datoen er: ";
print "  <font color=\"#$color\">", scalar(localtime) ,"</font>";
print "</H1>";
