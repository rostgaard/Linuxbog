locdirname=$(shell pwd)
targetname=linux-$(notdir $(locdirname))

all:	statusfiler html pspdf

statusfiler:
	@$(shell date +%d/%m-%Y> dato.sgml)
	@echo Version er `cat version.sgml`
	@echo Dato sat til `cat dato.sgml`

html:
	@echo "Target is" $(targetname).html
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

pspdf:
	@echo "Target is" $(targetname).ps.gz
	rm -rf bogps bogpdf stikord.sgml tempdir magic.sgml
	mkdir tempdir
	echo '<!ENTITY magic "eps">' > magic.sgml
	perl /usr/local/bin/collateindex.pl  -t Stikordsregister -g -i stikord -N -o stikord.sgml
	cp *.sgml tempdir
	(cd tempdir; jade -t sgml -ihtml -d /usr/lib/sgml/stylesheets/cygnus-both.dsl\#print -V html-index -V nochunks bog.sgml > ged.html)
	perl /usr/local/bin/collateindex.pl -s Symboler -t Stikordsregister  -g -i stikord  -o stikord.sgml tempdir/HTML.index
	mkdir bogps
	find images/*.png | sed 's/.png//' | sed 's=images/==' | xargs -i% convert -antialias images/%.png eps2:bogps/%.eps
	echo '<!ENTITY magic "eps">' > magic.sgml
	cp *.sgml bogps
	(cd bogps; db2ps bog.sgml)
	mv bogps/bog.ps $(targetname).ps
	rm -f $(targetname).ps.gz
	gzip -9 $(targetname).ps
	@echo "Target is" $(targetname).pdf.gz
	echo '<!ENTITY magic "png">' > magic.sgml
	mkdir bogpdf
	cp *.sgml bogpdf
	cp images/*.png bogpdf
	(cd bogpdf; db2pdf bog.sgml)
	mv bogpdf/bog.pdf $(targetname).pdf
	rm -f $(targetname).pdf.gz
	gzip -9 $(targetname).pdf

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
	mv bogps/bog.ps $(targetname).ps
	rm -f $(targetname).ps.gz
	gzip -9 $(targetname).ps

pdf:
	@echo "Target is" $(targetname).pdf.gz
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
	mv bogpdf/bog.pdf $(targetname).pdf
	rm -f $(targetname).pdf.gz
	gzip -9 $(targetname).pdf

clean:
	rm -rf dato.sgml magic.sgml DBTOHTML_OUTPUT_DIR* bog.junk bog stikord.sgml tempdir bogps bogpdf $(targetname).pdf.gz $(targetname).ps.gz


