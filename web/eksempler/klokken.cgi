#!/usr/bin/perl -w

#Udskriv header
print "Content-Type: text/plain\r\n";
print "\r\n";

#Udskriv tekst indhold
print "Datoen er ".scalar(localtime);
