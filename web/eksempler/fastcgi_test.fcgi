#!/usr/bin/perl
use FCGI;

my $count=0;

my $request = FCGI::Request();

while($request::accept() >= 0) 
{
   print "Content-Type: text/html\r\n\r\n";
   print "<h1>FastCGI test</h1>\n";
   print "<p>Antal af forbindelser for dette script: ++$count</p>\n";

#her kan resten af cgi scriptet udføres.

}
