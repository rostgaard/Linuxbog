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
badfiles1 = $(wildcard ../*/dato.sgml)
badfiles2 = $(wildcard ../*/magic.sgml)
badfiles3 = $(wildcard ../*/stikord.sgml) 
badfiles4 = $(wildcard ../*/version.sgml) 
badfiles = $(badfiles1) $(badfiles2) $(badfiles3) $(badfiles4)

# Her er en liste af sgml-filer der skal checkes
totalsgmlfiler=$(wildcard ../alle/*.sgml) \
               $(wildcard ../friheden/*.sgml) \
               $(wildcard ../admin/*.sgml) \
               $(wildcard ../web/*.sgml) \
               $(wildcard ../applikationer/*.sgml) \
               $(wildcard ../c/*.sgml) \
               $(wildcard ../docbook/*.sgml) \
               $(wildcard ../kontorbruger/*.sgml) \
               $(wildcard ../itplatform/*.sgml) \
               $(wildcard ../program/*.sgml)

sgmlfiler = $(filter-out $(badfiles),$(totalsgmlfiler))


# her er det der skal laves
all:	billeder html palmpilot sgml exit

sgml: $(targetname)-$(version).sgml.tar.gz

$(targetname)-$(version).sgml.tar.gz: $(sgmlfiler)
	(cd ..;tar cvzf $(targetshortname)/$(targetname)-$(version).sgml.tar.gz $(targetshortname)/*.sgml $(targetshortname)/Makefile $(targetshortname)/collateindex.pl)
	(cd ..;zip $(targetshortname)/$(targetname)-$(version).sgml.zip -r $(targetshortname)/*.sgml $(targetshortname)/Makefile $(targetshortname)/collateindex.pl )

palmpilot: $(targetname)-$(version).palm.zip

$(targetname)-$(version).palm.zip: $(sgmlfiler)
	make html
	rm -f palm/*.prc palm/*.pdb
	(cd palm;plucker-build -v -P . -f $(targetname))
	cp ../misc/*.prc palm
	zip $(targetname)-$(version).palm.zip palm/*.prc palm/*.pdb

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
	cp ../kontorbruger/images/*.png images
	cp ../itplatform/images/*.png images
	cp ../applikationer/images/*.png images
	cp ../sikkerhed/images/*.png images


htmlfiler: billeder
	@echo "Target er HTML i" $(targetshortname)/bog
	rm -rf tempdir stikord.sgml magic.sgml $(targetname)-*.html.tar.gz bog
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
	cp images/*.png bog
	cp linuxbog.css bog
	rm -rf tempdir
	@echo "Done HTML (html)"
	@echo ""

reparerhtml:
	(cd bog;perl ../../misc/insertimagesize)	
	(cd bog;tidy -f err.txt -imu *html;rm -f err.txt)


pakhtml:
	mv bog $(targetshortname)
	tar cvzf $(targetname)-$(version).html.tar.gz $(targetshortname)
	zip $(targetname)-$(version)_html.zip $(targetshortname)/*
	tar cvzf $(targetname)-$(version).html-ub.tar.gz $(targetshortname)/*.html $(targetshortname)/*.css
	mv $(targetshortname) bog 
	mv images $(targetshortname)_images
	tar cvzf $(targetname)-$(version).png.tar.gz $(targetshortname)_images/
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

$(targetname)-$(version)_pdf.zip: $(sgmlfiler) billeder
	make statusfiler
	@echo "Target is" $(targetname).ps.gz
	rm -rf bogps bogpdf stikord.sgml tempdir magic.sgml
	mkdir tempdir
	echo '<!ENTITY magic "eps">' > magic.sgml
	perl ./collateindex.pl  -t Stikordsregister -x -g -i stikord -N -o stikord.sgml
	cp *.sgml tempdir
	(cd tempdir; jade -t sgml -ihtml -d /usr/lib/sgml/stylesheets/cygnus-both.dsl\#print -V html-index -V nochunks bog.sgml > ged.html)
	perl ./collateindex.pl -s Symboler -x -t Stikordsregister  -g -i stikord  -o stikord.sgml tempdir/HTML.index
#	mkdir bogps
#	find images/*.png | sed 's/.png//' | sed 's=images/==' | xargs -i% /usr/X11R6/bin/convert -antialias images/%.png eps2:bogps/%.eps
#	echo '<!ENTITY magic "eps">' > magic.sgml
#	cp *.sgml bogps
#	(cd bogps; db2ps bog.sgml > /dev/null)
#	mv bogps/bog.ps $(targetname)-$(version).ps
#	rm -f $(targetname)-*.ps.gz
#	@echo "Done PS (pspdf)"
#	@echo ""
#	gzip -9 $(targetname)-$(version).ps
	@echo "Target er" $(targetname).pdf
	echo '<!ENTITY magic "png">' > magic.sgml
	mkdir bogpdf
	cp *.sgml bogpdf
	rm -f $(targetname)-*.pdf
	cp images/*.png bogpdf
	(cd bogpdf; db2pdf bog.sgml )
	mv bogpdf/bog.pdf $(targetname)-$(version).pdf
	pdfinfo $(targetname)-$(version).pdf | grep Pages: | cut -d':' -f2 > sideantal.txt
	zip $(targetname)-$(version)_pdf.zip $(targetname)-$(version).pdf
	@echo "Done PDF (pspdf)"
	@echo ""

test:
	echo $(sgmlfiler)


clean:
	rm -rf dato.sgml magic.sgml DBTOHTML_OUTPUT_DIR* bog.junk bog stikord.sgml tempdir bogps bogpdf $(targetname)* palm/*.prc palm/*.pdb sideantal.txt images/*.png images/*.eps


