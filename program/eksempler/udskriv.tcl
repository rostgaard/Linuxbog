#!/usr/bin/tcl
# af Peter Stubbe <stubbe@bitnisse.dk>
# $Id$
# Afvikling:
#  ./udskriv.tcl fil+

foreach fil $argv {
    if {[ file exists $fil ] == 0} {
	puts stderr "Kan ikke finde inputfil!"
	continue
    }
    set fh [open $fil r]
    set lnr 0
    while {[gets $fh linie] >= 0} {
	incr lnr
	puts -nonewline $lnr
	puts -nonewline "\t"
	puts $linie
    }
    close $fh
}
