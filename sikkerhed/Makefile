all:	html 1fil pspdf txt palmpilot

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
	cp start.sgml bog.sgml
	perl /usr/local/bin/collateindex.pl -s Symboler  -t Stikordsregister -g -i stikord -N -o stikord.sgml
	cp *.sgml tempdir
	(cd tempdir; jade -t sgml -ihtml -d /usr/lib/sgml/stylesheets/cygnus-both.dsl\#html -V html-index bog.sgml)
	perl /usr/local/bin/collateindex.pl -s Symboler -t Stikordsregister  -g -i stikord  -o stikord.sgml tempdir/HTML.index
	rm -rf tempdir
	db2html bog.sgml

txt:
	lynx -dump -hiddenlinks=ignore bog/book.html > linuxbog.txt
	cp linuxbog.txt linuxbog2.txt
	gzip -9 linuxbog2.txt
	mv linuxbog2.txt.gz linuxbog.txt.gz
	mv linuxbog.txt bog

1fil:
	rm -rf stikord.sgml tempdir magic.sgml
	echo '<!ENTITY magic "png">' > magic.sgml
	mkdir tempdir
	perl /usr/local/bin/collateindex.pl -s Symboler  -t Stikordsregister -g -i stikord -N -o stikord.sgml
	cp start.sgml bog.sgml
	cp *.sgml tempdir
	(cd tempdir; jade -t sgml -ihtml -d /usr/lib/sgml/stylesheets/cygnus-both.dsl\#html -V html-index -V nochunks bog.sgml > ged.html)
	perl /usr/local/bin/collateindex.pl -s Symboler -t Stikordsregister  -g -i stikord  -o stikord.sgml tempdir/HTML.index
	jade -t sgml -i html -d /usr/lib/sgml/stylesheets/cygnus-both.dsl\#html -V nochunks start.sgml > bog/book.html

tags:
	rm bog.sgml
	etags *.sgml

clean:
	rm -rf *.html magic.sgml bog.sgml DBTOHTML_OUTPUT_DIR* bog.junk bog/* linuxbog.ps bog *.dvi stikord.sgml tempdir bogps bogpdf linuxbog.pdf images/*.eps linuxbog_palm.zip  linuxbog.txt.gz



ps:
	rm -rf bogps stikord.sgml tempdir magic.sgml
	mkdir tempdir
	echo '<!ENTITY magic "eps">' > magic.sgml
	perl /usr/local/bin/collateindex.pl  -t Stikordsregister -g -i stikord -N -o stikord.sgml
	cp start.sgml bog.sgml
	cp *.sgml tempdir
	(cd tempdir; jade -t sgml -ihtml -d /usr/lib/sgml/stylesheets/cygnus-both.dsl\#print -V html-index -V nochunks bog.sgml > ged.html)
	perl /usr/local/bin/collateindex.pl -s Symboler -t Stikordsregister  -g -i stikord  -o stikord.sgml tempdir/HTML.index
	find images/*.png | sed 's/.png//' | sed 's=images/==' | xargs -i% convert -antialias images/%.png eps2:images/%.eps
	mkdir bogps
	cp *.sgml bogps
	(cd bogps; db2ps bog.sgml)
	mv bogps/bog.ps linuxbog.ps
	rm -rf bogps

pdf:
	rm -rf bogpdf tempdir magic.sgml
	mkdir tempdir
	echo '<!ENTITY magic "png">' > magic.sgml
	cp start.sgml bog.sgml
	perl /usr/local/bin/collateindex.pl  -t Stikordsregister -g -i stikord -N -o stikord.sgml
	cp *.sgml tempdir
	(cd tempdir; jade -t sgml -ihtml -d /usr/lib/sgml/stylesheets/cygnus-both.dsl\#print -V html-index -V nochunks bog.sgml > ged.html)
	perl /usr/local/bin/collateindex.pl -s Symboler -t Stikordsregister  -g -i stikord  -o stikord.sgml tempdir/HTML.index
	mkdir bogpdf
	cp *.sgml bogpdf
	(cd bogpdf; db2pdf bog.sgml)
	mv bogpdf/bog.pdf ./linuxbog.pdf

pspdf:
	rm -rf bogpdf bogps tempdir
	mkdir tempdir
	cp start.sgml bog.sgml
	echo '<!ENTITY magic "png">' > magic.sgml
	perl /usr/local/bin/collateindex.pl  -t Stikordsregister -g -i stikord -N -o stikord.sgml
	cp *.sgml tempdir
	(cd tempdir; jade -t sgml -ihtml -d /usr/lib/sgml/stylesheets/cygnus-both.dsl\#print -V html-index -V nochunks bog.sgml > ged.html)
	perl /usr/local/bin/collateindex.pl -s Symboler -t Stikordsregister  -g -i stikord  -o stikord.sgml tempdir/HTML.index
	mkdir bogpdf
	cp *.sgml bogpdf
	(cd bogpdf; db2pdf bog.sgml)
	mv bogpdf/bog.pdf ./linuxbog.pdf
	echo '<!ENTITY magic "eps">' > magic.sgml
	find images/*.png | sed 's/.png//' | sed 's=images/==' | xargs -i% convert -antialias images/%.png eps2:images/%.eps
	mkdir bogps
	cp *.sgml bogps
	(cd bogps; db2ps bog.sgml)
	mv bogps/bog.ps ./linuxbog.ps

sizes:
	(ls -al bog/linuxbog.txt; ls -al /home/ftp/pub/linuxbog.txt.gz;ls -al /home/ftp/pub/linuxbog.ps.gz;ls -al /home/ftp/pub/linuxbog.pdf.gz;ls -al /home/ftp/pub/linuxbog.tgz; linuxbog_sgml.tgz) | mail pto@sslug.dk

