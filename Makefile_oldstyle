# $Id$

SUBDIRS = friheden unix applikationer admin program web sikkerhed c dokumentation kontorbruger itplatform java

all: filer

release : cvs2html filer 

start:
	@for dir in $(SUBDIRS); do \
		cp -f Makefile.subdir $$dir/Makefile; \
		cp faelles-filer/*.sgml $$dir; \
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

cvs2html:
	chmod +x /home/pto/utils/cvs2html
	rm -rf cvs2html
	mkdir cvs2html
	/home/pto/utils/cvs2html -i ../linux.png  -l http://cvs.sslug.dk/linuxbog -f -p -o cvs2html/index.html -v -a -b -D 30 -C cvs_crono.html


mail:
#	@echo "Nu er der nye bøger på tyge. Have a nice day" | mail -s "automatisk mail: bog OK" linuxbog@sslug.dk
