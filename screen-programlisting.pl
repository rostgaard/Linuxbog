#!/usr/bin/perl
# $Id$
# af Ole Tange

# Formål: Lav en sektion om fra <SCREEN> til <PROGRAMLISTING>
# hvis ikke <PROMPT> forekommer i den <SCREEN>-sektion.

# Kørsel:
# for S in *.sgml; do mv ${S} ${S}.org; cat ${S}.org|../screen-programlisting.pl>${S} ; done

while(<>) {
    if(/<SCREEN>/i .. m:</SCREEN>:i) {
	push(@screen,$_);
      m:</SCREEN>:i and do {
	  if(grep(/<PROMPT>/i, @screen)) {
	      print @screen;
	  } else {
	      for $i (@screen) {
		  $i=~s:<SCREEN>:<PROGRAMLISTING>:i;
		  $i=~s:</SCREEN>:</PROGRAMLISTING>:i;
	      }
	      print @screen;
	  }
	  @screen=();
      };
    } else {
	print $_;
    }
}

