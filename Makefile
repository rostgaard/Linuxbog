all: clean Makefiler statusfiler html palmpilot pspdf sgml cvs2html mail

Makefiler:
	cp Makefile.subdir friheden/Makefile
	cp Makefile.subdir admin/Makefile
	cp Makefile.subdir program/Makefile
	cp Makefile.subdir web/Makefile
	cp Makefile.subdir sikkerhed/Makefile

statusfiler:
	make Makefiler
	make -C friheden statusfiler
	make -C admin statusfiler 
	make -C program statusfiler
	make -C web statusfiler 
	make -C sikkerhed statusfiler 

sgml: Makefiler
	make -C friheden sgml
	make -C admin sgml 
	make -C program sgml
	make -C web sgml 
	make -C sikkerhed sgml 

html: Makefiler
	make -C friheden html
	make -C admin html 
	make -C program html
	make -C web html 
	make -C sikkerhed html 

palmpilot: Makefiler
	make -C friheden palmpilot
	make -C admin palmpilot 
	make -C program palmpilot
	make -C web palmpilot 
	make -C sikkerhed palmpilot 
	       
	       
pspdf:  Makefiler       
	make -C friheden pspdf
	make -C admin pspdf 
	make -C program pspdf
	make -C web pspdf 
	make -C sikkerhed pspdf 
	       
	       
clean: Makefiler
	make -C friheden clean
	make -C admin clean 
	make -C program clean
	make -C web clean 
	make -C sikkerhed clean 
	rm -f friheden/Makefile
	rm -f admin/Makefile
	rm -f web/Makefile
	rm -f program/Makefile
	rm -f sikkerhed/Makefile
	rm -rf cvs2html

cvs2html:
	chmod +x /home/pto/utils/cvs2html
	rm -rf /home/www/www.sslug.dk/bog/cvs2html
	mkdir /home/www/www.sslug.dk/bog/cvs2html
	/home/pto/utils/cvs2html  -l http://www.sslug.dk/bog -f -p -o /home/www/www.sslug.dk/bog/cvs2html/index.html -v -a -b -n 6 -C cvs_crono.html


mail:
	echo "Done bøger" | mail $(USER)-mobil
