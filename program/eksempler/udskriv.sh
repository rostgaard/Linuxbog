#!/bin/sh
# af Peter Stubbe <stubbe@bitnisse.dk>
# $Id$
# Afvikling:
#  ./udskriv.sh fil+

while [ $1"x" != "x" ]
do
    read -t 1 key
    if [ $key"x" == "Qx" ]
    then
	break
    fi
    if [ ! -e $1 ]
    then
	echo "filen $1 findes ikke!"
	exit
    fi
# For eksemplets skyld er listningen udført med shell-kommandoer
# selvom det ville være lettere (og hurtigere) at lave fx:
#   awk '{lnr++; print lnr, $0}' $1
    lnr=1
    ( while read lin; res=$?; [ $res == "0" ] ; do echo -e $lnr"\t"$lin; lnr=`expr $lnr + 1`; done ) <$1
    shift
done
