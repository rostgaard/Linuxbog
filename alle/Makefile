#  Lokalt katalog (fuld sti)
locdirname=$(shell pwd)

# Kort navn
targetshortname=$(notdir $(locdirname))

# Med linux- foran
targetname=linuxbog-$(notdir $(locdirname))

# version
version:=$(shell (cd ../friheden; grep -A2 "<listitem>" apprevhist.sgml | head -n 2 | tail -n 1 | cut -d' ' -f2 > version.sgml; cat version.sgml))

# dato
dato:=$(shell date +%d/%m-%Y> dato.sgml; cat dato.sgml)	

# cygnus dsl ligger ikke ens på MDK8 og RH6.2
cygnusdsl = $(firstword $(wildcard  /usr/share/sgml/docbook/dsssl-stylesheets-cygnus/stylesheets/cygnus-both.dsl /usr/lib/sgml/stylesheets/cygnus-both.dsl))

badfiles1 = $(wildcard ../*/dato.sgml)
badfiles2 = $(wildcard ../*/magic.sgml)
badfiles3 = $(wildcard ../*/stikord.sgml)
badfiles4 = $(wildcard ../*/version.sgml)
badfiles = $(badfiles1) $(badfiles2) $(badfiles3) $(badfiles4)

# Her er en liste af sgml-filer der skal checkes
totalsgmlfiler=$(wildcard ../alle/*.sgml) \
	$(wildcard ../program/*.sgml) \
	$(wildcard ../admin/*.sgml) \
	$(wildcard ../web/*.sgml) \
	$(wildcard ../applikationer/*.sgml) \
	$(wildcard ../unix/*.sgml) \
	$(wildcard ../c/*.sgml) \
	$(wildcard ../java/*.sgml) \
	$(wildcard ../dokumentation/*.sgml) \
	$(wildcard ../kontorbruger/*.sgml) \
	$(wildcard ../itplatform/*.sgml) \
	$(wildcard ../friheden/*.sgml)

sgmlfiler = $(filter-out $(badfiles),$(totalsgmlfiler))

SUBDIRS = applikationer admin program unix web sikkerhed c java dokumentation kontorbruger itplatform friheden

# her er det der skal laves
all: html  pakhtml palmpilot sgml


versionfil:
	@cp ../friheden/version.sgml .
	@cp ../friheden/dato.sgml .

statusfiles:
	@for dir in $(SUBDIRS); do \
		echo -n "$$dir "; \
		(cd ../$$dir;grep -A2 "<listitem>" apprevhist.sgml | head -n 2 | tail -n 1 | cut -d' ' -f2 > version.sgml; echo -n "`cat version.sgml`"); \
		(cd ../$$dir;date +%d/%m-%Y> dato.sgml; echo " (`cat dato.sgml`)"); \
	done;

sgml: $(sgmlfiler) $(targetname)-$(version).sgml.tar.gz $(targetname)-$(version).sgml.zip


$(targetname)-$(version).sgml.tar.gz:
	(cd ..;tar cvzf $(targetshortname)/$(targetname)-$(version).sgml.tar.gz $(targetshortname)/*.sgml $(targetshortname)/Makefile $(targetshortname)/collateindex.pl)

$(targetname)-$(version).sgml.zip:
	(cd ..;zip $(targetshortname)/$(targetname)-$(version).sgml.zip -r $(targetshortname)/*.sgml $(targetshortname)/Makefile $(targetshortname)/collateindex.pl )

palmpilot: $(targetname)-$(version).palm.zip

$(targetname)-$(version).palm.zip: alle/index.html
	rm -f palm/*.prc palm/*.pdb
	(cd palm;plucker-build -v -P . -f $(targetname))
	cp ../misc/*.prc palm
	zip $(targetname)-$(version).palm.zip palm/*.prc palm/*.pdb
	rm -f  palm/*.prc palm/*.pdb

html: statusfiles versionfil $(targetshortname)

$(targetshortname): alle/index.html

alle/index.html: $(sgmlfiler)
	@echo "Target er HTML i" $(targetshortname)/$targetshortname
	rm -rf tempdir stikord.sgml magic.sgml bog alle
	echo '<!ENTITY magic "png">' > magic.sgml
	mkdir tempdir
	perl ./collateindex.pl -s Symboler -x -t Stikordsregister -g -i stikord -N -o stikord.sgml
	cp *.sgml tempdir
	(cd tempdir; jade -t sgml -ihtml -d $(cygnusdsl)\#html -V html-index bog.sgml)
	(cd tempdir; perl ../collateindex.pl -s Symboler  -x -t Stikordsregister  -g -i stikord  -o stikord.sgml HTML.index)
	#db2html bog.sgml
	(cd tempdir;jade -t sgml -ihtml -d $(cygnusdsl)\#html bog.sgml)
	mkdir $(targetshortname)
	cp tempdir/*.html $(targetshortname)
	for dir in $(SUBDIRS); do \
		cp ../$$dir/images/*.png $(targetshortname); \
	done;
	cp linuxbog.css $(targetshortname)
	ln -s alle bog
	rm -rf tempdir
	echo %define buildname $(targetshortname) > $(targetshortname)/$(targetname).spec
	echo Name: linuxbog-$(targetshortname) >> $(targetshortname)/$(targetname).spec
	echo Summary: `grep -A2 "<title>" ../friheden/indhold.sgml | head -n 1 | cut -d '>' -f 2 | cut -d '<' -f 1` >> $(targetshortname)/$(targetname).spec
	echo Version: `cat ../friheden/version.sgml` >> $(targetshortname)/$(targetname).spec
	echo Release: 1mdk >>  $(targetshortname)/$(targetname).spec
	cat ../linuxbog.spec >> $(targetshortname)/$(targetname).spec

ifeq	($(shell perl -e 'use Image::Size; print "1"' 2> /dev/null), 1)
	(cd $(targetshortname);perl ../../misc/insertimagesize)
else
	@echo Du bør installere Perl-modulet Image::Size.
endif
ifeq	($(shell if which tidy >/dev/null 2>&1; then echo -n 1; fi;), 1)
	(cd $(targetshortname);tidy -f err.txt -imu *html;rm -f err.txt)
else
	@echo Du bør installere tidy.
endif


pakhtml: $(targetname)-$(version).html.tar.gz $(targetname)-$(version).html-ub.tar.gz $(targetname)-$(version).png.tar.gz $(targetname)-$(version)_html.zip

$(targetname)-$(version).html.tar.gz: alle/index.html 
	tar czf $(targetname)-$(version).html.tar.gz $(targetshortname)

$(targetname)-$(version).html-ub.tar.gz: alle/index.html 
	tar czf $(targetname)-$(version).html-ub.tar.gz $(targetshortname)/*.html $(targetshortname)/*.css

$(targetname)-$(version).png.tar.gz: alle/index.html 
	tar czf $(targetname)-$(version).png.tar.gz $(targetshortname)/*.png

$(targetname)-$(version)_html.zip: alle/index.html 
	zip $(targetname)-$(version)_html.zip $(targetshortname)/*


pspdf:	$(targetname)-$(version)_pdf.zip
$(targetname)-$(version)_pdf.zip: statusfiles
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
	for dir in $(SUBDIRS); do \
		cp ../$$dir/images/*.png bogpdf; \
	done;
	(cd bogpdf; db2pdf bog.sgml )
	mv bogpdf/bog.pdf $(targetname)-$(version).pdf
	pdfinfo $(targetname)-$(version).pdf | grep Pages: | cut -d':' -f2 > sideantal.txt
	zip $(targetname)-$(version)_pdf.zip $(targetname)-$(version).pdf
	@echo "Done PDF (pspdf)"
	@echo ""

test:
	echo $(sgmlfiler)

.PHONY clean:
	rm -rf version.sgml dato.sgml magic.sgml bog DBTOHTML_OUTPUT_DIR* bog.junk html stikord.sgml tempdir bogps bogpdf $(targetname)* $(targetshortname) palm/*.prc palm/*.pdb sideantal.txt images 	*~*~  .#*[0-9]


