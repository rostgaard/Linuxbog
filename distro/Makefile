# Lokalt katalog (fuld sti)
locdirname:=$(shell pwd)

# Kort navn
targetshortname:=$(notdir $(locdirname))

# Med linuxbog- foran
targetname:=linuxbog-$(notdir $(locdirname))

# version
version:=$(shell grep -A2 "<listitem>" apprevhist.sgml | head -n 2 | tail -n 1 | cut -d' ' -f2 > version.sgml; cat version.sgml)

# dato
dato:=$(shell date +%d/%m-%Y> dato.sgml; cat dato.sgml)

# Her er en liste af sgml-filer der ændres automatisk
badsgmlfiles=dato.sgml version.sgml magic.sgml stikord.sgml bogoversigt.sgml ophavsret.sgml

# Her er  en liste af alle sgml
allesgmlfiles:=$(wildcard *.sgml)

# Her er en liste af sgml-filer der skal checkes
sgmlfiler:=$(filter-out $(badsgmlfiles),$(allesgmlfiles))

# Her er  en liste af alle eksempler
alleeksfiles:=$(wildcard eksempler/*)

# Lokal Makefile ?
lokmake:=$(wildcard Makefile_local)

# Her er en liste af sgml-filer der skal checkes
eksfiler:=$(filter-out eksempler/CVS,$(alleeksfiles))

# Har vi Perl-modulet Image::Size installeret
imagesize:=$(wildcard /usr/lib/perl5/site_perl/5.005/Image/Size.pm)

# Har vi tidy installeret?
tidy:=$(wildcard /usr/bin/tidy)

################################################################################
# De egentlige targets
################################################################################

################################################################################
# her er det der skal laves
all: html





################################################################################
# Byg HTML-filerne
################################################################################

html: bog/index.html 
bog/index.html: $(sgmlfiler) 
	@echo ".........................................."
	@echo "Target $(targetshortname):html"
	@echo ".........................................."
	@@echo "Target er HTML i" $(targetshortname)/bog
	@echo '<!ENTITY linuxbogurl "cvs.linuxbog.dk">' > linuxbogurl.sgml
	rm -rf $(targetname)*
	rm -rf stikord.sgml magic.sgml $(targetname)-*.html.tar.gz bog
	@echo '<!ENTITY magic "png">' > magic.sgml
	collateindex.pl -s Symboler -t Stikordsregister -g -i stikord -N -o stikord.sgml
	jw -V html-index -f docbook -b html -o bog bog.sgml
	collateindex.pl -s Symboler -t Stikordsregister -g -i stikord  -o stikord.sgml bog/HTML.index
	rm -rf bog/
	mkdir bog
	db2html  -V  %use-id-as-filename%  bog.sgml
	cp images/*.png bog
ifeq	($(shell if which tidy >/dev/null 2>&1; then echo -n 1; fi;), 1)
	(cd bog;tidy -latin1 -f err.txt -imu *html;rm -f err.txt)
else
	@echo "Du bør installere tidy"
endif
	(cd bog;rm -f apprevhist.html;ln -sf *apprevhist.html apprevhist.html)
	rm -rf tempdir 
	@echo "Done HTML (html)"
	@echo ""

pdf: bog.pdf
bog.pdf: $(sgmlfiler)
	@echo ".........................................."
	@echo "Target $(targetshortname):pdf"
	@echo ".........................................."
	@echo '<!ENTITY magic "png">' > magic.sgml
	collateindex.pl  -s Symboler -t Stikordsregister -g -i stikord -N -o stikord.sgml
	rm -rf tempdir
	mkdir tempdir
	cp *.sgml tempdir
	cp images/*png tempdir
	(cd tempdir;jw -V html-index -V nochunks -f docbook -b html -o bog bog.sgml)
	(cd tempdir;collateindex.pl -s Symboler -t Stikordsregister -g -i stikord  -o stikord.sgml bog/HTML.index)
	@cd tempdir && \
	db2pdf -V %use-id-as-filename% bog.sgml ; \
	if test $$? -eq 9 ; then \
		echo Kører db2pdf igen ; \
		db2pdf -V %use-id-as-filename% bog.sgml ; \
		if test $$? -eq 9 ; then \
			echo Kører db2pdf igen ; \
			db2pdf -V %use-id-as-filename% bog.sgml ; \
			if test $$? -eq 9 ; then \
				true ; \
			fi \
		fi \
	fi
	mv tempdir/bog.pdf bog.pdf
	rm -rf tempdir
	@echo "Done PDF (pdf)"
	@echo ""





################################################################################
clean:
	@echo clean $(targetshortname)
	@rm -rf bog.pdf bog.log dato.sgml version.sgml linuxbogurl.sgml magic.sgml DBTOHTML_OUTPUT_DIR* bog.junk bog stikord.sgml tempdir bogps bogpdf $(targetname)*  palm/*.prc palm/*.pdb sideantal.txt *~*~ .#*[0-9]
ifeq ($(lokmake),Makefile_local)
	@echo X $(lokmake) X
	@make -f Makefile_local clean
else
	@echo "Ingen lokal Makefile"
endif
	@echo "Færdig med clean $(targetshortname)"

