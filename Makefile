# $Id$
all: Makefiler filer

release : cvs2html eksempler filer  mail

Makefiler:
	cp Makefile.subdir friheden/Makefile
	cp Makefile.subdir applikationer/Makefile
	cp Makefile.subdir admin/Makefile
	cp Makefile.subdir program/Makefile
	cp Makefile.subdir web/Makefile
	cp Makefile.subdir sikkerhed/Makefile
	cp Makefile.subdir c/Makefile

filer:  Makefiler
	make Makefiler
	make -C friheden
	make -C applikationer
	make -C admin
	make -C program
	make -C web
	make -C sikkerhed
	make -C c
	make -C alle 

statusfiler:  Makefiler
	make -C friheden statusfiler
	make -C applikationer  statusfiler
	make -C admin  statusfiler
	make -C program  statusfiler
	make -C web  statusfiler
	make -C sikkerhed  statusfiler
	make -C c  statusfiler
	make -C alle  statusfiler


clean: Makefiler
	make -C friheden clean
	make -C applikationer clean
	make -C admin clean 
	make -C program clean
	make -C web clean 
	make -C sikkerhed clean 
	make -C c clean 
	make -C alle clean 
	rm -rf cvs2html
	rm -rf Friheden_palm.tgz 

cvs2html:
	chmod +x /home/pto/utils/cvs2html
	rm -rf cvs2html
	mkdir cvs2html
	/home/pto/utils/cvs2html  -l http://cvs.sslug.dk/linuxbog -f -p -o cvs2html/index.html -v -a -b -n 6 -C cvs_crono.html


mail:
	echo "Nu gik oversættelse af bøger på tyge fint igennem. Du gør det godt. Have a nice day" | mail -s "automatisk mail: bog OK" linuxbog@sslug.dk
