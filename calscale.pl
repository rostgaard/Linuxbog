#! /usr/bin/perl -w

# Program der beregner scale parameteren til sgml udfra en ønsket bredde
# (eller højde?)

# argumenter: [-h] <mål> <billede> [ billede ... ]

# Mads Bondo Dydensborg, madsdyd@challenge.dk, September 2003.

# Default er at bruge bredde
my $brug_hoejde = 0;

######################################################################
#
# Skriv hvordan det virker
sub usage() {
    print STDERR "Brug: $0 [-h] <mål> <billede> [ billede ... ]\n";
    print STDERR "\t-h\tHvis du ønsker en bestemt højde\n";
    print STDERR "\tmål\tDet ønskede mål på billedet\n";
    print STDERR "\tbillede\tBilledet der skal undersøges\n";
    exit -1;
}


# Jeg er ikke så godt til perl...
# Check om -h...
my $first = shift(@ARGV);
my $maal = 7; # Tjaeh..
if (!defined $first || "" eq $first) {
    usage();
}
if ("-h" eq $first) {
    $brug_hoejde = 1;
    $maal = shift(@ARGV);
} else {
    $maal = $first;
}

# Check vi har et mål
if (!defined $maal || "" eq $maal) {
    usage();
}

# Tilpas , 0.10 => 10
$maal = $maal*100;

$count = 0;
foreach $fil (@ARGV) {
    print "$fil: ";
    $count++;

    # Kør identify
    # Det her er ikke smart, men hvad
    my $resstring = `identify -verbose $fil | grep Resolution:`;
    my $res;
    if (!defined $resstring || "" eq $resstring) {
	$res = 28.34;
    } else {
	# Resolution: 28.34x28.34 pixels/centimeter
	# TODO: -h option
	$res = 0;
	if (0 == $brug_hoejde) {
	    if ($resstring =~ m/Resolution: ([^x]*)x.*centimeter/) {
		# print STDERR "Match: $1\n";
		$res = $1;
	    }
	} else {
	    if ($resstring =~ m/Resolution: [^x]*x([^ ]*).*centimeter/) {
		# print STDERR "Match: $1\n";
		$res = $1;
	    }
	}
	if (0 == $res) {
	    print STDERR "Warning, Resolution present, unable to parse\n";
	    next; 
	}
    }
    
    # print STDERR "Res: $res\n";

    # Ikke smart
    my $sizestring = `identify $fil`;
    my $size;
    # print "sizestring : $sizestring\n";
    if ($sizestring =~ m/ (\d*)x(\d*)\+/) {
	# print "Size: $1, $2\n";
	if (0 == $brug_hoejde) {
	    $size = $1;
	} else {
	    $size = $2;
	}
    } else {
	print STDERR "Warning, unable to parse size\n";
	next;
    }

    # skriv ud
    print $maal*$res/$size."\n";
}


# Check om der var fil argument...
if (0 == $count) {
    usage();
}




