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

sgml: $(sgmlfiler) $(targetname)-sgml-$(version).tar.gz $(targetname)-sgml-$(version).zip


$(targetname)-sgml-$(version).tar.gz:
	(cd ..;tar cvzf $(targetshortname)/$(targetname)-sgml-$(version).tar.gz $(targetshortname)/*.sgml $(targetshortname)/Makefile $(targetshortname)/collateindex.pl)

$(targetname)-sgml-$(version).zip:
	(cd ..;zip $(targetshortname)/$(targetname)-sgml-$(version).zip -r $(targetshortname)/*.sgml $(targetshortname)/Makefile $(targetshortname)/collateindex.pl )

palmpilot: $(targetname)-palm-$(version).zip

$(targetname)-palm-$(version).zip: alle/index.html
	rm -f palm/*.prc palm/*.pdb
	(cd palm;plucker-build -v -P . -f $(targetname))
	cp ../misc/*.prc palm
	zip $(targetname)-palm-$(version).zip palm/*.prc palm/*.pdb
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


pakhtml: $(targetname)-html-$(version).tar.gz $(targetname)-htmlub-$(version).tar.gz $(targetname)-png-$(version).tar.gz $(targetname)-html-$(version).zip

$(targetname)-html-$(version).tar.gz: alle/index.html 
	tar czf $(targetname)-html-$(version).tar.gz $(targetshortname)

$(targetname)-htmlub-$(version).tar.gz: alle/index.html 
	tar czf $(targetname)-htmlub-$(version).tar.gz $(targetshortname)/*.html $(targetshortname)/*.css

$(targetname)-png-$(version).tar.gz: alle/index.html 
	tar czf $(targetname)-png-$(version).tar.gz $(targetshortname)/*.png

$(targetname)-html-$(version).zip: alle/index.html 
	zip $(targetname)-html-$(version).zip $(targetshortname)/*


test:
	echo $(sgmlfiler)

.PHONY clean:
	rm -rf version.sgml dato.sgml magic.sgml bog DBTOHTML_OUTPUT_DIR* bog.junk html stikord.sgml tempdir bogps bogpdf $(targetname)* $(targetshortname) palm/*.prc palm/*.pdb sideantal.txt images 	*~*~  .#*[0-9]


