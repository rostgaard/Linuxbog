# $Id$

SUBDIRS = friheden unix wm applikationer admin program web sikkerhed c dokumentation forsker kontorbruger itplatform java signatur

# version - skal bruges til samlingerne (i øjeblikket kun palm)
version:=$(shell (cd ../friheden; grep -A2 "<listitem>" apprevhist.sgml | head -n 2 | tail -n 1 | cut -d' ' -f2 > ../samling/version.sgml; cat ../samling/version.sgml))

all: palmpilot pspdf

pspdf:	ps pdf

ps:
	mkdir ps-samling
	@for dir in $(SUBDIRS); do \
		cp ../$$dir/linuxbog-$$dir-`cat ../$$dir/version.sgml`.ps ps-samling/ || /bin/true; \
	done;
	tar vczf linuxbog-samling-ps-$(version).tar.gz ps-samling/

pdf:
	mkdir pdf-samling
	@for dir in $(SUBDIRS); do \
		cp ../$$dir/linuxbog-$$dir-`cat ../$$dir/version.sgml`.pdf pdf-samling/ || /bin/true; \
	done;
	tar vczf linuxbog-samling-pdf-$(version).tar.gz pdf-samling/

palmpilot:
	mkdir -p palm-samling
	@for dir in $(SUBDIRS); do \
		cp ../$$dir/palm/linuxbog-$$dir.pdb palm-samling/ || /bin/true; \
	done;
	cp ../misc/*.prc palm-samling/
	tar vczf linuxbog-samling-palm-$(version).tar.gz palm-samling/
	zip -r linuxbog-samling-palm-$(version).zip palm-samling/

clean: 
	rm -fr palm-samling
#	rm -fr ps-samling
	rm -fr pdf-samling

	rm linuxbog-samling-*.tar.gz

	rm -f version.sgml
	rm -f *~*~  .#*[0-9]
