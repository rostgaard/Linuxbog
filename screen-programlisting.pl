#!/usr/bin/perl
# $Id$
# af Ole Tange

# Formål: Lav en sektion om fra <screen> til <programlisting>
# hvis ikke <PROMPT> forekommer i den <screen>-sektion.

# Kørsel:
# perl -i.bak screen-programlistning.pl *.sgml

while(<>) {
    if(/<screen>/i .. m:</screen>:i) {
	push(@screen,$_);
      m:</screen>:i and do {
	  if(grep(/<PROMPT>/i, @screen)) {
	      print @screen;
	  } else {
	      for $i (@screen) {
		  $i=~s:<screen>:<programlisting>:i;
		  $i=~s:</screen>:</programlisting>:i;
	      }
	      print @screen;
	  }
	  @screen=();
      };
    } else {
	print $_;
    }
}

