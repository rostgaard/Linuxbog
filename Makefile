# $Id$
all: Makefiler filer

release : version cvs2html filer 

Makefiler:
	cp Makefile.subdir friheden/Makefile
	cp Makefile.subdir applikationer/Makefile
	cp Makefile.subdir admin/Makefile
	cp Makefile.subdir program/Makefile
	cp Makefile.subdir web/Makefile
	cp Makefile.subdir sikkerhed/Makefile
	cp Makefile.subdir c/Makefile
	cp Makefile.subdir docbook/Makefile
	cp Makefile.subdir kontorbruger/Makefile
	cp Makefile.subdir itplatform/Makefile

filer:  Makefiler
	$(MAKE) Makefiler
	$(MAKE) -C friheden
	$(MAKE) -C applikationer
	$(MAKE) -C admin
	$(MAKE) -C program
	$(MAKE) -C web
	$(MAKE) -C sikkerhed
	$(MAKE) -C c
	$(MAKE) -C docbook
	$(MAKE) -C kontorbruger
	$(MAKE) -C itplatform
	$(MAKE) -C alle 

pspdf:	Makefiler
	$(MAKE) -C friheden      pspdf
	$(MAKE) -C applikationer pspdf
	$(MAKE) -C admin         pspdf
	$(MAKE) -C program       pspdf
	$(MAKE) -C web           pspdf
	$(MAKE) -C sikkerhed     pspdf
	$(MAKE) -C c             pspdf
	$(MAKE) -C docbook       pspdf
	$(MAKE) -C kontorbruger  pspdf
	$(MAKE) -C itplatform    pspdf
	$(MAKE) -C alle          pspdf

statusfiler:  Makefiler
	$(MAKE) -C friheden statusfiler
	$(MAKE) -C applikationer  statusfiler
	$(MAKE) -C admin  statusfiler
	$(MAKE) -C program  statusfiler
	$(MAKE) -C web  statusfiler
	$(MAKE) -C sikkerhed  statusfiler
	$(MAKE) -C c  statusfiler
	$(MAKE) -C docbook  statusfiler
	$(MAKE) -C kontorbruger  statusfiler
	$(MAKE) -C itplatform  statusfiler
	$(MAKE) -C alle  statusfiler

version:  Makefiler
	@grep -A2 "<listitem>" friheden/apprevhist.sgml | head -n 2 | tail -n 1 | cut -d' ' -f2 > friheden/version.sgml
	@grep -A2 "<listitem>" applikationer/apprevhist.sgml | head -n 2 | tail -n 1 | cut -d' ' -f2 > applikationer/version.sgml
	@grep -A2 "<listitem>" admin/apprevhist.sgml | head -n 2 | tail -n 1 | cut -d' ' -f2 > admin/version.sgml
	@grep -A2 "<listitem>" program/apprevhist.sgml | head -n 2 | tail -n 1 | cut -d' ' -f2 > program/version.sgml
	@grep -A2 "<listitem>" web/apprevhist.sgml | head -n 2 | tail -n 1 | cut -d' ' -f2 > web/version.sgml
	@grep -A2 "<listitem>" sikkerhed/apprevhist.sgml | head -n 2 | tail -n 1 | cut -d' ' -f2 > sikkerhed/version.sgml
	@grep -A2 "<listitem>" c/apprevhist.sgml | head -n 2 | tail -n 1 | cut -d' ' -f2 > c/version.sgml
	@grep -A2 "<listitem>" docbook/apprevhist.sgml | head -n 2 | tail -n 1 | cut -d' ' -f2 > docbook/version.sgml
	@grep -A2 "<listitem>" kontorbruger/apprevhist.sgml | head -n 2 | tail -n 1 | cut -d' ' -f2 >kontorbruger/version.sgml
	@grep -A2 "<listitem>" itplatform/apprevhist.sgml | head -n 2 | tail -n 1 | cut -d' ' -f2 >itplatform/version.sgml
	cp friheden/version.sgml alle/version.sgml
	@echo "friheden" `cat friheden/version.sgml`
	@echo "applikationer" `cat applikationer/version.sgml`
	@echo "admin" `cat admin/version.sgml`
	@echo "program" `cat program/version.sgml`
	@echo "web" `cat web/version.sgml`
	@echo "sikkerhed" `cat sikkerhed/version.sgml`
	@echo "c" `cat c/version.sgml`
	@echo "docbook" `cat docbook/version.sgml`
	@echo "kontorbruger" `cat kontorbruger/version.sgml`
	@echo "itplatform" `cat itplatform/version.sgml`

eksempelbackup:  statusfiler
	$(MAKE) -C friheden eksempelbackup
	$(MAKE) -C applikationer  eksempelbackup
	$(MAKE) -C admin  eksempelbackup
	$(MAKE) -C program  eksempelbackup
	$(MAKE) -C web  eksempelbackup
	$(MAKE) -C sikkerhed  eksempelbackup
	$(MAKE) -C c  eksempelbackup
	$(MAKE) -C docbook  eksempelbackup
	$(MAKE) -C kontorbruger  eksempelbackup
	$(MAKE) -C itplatform  eksempelbackup

clean: Makefiler
	$(MAKE) -C friheden clean
	$(MAKE) -C applikationer clean
	$(MAKE) -C admin clean 
	$(MAKE) -C program clean
	$(MAKE) -C web clean 
	$(MAKE) -C sikkerhed clean 
	$(MAKE) -C c clean 
	$(MAKE) -C docbook clean 
	$(MAKE) -C kontorbruger clean 
	$(MAKE) -C itplatform clean 
	$(MAKE) -C alle clean 
	rm -rf cvs2html
	rm -rf Friheden_palm.tgz 

cvs2html:
	chmod +x /home/pto/utils/cvs2html
	rm -rf cvs2html
	mkdir cvs2html
	/home/pto/utils/cvs2html -i ../linux.png  -l http://cvs.sslug.dk/linuxbog -f -p -o cvs2html/index.html -v -a -b -D 30 -C cvs_crono.html


mail:
	#@echo "Nu er der nye bøger på tyge. Have a nice day" | mail -s "automatisk mail: bog OK" linuxbog@sslug.dk
