all:	html 1fil pspdf palmpilot txt 

palmpilot:	
	(cd palm; python /usr/lib/python1.5/site-packages/PyPlucker/Spider.py -v -p . -f Linuxbog)
	(cd palm; zip linuxbog_palm.zip README Linuxbog.pdb viewer_en.prc )
	mv palm/linuxbog_palm.zip .

tidy:
	(cd bog; tidy -f err.txt -imu *html)

html:
	rm -rf tempdir stikord.sgml magic.sgml
	echo '<!ENTITY magic "png">' > magic.sgml
	mkdir tempdir
	perl /usr/local/bin/collateindex.pl -s Symboler  -t Stikordsregister -g -i stikord -N -o stikord.sgml
	cp *.sgml tempdir
	(cd tempdir; jade -t sgml -ihtml -d /usr/lib/sgml/stylesheets/cygnus-both.dsl\#html -V html-index bog.sgml)
	perl /usr/local/bin/collateindex.pl -s Symboler -t Stikordsregister  -g -i stikord  -o stikord.sgml tempdir/HTML.index
	rm -rf tempdir
	db2html bog.sgml
	cp linuxbog.css bog
	cp images/*.png bog

txt:
	lynx -dump -hiddenlinks=ignore bog/book.html > linuxbog.txt

1fil:
	rm -rf stikord.sgml tempdir magic.sgml
	echo '<!ENTITY magic "png">' > magic.sgml
	mkdir tempdir
	perl /usr/local/bin/collateindex.pl -s Symboler  -t Stikordsregister -g -i stikord -N -o stikord.sgml
	cp *.sgml tempdir
	(cd tempdir; jade -t sgml -ihtml -d /usr/lib/sgml/stylesheets/cygnus-both.dsl\#html -V html-index -V nochunks bog.sgml > ged.html)
	perl /usr/local/bin/collateindex.pl -s Symboler -t Stikordsregister  -g -i stikord  -o stikord.sgml tempdir/HTML.index
	jade -t sgml -i html -d /usr/lib/sgml/stylesheets/cygnus-both.dsl\#html -V nochunks start.sgml > bog/book.html
	cp linuxbog.css bog
	cp images/*.png bog


ps:
	rm -rf bogps stikord.sgml tempdir magic.sgml
	mkdir tempdir
	echo '<!ENTITY magic "eps">' > magic.sgml
	perl /usr/local/bin/collateindex.pl  -t Stikordsregister -g -i stikord -N -o stikord.sgml
	cp *.sgml tempdir
	(cd tempdir; jade -t sgml -ihtml -d /usr/lib/sgml/stylesheets/cygnus-both.dsl\#print -V html-index -V nochunks bog.sgml > ged.html)
	perl /usr/local/bin/collateindex.pl -s Symboler -t Stikordsregister  -g -i stikord  -o stikord.sgml tempdir/HTML.index
	mkdir bogps
	find images/*.png | sed 's/.png//' | sed 's=images/==' | xargs -i% convert -antialias images/%.png eps2:bogps/%.eps
	cp *.sgml bogps
	(cd bogps; db2ps bog.sgml)
	mv bogps/bog.ps linuxbog.ps
	rm -rf bogps

pdf:
	rm -rf bogpdf tempdir magic.sgml
	mkdir tempdir
	echo '<!ENTITY magic "png">' > magic.sgml
	perl /usr/local/bin/collateindex.pl  -t Stikordsregister -g -i stikord -N -o stikord.sgml
	cp *.sgml tempdir
	(cd tempdir; jade -t sgml -ihtml -d /usr/lib/sgml/stylesheets/cygnus-both.dsl\#print -V html-index -V nochunks bog.sgml > ged.html)
	perl /usr/local/bin/collateindex.pl -s Symboler -t Stikordsregister  -g -i stikord  -o stikord.sgml tempdir/HTML.index
	mkdir bogpdf
	cp *.sgml bogpdf
	cp images/*.png bogpdf
	(cd bogpdf; db2pdf bog.sgml)
	mv bogpdf/bog.pdf ./linuxbog.pdf

tags:
	etags *.sgml

clean:
	rm -rf *.html magic.sgml DBTOHTML_OUTPUT_DIR* bog.junk bog/* linuxbog.ps bog *.dvi stikord.sgml tempdir bogps bogpdf linuxbog.pdf images/*.eps linuxbog_palm.zip  linuxbog.txt.gz


