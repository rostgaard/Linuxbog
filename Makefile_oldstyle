# $Id$

SUBDIRS = friheden unix wm applikationer admin program web sikkerhed c dokumentation forsker kontorbruger itplatform java signatur

# version - skal bruges til samlingerne (i øjeblikket kun palm)
version:=$(shell (cd friheden; grep -A2 "<listitem>" apprevhist.sgml | head -n 2 | tail -n 1 | cut -d' ' -f2 > ../samling/version.sgml; cat ../samling/version.sgml))

all: cvs2htmlweb filer palmpilot-samling

start:
	@for dir in $(SUBDIRS); do \
		cp -f Makefile.subdir $$dir/Makefile; \
		cp -f faelles-filer/*.sgml $$dir; \
		cp -f faelles-filer/*.css $$dir; \
		cp linuxbog.spec $$dir; \
		make -C $$dir start; \
		make -C $$dir ekstra; \
	done;
	echo "Installerer Makefiler og fælles SGML-filer til alle bøger"

filer:  start
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir; \
	done;
	$(MAKE) -C alle -f Makefile

pspdf:	start
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir pspdf; \
	done;

	$(MAKE) -C alle -f Makefile pspdf

html:	start
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir html; \
	done;

	$(MAKE) -C alle -f Makefile html

palmpilot: palmpilot-hver-enkelt
	$(MAKE) -C alle -f Makefile palmpilot

palmpilot-hver-enkelt: start
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir palmpilot; \
	done;

palmpilot-samling: palmpilot-hver-enkelt
	mkdir -p samling/palm-samling
	@for dir in $(SUBDIRS); do \
		cp $$dir/palm/linuxbog-$$dir.pdb samling/palm-samling/; \
	done;
	cp misc/*.prc samling/palm-samling/
	(cd samling; tar vczf linuxbog-samling-palm-$(version).tar.gz palm-samling/)
	(cd samling; zip -r linuxbog-samling-palm-$(version).zip palm-samling/)

eksempelbackup:
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir eksempelbackup; \
	done;

clean: start
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
		rm -f $$dir/Makefile; \
		rm -f $$dir/linuxbog-$$dir.spec; \
	done;

	$(MAKE) -C alle -f Makefile clean

	rm -rf cvs2html
	rm -rf Friheden_palm.tgz
	rm -f dato.sgml version.sgml
	rm -f *~*~  .#*[0-9]
	rm -rf palm-samling

cvs2htmlweb:
ifeq	($(shell if which cvs2html >/dev/null 2>&1; then echo -n 1; fi;), 1)
	rm -rf cvs2html
	mkdir cvs2html
	cvs2html -i ../linux.png  -l http://cvs.linuxbog.dk -f -p -o cvs2html/index.html -v -a -b -D 30 -C cvs_crono.html
endif

mail:
#	@echo "Nu er der nye bøger på tyge. Have a nice day" | mail -s "automatisk mail: bog OK" linuxbog@sslug.dk
