#  Lokalt katalog (fuld sti)
locdirname=$(shell pwd)

# Kort navn
targetshortname=$(notdir $(locdirname))

# Med linux- foran
targetname=linux-$(notdir $(locdirname))

# version
version=$(shell cat version.sgml)

# dato
dato=$(shell cat dato.sgml)

# Her er en liste af sgml-filer der ændres automatisk
badsgmlfiles=dato.sgml magic.sgml stikord.sgml

# Her er  en liste af alle sgml
allesgmlfiles=$(wildcard *.sgml)

# Her er en liste af sgml-filer der skal checkes
#sgmlfiler=$(filter-out $(badsgmlfiles),$(allesgmlfiles))
sgmlfiler=$(allesgmlfiles) \
          ../friheden/*.sgml \
          ../admin/*.sgml \
          ../web/*.sgml \
          ../applikationer/*.sgml \
          ../c/*.sgml \
          ../docbook/*.sgml \
          ../program/*.sgml

# her er det der skal laves
all:	billeder html palmpilot sgml pspdf exit

sgml: $(targetname)-$(version).sgml.tgz

$(targetname)-$(version).sgml.tgz: $(sgmlfiler)
	tar cvzf $(targetname)-$(version).sgml.tgz *.sgml Makefile collateindex.pl

palmpilot: $(targetname)-$(version).palm.tgz

$(targetname)-$(version).palm.tgz: $(sgmlfiler)
	make html
	rm -f palm/*.prc palm/*.pdb
	(cd palm;plucker-build -v -P . -f $(targetname))
	cp ../misc/*.prc palm
	tar cvzf $(targetname)-$(version).palm.tgz palm/*.prc palm/*.pdb

statusfiler:
	@$(shell date +%d/%m-%Y> dato.sgml)
	@echo start på $(targetshortname)	
	@echo Version er $(version)
	@echo Dato sat til $(dato)
	@echo Checker $(sgmlfiler)

exit:
	@echo slut på $(targetshortname)
	@echo --------------
	@echo 

billeder:
	cp ../friheden/images/*.png images
	cp ../admin/images/*.png images
	cp ../web/images/*.png images
	cp ../program/images/*.png images
	cp ../c/images/*.png images
	cp ../docbook/images/*.png images
	cp ../applikationer/images/*.png images
	cp ../sikkerhed/images/*.png images


htmlfiler: 
	@echo "Target er HTML i" $(targetshortname)/bog
	rm -rf tempdir stikord.sgml magic.sgml $(targetname)-*.html.tgz bog
	echo '<!ENTITY magic "png">' > magic.sgml
	mkdir tempdir
	perl ./collateindex.pl -s Symboler -x -t Stikordsregister -g -i stikord -N -o stikord.sgml
	cp *.sgml tempdir
	(cd tempdir; jade -t sgml -ihtml -d /usr/lib/sgml/stylesheets/cygnus-both.dsl\#html -V html-index bog.sgml)
	(cd tempdir; perl ../collateindex.pl -s Symboler  -x -t Stikordsregister  -g -i stikord  -o stikord.sgml HTML.index)
	#db2html bog.sgml
	(cd tempdir;jade -t sgml -ihtml -d /usr/lib/sgml/stylesheets/cygnus-both.dsl\#html bog.sgml)
	rm -rf bog
	mkdir bog
	cp tempdir/*.html bog
	cp linuxbog.css bog
	cp ../friheden/images/*.png bog
	cp ../admin/images/*.png bog
	cp ../web/images/*.png bog
	cp ../program/images/*.png bog
	cp ../applikationer/images/*.png bog
	cp ../c/images/*.png bog
	cp ../docbook/images/*.png bog
	cp ../sikkerhed/images/*.png bog
	rm -rf tempdir
	@echo "Done HTML (html)"
	@echo ""

reparerhtml:
	(cd bog;perl ../../misc/insertimagesize)	
	(cd bog;tidy -f err.txt -imu *html;rm -f err.txt)


pakhtml:
	mv bog $(targetshortname)
	tar cvzf $(targetname)-$(version).html.tgz $(targetshortname)
	zip $(targetname)-$(version)_html.zip $(targetshortname)/*
	tar cvzf $(targetname)-$(version).html-ub.tgz $(targetshortname)/*.html $(targetshortname)/*.css
	mv $(targetshortname) bog 
	mv images $(targetshortname)_images
	tar cvzf $(targetname)-$(version).png.tgz $(targetshortname)_images/
	mv $(targetshortname)_images images 
	@echo "Done HTML pakning (pakhtml)"
	@echo ""

bog/index.html: $(sgmlfiler)
	make statusfiler
	make htmlfiler 
	make reparerhtml 
	make pakhtml

html: bog/index.html

pspdf:	$(targetname)-$(version)_pdf.zip

$(targetname)-$(version)_pdf.zip: $(sgmlfiler)
	make statusfiler
	@echo "Target is" $(targetname).ps.gz
	rm -rf bogps bogpdf stikord.sgml tempdir magic.sgml
	mkdir tempdir
	echo '<!ENTITY magic "eps">' > magic.sgml
	perl ./collateindex.pl  -t Stikordsregister -x -g -i stikord -N -o stikord.sgml
	cp *.sgml tempdir
	(cd tempdir; jade -t sgml -ihtml -d /usr/lib/sgml/stylesheets/cygnus-both.dsl\#print -V html-index -V nochunks bog.sgml > ged.html)
	perl ./collateindex.pl -s Symboler -x -t Stikordsregister  -g -i stikord  -o stikord.sgml tempdir/HTML.index
	mkdir bogps
	find images/*.png | sed 's/.png//' | sed 's=images/==' | xargs -i% /usr/X11R6/bin/convert -antialias images/%.png eps2:bogps/%.eps
	echo '<!ENTITY magic "eps">' > magic.sgml
	cp *.sgml bogps
	(cd bogps; db2ps bog.sgml > /dev/null)
	mv bogps/bog.ps $(targetname)-$(version).ps
	rm -f $(targetname)-*.ps.gz
	@echo "Done PS (pspdf)"
	@echo ""
	gzip -9 $(targetname)-$(version).ps
	@echo "Target er" $(targetname).pdf
	echo '<!ENTITY magic "png">' > magic.sgml
	mkdir bogpdf
	cp *.sgml bogpdf
	rm -f $(targetname)-*.pdf
	cp images/*.png bogpdf
	(cd bogpdf; db2pdf bog.sgml > /dev/null)
	mv bogpdf/bog.pdf $(targetname)-$(version).pdf
	pdfinfo $(targetname)-$(version).pdf | grep Pages: | cut -d':' -f2 > sideantal.txt
	zip $(targetname)-$(version)_pdf.zip $(targetname)-$(version).pdf
	@echo "Done PDF (pspdf)"
	@echo ""

test:
	echo $(sgmlfiler)


clean:
	rm -rf dato.sgml magic.sgml DBTOHTML_OUTPUT_DIR* bog.junk bog stikord.sgml tempdir bogps bogpdf $(targetname)* palm/*.prc palm/*.pdb sideantal.txt images/*.png images/*.eps


