#!/bin/sh

# udskriv.sh
# af David Axmark <david@mysql.com>
# $Id$

# afvikling:
#  1. chmod +x udskriv.sh
#  2. ./udskriv.sh filnavn

LINIENR=1

cat $1 | while IFS='' read LINIE
do
  echo "$LINIENR $LINIE"
  LINIENR=`expr $LINIENR + 1`
done

while read SVAR
do
  if test "$SVAR" = "Q"
  then
    exit 0
  fi
done

