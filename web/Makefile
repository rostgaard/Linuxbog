locdirname=$(shell pwd)
targetname=linux-$(notdir $(locdirname))
version=$(shell cat version.sgml)
dato=$(shell cat dato.sgml)

all:	statusfiler html pspdf


statusfiler:
	@$(shell date +%d/%m-%Y> dato.sgml)
	@echo Version er $(version)
	@echo Dato sat til $(dato)

html:
	@echo "Target er HTML i" $(notdir $(locdirname))/bog
	rm -rf tempdir stikord.sgml magic.sgml $(targetname)-html-*.tgz
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
	tar cvzf $(targetname)-html-$(version).tgz bog
	@echo "Done HTML (html)"
	@echo ""

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
	mv bogps/bog.ps $(targetname)-$(version).ps
	rm -f $(targetname)-*.ps.gz
	@echo "Done PS (pspdf)"
	@echo ""
	gzip -9 $(targetname)-$(version).ps
	@echo "Target is" $(targetname).pdf.gz
	echo '<!ENTITY magic "png">' > magic.sgml
	mkdir bogpdf
	cp *.sgml bogpdf
	cp images/*.png bogpdf
	(cd bogpdf; db2pdf bog.sgml)
	mv bogpdf/bog.pdf $(targetname)-$(version).pdf
	rm -f $(targetname)-*.pdf.gz
	gzip -9 $(targetname)-$(version).pdf
	@echo "Done PDF (pspdf)"
	@echo ""


clean:
	rm -rf dato.sgml magic.sgml DBTOHTML_OUTPUT_DIR* bog.junk bog stikord.sgml tempdir bogps bogpdf $(targetname)-html-*.tgz $(targetname)*.pdf.gz $(targetname)*.ps.gz


