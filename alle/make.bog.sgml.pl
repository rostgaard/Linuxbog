#! /usr/bin/perl -w

# Script der laver bog.sgml ud fra en liste af bøger, samt filen bog.sgml.in
# Udskriver pt til stdout

# Start med at fyre bog.sgml.in af
open(INPUT, "<bog.sgml.in") || die "Kunne ikke åbne bog.sgml.in";

print "<!-- Ret ikke i denne fil - den er autogenereret af $0 -->\n";

while(<INPUT>) {
    print $_;
}
close(INPUT);

# Find entiteter i alle andre bøger
foreach $bog (@ARGV) {
    # print STDOUT "Tilføjer $bog\n";
    print "\n";
    open(INPUT, "<../$bog/bog.sgml") || die "Kunne ikke åbne ../$bog/bog.sgml\n";
    # Find entitetslinierne
    while (<INPUT>) {
	if (m/\<\!ENTITY\s+(\S+)\s+SYSTEM\s+\"(\S+)\"\>/) {
	    # print "Fandt: $1 == $2\n";
	    if (!($2 =~ m/stikord.sgml/)) {
		print "<!ENTITY $1 SYSTEM \"../../$bog/$2\">\n";
	    }
	} else {
	    # print "Ingen match på $_";
	}
    }
}

# Luk listen af entities
print "]>\n";

# index, title, mv. 
print "<set id=\"index\" lang=\"da\">\n
<title>Linux - friheden til at skrive bøger</title>\n
<toc id=\"toc\"></toc>\n\n";

# Liste af bøger
foreach $bog (@ARGV) {
    print "<book id=\"$bog-index\" lang=\"da\">
&$bog-indhold;
</book>\n\n";
}

# Afslut
print "<book id=\"alle-stikord\">\n";
print "&stikord;\n";
print "</book>\n\n\n";
print "</set>\n";



# end of file make.bog.sgml.pl

